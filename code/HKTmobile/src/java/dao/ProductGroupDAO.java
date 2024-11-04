/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.BrandDTO;
import dto.ProductDTO;
import dto.ProductGroupDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;

import java.util.List;

import utils.DBUtils;

/**
 *
 * @author Admin
 */
public class ProductGroupDAO {

    BrandDAO dao = new BrandDAO();
    public List<ProductGroupDTO> searchlist(String brandName, int ram, int storage, String sortBy, String sortType, double pricemin, double pricemax, String keyword, int pageNum) {
        List<ProductGroupDTO> list = new ArrayList<ProductGroupDTO>();

        try {
            Connection con = DBUtils.getConnection();
            String sql = " WITH NumberedGroups AS ("
                    + "        SELECT pg.GroupID, pg.ProductName,p.ProductID ,pg.BrandID, pg.[Description], pg.img, pg.Discount, p.Price, b.BrandName,"
                    + "               ROW_NUMBER() OVER (PARTITION BY pg.GroupID ORDER BY pg.GroupID) AS RowNum "
                    + "               , (p.Price-(p.Price*pg.Discount/100)) as NewPrice"
                    + "        FROM ProductGroup pg "
                    + "        FULL JOIN Product p ON pg.GroupID = p.GroupID "
                    + "        JOIN Brand b ON pg.BrandID = b.BrandID ";

            boolean hasCondition = false;
            if (keyword != null && !keyword.isEmpty()) {
                sql += "  WHERE pg.ProductName like ? ";
                hasCondition = true;
            }

            if (ram != 0) {
                if (hasCondition) {
                    sql += " AND ";
                } else {
                    sql += " WHERE  ";
                    hasCondition = true;
                }
                sql += "p.RAM = ?";
            }
            if (storage != 0) {
                if (hasCondition) {
                    sql += " AND ";
                } else {
                    sql += "  WHERE ";
                    hasCondition = true;
                }
                sql += " p.Storage = ? ";
            }
            if (brandName != null && !brandName.isEmpty()) {
                if (hasCondition) {
                    sql += " AND ";
                } else {
                    sql += "  WHERE ";
                    hasCondition = true;
                }
                sql += " b.BrandName LIKE ? ";
            }

            if (pricemin > 0 && pricemax > 0) {
                if (hasCondition) {
                    sql += " AND ";
                } else {
                    sql += "  WHERE ";
                    hasCondition = true;
                }
                sql += " p.Price BETWEEN ? AND ? ";
            }

            sql += ") SELECT GroupID, ProductName, Brandid, [Description], img, Discount, Price, BrandName, NewPrice, ProductID "
                    + " FROM NumberedGroups WHERE RowNum = 1 ";

            if (sortBy != null && !sortBy.isEmpty()) {
                sql += " ORDER BY " + sortBy + " " + sortType + " ";
            } else {
                sql += " ORDER BY GroupID DESC ";
            }
            sql += "OFFSET ? ROWS FETCH NEXT 6 ROWS ONLY;";
            PreparedStatement stmt = con.prepareStatement(sql);

            int parameterIndex = 1;
            if (keyword != null && !keyword.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + keyword + "%");
            }
            if (ram != 0) {
                stmt.setInt(parameterIndex++, ram);

            }
            if (storage != 0) {
                stmt.setInt(parameterIndex++, storage);
            }

            if (brandName != null && !brandName.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + brandName + "%");
            }

            if (pricemin > 0 && pricemax > 0) {
                stmt.setDouble(parameterIndex++, pricemin);
                stmt.setDouble(parameterIndex++, pricemax);
            }
            stmt.setInt(parameterIndex++, pageNum);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                ProductGroupDTO productGroup = new ProductGroupDTO();
                ProductDTO product = new ProductDTO();
                productGroup.setGroupID(rs.getInt("GroupID"));
                productGroup.setProductName(rs.getString("ProductName"));
                productGroup.setBrandName(dao.load(rs.getInt("Brandid")).getBrandName());
                productGroup.setDescription(rs.getString("Description"));
                productGroup.setImg(rs.getString("img"));
                productGroup.setDiscount(rs.getInt("Discount"));

                product.setProductID(rs.getInt("ProductID"));
                product.setPrice(rs.getInt("Price"));
                product.setNewPrice(rs.getInt("NewPrice"));
                List<ProductDTO> productList = new ArrayList<ProductDTO>();
                productList.add(product);
                productGroup.setProducts(productList);
                list.add(productGroup);
            }
            con.close();
        } catch (SQLException ex) {
            System.out.println("Error in servlet. Details:" + ex.getMessage());
            ex.printStackTrace();
        }
        return list;
    }

    public List<ProductGroupDTO> searchlist4(ProductGroupDTO group, int ram, int storage,int discount) {
        List<ProductGroupDTO> list = new ArrayList<ProductGroupDTO>();

        try {
            Connection con = DBUtils.getConnection();
            String sql = " WITH NumberedGroups AS ("
                    + "        SELECT pg.GroupID, pg.ProductName,p.ProductID ,pg.BrandID, pg.[Description], pg.img, pg.Discount, p.Price, b.BrandName,"
                    + "               ROW_NUMBER() OVER (PARTITION BY pg.GroupID ORDER BY pg.GroupID) AS RowNum "
                    + "               , (p.Price-(p.Price*pg.Discount/100)) as NewPrice"
                    + "        FROM ProductGroup pg "
                    + "        JOIN Product p ON pg.GroupID = p.GroupID "
                    + "        JOIN Brand b ON pg.BrandID = b.BrandID ";

            boolean hasCondition = false;

            if (ram != 0) {
                if (hasCondition) {
                    sql += " AND ";
                } else {
                    sql += " WHERE  ";
                    hasCondition = true;
                }
                sql += "p.RAM = ?";
            }
            if (storage != 0) {
                if (hasCondition) {
                    sql += " AND ";
                } else {
                    sql += "  WHERE ";
                    hasCondition = true;
                }
                sql += " p.Storage = ? ";
            }

            if (group.getBrandId() != 0) {
                if (hasCondition) {
                    sql += " AND ";
                } else {
                    sql += "  WHERE pg.BrandID = ?";
                    hasCondition = true;
                }
                sql += " pg.BrandID = ? ";
            }
            if (group.getGroupID() != 0) {
                if (hasCondition) {
                    sql += " AND ";
                } else {
                    sql += "  WHERE ";
                    hasCondition = true;
                }
                sql += " pg.GroupID <> ? ";
            }
            if (discount != 0) {
                if (hasCondition) {
                    sql += " AND ";
                } else {
                    sql += " WHERE  ";
                    hasCondition = true;
                }
                sql += "pg.Discount != 0";
            }

            sql += ") SELECT TOP(4) GroupID, ProductName, Brandid, [Description], img, Discount, Price, BrandName, NewPrice, ProductID "
                    + " FROM NumberedGroups WHERE RowNum = 1 Order by GroupID DESC";

            PreparedStatement stmt = con.prepareStatement(sql);

            int parameterIndex = 1;

            if (ram != 0) {
                stmt.setInt(parameterIndex++, ram);

            }
            if (storage != 0) {
                stmt.setInt(parameterIndex++, storage);
            }

            if (group.getBrandId() != 0) {
                stmt.setInt(parameterIndex++, group.getBrandId());
            }

            if (group.getGroupID() != 0) {
                stmt.setInt(parameterIndex++, group.getGroupID());
            }
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ProductGroupDTO productGroup = new ProductGroupDTO();
                ProductDTO product = new ProductDTO();
                productGroup.setGroupID(rs.getInt("GroupID"));
                productGroup.setProductName(rs.getString("ProductName"));
                productGroup.setBrandName(dao.load(rs.getInt("Brandid")).getBrandName());
                productGroup.setDescription(rs.getString("Description"));
                productGroup.setImg(rs.getString("img"));
                productGroup.setDiscount(rs.getInt("Discount"));

                product.setProductID(rs.getInt("ProductID"));
                product.setPrice(rs.getInt("Price"));
                product.setNewPrice(rs.getInt("NewPrice"));
                List<ProductDTO> productList = new ArrayList<ProductDTO>();
                productList.add(product);
                productGroup.setProducts(productList);
                list.add(productGroup);
            }
            con.close();
        } catch (SQLException ex) {
            System.out.println("Error in servlet. Details:" + ex.getMessage());
            ex.printStackTrace();
        }
        return list;
    }

    public int listNum(String brandName, int ram, int storage, double pricemin, double pricemax, String keyword) {
        int total = 0;

        try {
            Connection con = DBUtils.getConnection();
            String sql = " "
                    + "    SELECT count(*)as count "
                    + "    FROM ( "
                    + "        SELECT pg.GroupID,"
                    + "               ROW_NUMBER() OVER (PARTITION BY pg.GroupID ORDER BY pg.GroupID) AS RowNum "
                    + "        FROM ProductGroup pg "
                    + "        JOIN Product p ON pg.GroupID = p.GroupID "
                    + "        JOIN Brand b ON pg.BrandID = b.BrandID ";

            boolean hasCondition = false;
            if (keyword != null && !keyword.isEmpty()) {
                sql += "  WHERE pg.ProductName like ? ";
                hasCondition = true;
            }

            if (ram != 0) {
                if (hasCondition) {
                    sql += " AND ";
                } else {
                    sql += " WHERE p.RAM = ? ";
                    hasCondition = true;
                }
            }
            if (storage != 0) {
                if (hasCondition) {
                    sql += " AND ";
                } else {
                    sql += "  WHERE ";
                    hasCondition = true;
                }
                sql += " p.Storage = ? ";
            }
            if (brandName != null && !brandName.isEmpty()) {
                if (hasCondition) {
                    sql += " AND ";
                } else {
                    sql += "  WHERE ";
                    hasCondition = true;
                }
                sql += " b.BrandName LIKE ? ";
            }

            if (pricemin > 0 && pricemax > 0) {
                if (hasCondition) {
                    sql += " AND ";
                } else {
                    sql += "  WHERE ";
                    hasCondition = true;
                }
                sql += " p.Price BETWEEN ? AND ? ";
            }

            sql += ") AS subquery WHERE RowNum = 1 ";

            PreparedStatement stmt = con.prepareStatement(sql);

            int parameterIndex = 1;
            if (keyword != null && !keyword.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + keyword + "%");
            }
            if (ram != 0) {
                stmt.setInt(parameterIndex++, ram);

            }
            if (storage != 0) {
                stmt.setInt(parameterIndex++, storage);
            }

            if (brandName != null && !brandName.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + brandName + "%");
            }

            if (pricemin > 0 && pricemax > 0) {
                stmt.setDouble(parameterIndex++, pricemin);
                stmt.setDouble(parameterIndex++, pricemax);
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                total = rs.getInt("count");
            }
            con.close();
        } catch (SQLException ex) {
            System.out.println("Error in servlet. Details:" + ex.getMessage());
            ex.printStackTrace();
        }
        return total;
    }

    public ProductGroupDTO load(int id) {
        ProductGroupDTO productGroup = null;
        try {
            Connection con = DBUtils.getConnection();
            String sql = " SELECT groupID,  productName,  Brandid,  description,  img,  discount "
                    + " FROM ProductGroup "
                    + " WHERE groupID = ?";
            PreparedStatement stmt = con.prepareStatement(sql);

            stmt.setInt(1, id);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                productGroup = new ProductGroupDTO();
                productGroup.setGroupID(rs.getInt("GroupID"));
                productGroup.setProductName(rs.getString("ProductName"));
                productGroup.setBrandId(rs.getInt("Brandid"));
                productGroup.setBrandName(dao.load(rs.getInt("Brandid")).getBrandName());
                productGroup.setImg(rs.getString("img"));
                productGroup.setDescription(rs.getString("Description"));
                productGroup.setDiscount(rs.getInt("Discount"));

            }
            con.close();
        } catch (SQLException e) {

        }
        return productGroup;
    }

    public void insert(ProductGroupDTO product) {
        String sql = " INSERT INTO [ProductGroup] (ProductName, img, BrandID, [Description]) "
                + " VALUES (?,?,?,?)";
        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, product.getProductName());
            stmt.setString(2, product.getImg());
            stmt.setInt(3, product.getBrandId());
            stmt.setString(4, product.getDescription());
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Group");
            System.out.println(e.getMessage());
        }
    }

    public void update(ProductGroupDTO product) {
        String sql = " UPDATE ProductGroup "
                + " SET "
                + "    ProductName = ?,"
                + "    BrandID = ?,"
                + "    [Description] = ?,"
                + "    img = ?"
                + " WHERE "
                + "    GroupID = ?;";
         try {
             
            Connection con = DBUtils.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, product.getProductName());                        
            stmt.setInt(2, product.getBrandId());
            stmt.setString(3, product.getDescription());           
            stmt.setString(4, product.getImg());
            stmt.setInt(5, product.getGroupID());
            
            stmt.executeUpdate();

        } catch (SQLException e) {
             System.out.println(e.getMessage());
        }
    }
    public ProductGroupDTO loadByName(String name) {
        ProductGroupDTO productGroup = null;
        try {
            Connection con = DBUtils.getConnection();
            String sql = " SELECT groupID,  productName,  Brandid,  description,  img,  discount "
                    + " FROM ProductGroup "
                    + " WHERE productName like ? ";
            PreparedStatement stmt = con.prepareStatement(sql);

            stmt.setString(1, name);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                productGroup = new ProductGroupDTO();
                productGroup.setGroupID(rs.getInt("GroupID"));
                productGroup.setProductName(rs.getString("ProductName"));
                productGroup.setBrandId(rs.getInt("Brandid"));
                productGroup.setBrandName(dao.load(rs.getInt("Brandid")).getBrandName());
                productGroup.setImg(rs.getString("img"));
                productGroup.setDescription(rs.getString("Description"));
                productGroup.setDiscount(rs.getInt("Discount"));

            }
            con.close();
        } catch (SQLException e) {

        }
        return productGroup;
    }

    public ArrayList<ProductGroupDTO> getProductGroupByGroupID(int id) { // lấy từ 2 bảng ProductGroup với Brand bởi GroupID
        String sql = "select  pg.GroupID,pg.ProductName,pg.Description,pg.img,pg.Discount,b.BrandID,b.BrandName  from ProductGroup pg \n"
                + "full join Brand b on pg.BrandID=b.BrandID where pg.GroupID = ? ";
        try (Connection con = DBUtils.getConnection();
                PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            ArrayList<ProductGroupDTO> productGroupDTO = new ArrayList<>();
            while (rs.next()) {
                ArrayList<BrandDTO> brands = (new BrandDAO().getBrandByBrandID(rs.getInt("brandID")));
                productGroupDTO.add(new ProductGroupDTO(rs.getInt("groupID"), rs.getString("productName"), rs.getInt("brandID"), rs.getString("description"), rs.getString("img"), rs.getInt("discount"), brands));
                System.out.println("discount ne");            
                System.out.println(rs.getInt("discount"));

            }
            return productGroupDTO;

        } catch (SQLException ex) {
            System.out.println("Lỗi lấy database ở getProductGroupByGroupID của ProductGroupDAO");
            System.out.println(ex.getMessage());
        }
        return null;
    }
    
  
public ArrayList<ProductGroupDTO> getProductGroupByID (int id ){
    String sql = "select * from ProductGroup where GroupID = ? "; 
    try(Connection con = DBUtils.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql)){
        ArrayList<ProductGroupDTO> productGroup = new ArrayList<>();
        ResultSet rs = stmt.executeQuery();
        while(rs.next()){
            productGroup.add(new ProductGroupDTO(rs.getInt("groupID"), rs.getString("productName"), rs.getInt("brandID"), rs.getString("description"), rs.getString("img"), rs.getInt("discount")));
        }
        return productGroup;
    }catch(SQLException ex){
        ex.printStackTrace();
    }
    return null ; 
}

    
    public void deleteByGroupID(int groupID) {
    String sql = "DELETE FROM [ProductGroup] WHERE GroupID = ?";
    
    try {
        Connection con = DBUtils.getConnection();
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setInt(1, groupID);
        
        int rowsAffected = stmt.executeUpdate();
        if (rowsAffected > 0) {
            System.out.println("Đã xóa sản phẩm có GroupID = " + groupID);
        } else {
            System.out.println("Không tìm thấy sản phẩm có GroupID = " + groupID + " để xóa");
        }

    } catch (SQLException e) {
        System.out.println("Lỗi khi xóa sản phẩm:");
        System.out.println(e.getMessage());
    }
    

        
    }    
    public void updateDiscount(int discount, int id) {
        String sql = "UPDATE [ProductGroup] SET Discount = ? WHERE GroupID= ?";
         try {
        Connection con = DBUtils.getConnection();
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setInt(1, discount);
        stmt.setInt(2, id);
        
        stmt.executeUpdate();

    } catch (SQLException e) {

    }
    }
    
    public List<ProductGroupDTO> searchlistUser(String brandName, int ram, int storage, String sortBy, String sortType, double pricemin, double pricemax, String keyword, int pageNum) {
        List<ProductGroupDTO> list = new ArrayList<ProductGroupDTO>();

        try {
            Connection con = DBUtils.getConnection();
            String sql = " WITH NumberedGroups AS ("
                    + "        SELECT pg.GroupID, pg.ProductName,p.ProductID ,pg.BrandID, pg.[Description], pg.img, pg.Discount, p.Price, b.BrandName,"
                    + "               ROW_NUMBER() OVER (PARTITION BY pg.GroupID ORDER BY pg.GroupID) AS RowNum "
                    + "               , (p.Price-(p.Price*pg.Discount/100)) as NewPrice"
                    + "        FROM ProductGroup pg "
                    + "        JOIN Product p ON pg.GroupID = p.GroupID "
                    + "        JOIN Brand b ON pg.BrandID = b.BrandID ";

            boolean hasCondition = false;
            if (keyword != null && !keyword.isEmpty()) {
                sql += "  WHERE pg.ProductName like ? ";
                hasCondition = true;
            }

            if (ram != 0) {
                if (hasCondition) {
                    sql += " AND ";
                } else {
                    sql += " WHERE  ";
                    hasCondition = true;
                }
                sql += "p.RAM = ?";
            }
            if (storage != 0) {
                if (hasCondition) {
                    sql += " AND ";
                } else {
                    sql += "  WHERE ";
                    hasCondition = true;
                }
                sql += " p.Storage = ? ";
            }
            if (brandName != null && !brandName.isEmpty()) {
                if (hasCondition) {
                    sql += " AND ";
                } else {
                    sql += "  WHERE ";
                    hasCondition = true;
                }
                sql += " b.BrandName LIKE ? ";
            }

            if (pricemin > 0 && pricemax > 0) {
                if (hasCondition) {
                    sql += " AND ";
                } else {
                    sql += "  WHERE ";
                    hasCondition = true;
                }
                sql += " p.Price BETWEEN ? AND ? ";
            }

            sql += ") SELECT GroupID, ProductName, Brandid, [Description], img, Discount, Price, BrandName, NewPrice, ProductID "
                    + " FROM NumberedGroups WHERE RowNum = 1 ";

            if (sortBy != null && !sortBy.isEmpty()) {
                sql += " ORDER BY " + sortBy + " " + sortType + " ";
            } else {
                sql += " ORDER BY GroupID DESC ";
            }
            sql += "OFFSET ? ROWS FETCH NEXT 6 ROWS ONLY;";
            PreparedStatement stmt = con.prepareStatement(sql);

            int parameterIndex = 1;
            if (keyword != null && !keyword.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + keyword + "%");
            }
            if (ram != 0) {
                stmt.setInt(parameterIndex++, ram);

            }
            if (storage != 0) {
                stmt.setInt(parameterIndex++, storage);
            }

            if (brandName != null && !brandName.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + brandName + "%");
            }

            if (pricemin > 0 && pricemax > 0) {
                stmt.setDouble(parameterIndex++, pricemin);
                stmt.setDouble(parameterIndex++, pricemax);
            }
            stmt.setInt(parameterIndex++, pageNum);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                ProductGroupDTO productGroup = new ProductGroupDTO();
                ProductDTO product = new ProductDTO();
                productGroup.setGroupID(rs.getInt("GroupID"));
                productGroup.setProductName(rs.getString("ProductName"));
                productGroup.setBrandName(dao.load(rs.getInt("Brandid")).getBrandName());
                productGroup.setDescription(rs.getString("Description"));
                productGroup.setImg(rs.getString("img"));
                productGroup.setDiscount(rs.getInt("Discount"));

                product.setProductID(rs.getInt("ProductID"));
                product.setPrice(rs.getInt("Price"));
                product.setNewPrice(rs.getInt("NewPrice"));
                List<ProductDTO> productList = new ArrayList<ProductDTO>();
                productList.add(product);
                productGroup.setProducts(productList);
                list.add(productGroup);
            }
            con.close();
        } catch (SQLException ex) {
            System.out.println("Error in servlet. Details:" + ex.getMessage());
            ex.printStackTrace();
        }
        return list;
    }
}
