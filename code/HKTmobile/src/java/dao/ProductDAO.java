/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.ProductDTO;
import dto.ProductGroupDTO;
import dto.ProductImgDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author Admin
 */
public class ProductDAO {

    public List<ProductDTO> list(int id) {
        List<ProductDTO> list = new ArrayList<>();
        ProductImgDAO imgdao = new ProductImgDAO();
        try {
            Connection con = DBUtils.getConnection();
            String sql = " SELECT p.ProductID,pg.ProductName, p.GroupID, p.RAM, p.Storage,p.Price,p.Color, (p.Price-pg.Discount/100*p.Price) as NewPrice "
                    + " FROM Product p JOIN ProductGrou p pg ON p.GroupID=pg.GroupID "
                    + " WHERE p.GroupID= ?";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    ProductDTO product = new ProductDTO();
                    product.setGroupID(rs.getInt("GroupID"));
                    product.setProductID(rs.getInt("ProductID"));
                    product.setProductName(rs.getString("ProductName"));
                    product.setRam(rs.getInt("RAM"));
                    product.setStorage(rs.getInt("Storage"));
                    product.setColor(rs.getString("Color"));
                    product.setPrice(rs.getInt("Price"));
                    product.setNewPrice(rs.getInt("NewPrice"));
                    List<ProductImgDTO> imgList = imgdao.list(rs.getInt("ProductID"));
                    product.setProductImg(imgList);
                    list.add(product);
                }
            }
            con.close();
        } catch (SQLException e) {

        }
        return list;
    }

    public List<ProductDTO> listFirst(int id) {
        List<ProductDTO> list = new ArrayList<>();
        ProductImgDAO imgdao = new ProductImgDAO();

        String sql = "WITH RankedProducts AS ("
                + " SELECT p.ProductID, pg.ProductName, p.GroupID, p.RAM, p.Storage, p.Price, p.Color, "
                + " (p.Price - pg.Discount / 100 * p.Price) AS NewPrice, "
                + " ROW_NUMBER() OVER (PARTITION BY p.RAM, p.Storage ORDER BY pg.GroupID) AS RowNum "
                + " FROM Product p "
                + " JOIN ProductGroup pg ON p.GroupID = pg.GroupID "
                + " WHERE p.GroupID = ?";

        sql += " ) "
                + "SELECT ProductID, ProductName, GroupID, RAM, Storage, Price, Color, NewPrice "
                + "FROM RankedProducts "
                + "WHERE RowNum = 1";

        try (Connection con = DBUtils.getConnection();
                PreparedStatement stmt = con.prepareStatement(sql)) {

            int index = 1;
            stmt.setInt(index++, id);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ProductDTO product = new ProductDTO();
                    product.setGroupID(rs.getInt("GroupID"));
                    product.setProductID(rs.getInt("ProductID"));
                    product.setProductName(rs.getString("ProductName"));
                    product.setRam(rs.getInt("RAM"));
                    product.setStorage(rs.getInt("Storage"));
                    product.setColor(rs.getString("Color"));
                    product.setPrice(rs.getInt("Price"));
                    product.setNewPrice(rs.getInt("NewPrice"));

                    List<ProductImgDTO> imgList = imgdao.list(rs.getInt("ProductID"));
                    product.setProductImg(imgList);

                    list.add(product);
                }
            }
            con.close();
        } catch (SQLException e) {

        }

        return list;
    }

    public List<ProductDTO> list(int id, int ram, int storage) {
        List<ProductDTO> list = new ArrayList<>();
        ProductImgDAO imgdao = new ProductImgDAO();
        try {
            Connection con = DBUtils.getConnection();
            String sql = " SELECT p.ProductID,pg.ProductName, p.GroupID, p.RAM, p.Storage,p.Price,p.Color, (p.Price-pg.Discount/100*p.Price) as NewPrice "
                    + " FROM Product p JOIN ProductGroup pg ON p.GroupID=pg.GroupID "
                    + " WHERE p.GroupID= ?";
            if (ram != 0 && storage != 0) {
                sql += " AND RAM = ? AND Storage = ?";
            }
            PreparedStatement stmt = con.prepareStatement(sql);
            int index = 1;
            stmt.setInt(index++, id);
            if (ram != 0 && storage != 0) {
                stmt.setInt(index++, ram);
                stmt.setInt(index++, storage);
            }
            ResultSet rs = stmt.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    ProductDTO product = new ProductDTO();
                    product.setGroupID(rs.getInt("GroupID"));
                    product.setProductID(rs.getInt("ProductID"));
                    product.setProductName(rs.getString("ProductName"));
                    product.setRam(rs.getInt("RAM"));
                    product.setStorage(rs.getInt("Storage"));
                    product.setColor(rs.getString("Color"));
                    product.setPrice(rs.getInt("Price"));
                    product.setNewPrice(rs.getInt("NewPrice"));
                    List<ProductImgDTO> imgList = imgdao.list(rs.getInt("ProductID"));
                    product.setProductImg(imgList);
                    list.add(product);
                }
            }
            con.close();
        } catch (SQLException e) {

        }
        return list;
    }

    public ProductDTO load(int id) {
        ProductDTO product = null;
        ProductImgDAO imgdao = new ProductImgDAO();
        try {
            Connection con = DBUtils.getConnection();
            String sql = " SELECT p.ProductID,pg.ProductName, p.GroupID, p.RAM, p.Storage,p.Price,p.Color, (p.Price-p.Price*pg.Discount/100) as NewPrice "
                    + " FROM Product p JOIN ProductGroup pg ON p.GroupID=pg.GroupID "
                    + " WHERE p.ProductID= ?";

            PreparedStatement stmt = con.prepareStatement(sql);

            stmt.setInt(1, id);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {

                product = new ProductDTO();
                product.setGroupID(rs.getInt("GroupID"));

                product.setProductID(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setRam(rs.getInt("Ram"));
                product.setStorage(rs.getInt("Storage"));
                product.setColor(rs.getString("Color"));
                product.setPrice(rs.getInt("Price"));

                product.setNewPrice(rs.getInt("NewPrice"));
                List<ProductImgDTO> imgList = imgdao.list(product.getProductID());
                product.setProductImg(imgList);
            }
            con.close();
        } catch (SQLException e) {

        }
        return product;
    }

    public ArrayList<ProductDTO> listAll() {
        String sql = "  select p.ProductID,g.productname,p.Price,p.color from Product p  join ProductGroup g on p.groupId=g.groupId";
        try (Connection con = DBUtils.getConnection();
                PreparedStatement stmt = con.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            ArrayList<ProductDTO> product = new ArrayList<>();
            ProductGroupDTO productGroup = new ProductGroupDTO();
            ArrayList<BrandDAO> brandDAO = new ArrayList<>();
            while (rs.next()) {
                ArrayList<ProductGroupDTO> productGroupDTO = new ArrayList<>();
                product.add(new ProductDTO(rs.getInt("productID"), rs.getString("productName"), rs.getInt("groupID"), rs.getInt("ram"), rs.getString("color"), rs.getInt("storage"), rs.getInt("price"), rs.getInt("newPrice"), (List<ProductImgDTO>) rs.getObject("productGroupDTO")));
            }
            return product;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());

        }
        return null;

    }

    public ArrayList<ProductDTO> getProductByProductIDda(int id) { // lấy từ bảng Product với bảng ProductGroup bởi ProductID 
        String sql = "select p.ProductID,p.GroupID,p.RAM,p.Color,p.Storage,p.Price,pg.ProductName,pg.BrandID,pg.Description,pg.img,pg.Discount from Product p \n"
                + "full join ProductGroup pg on p.GroupID=pg.GroupID where p.ProductID= ? ";
        try (Connection con = DBUtils.getConnection();
                PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            ArrayList<ProductDTO> productDTO = new ArrayList<>();
            while (rs.next()) {
                ArrayList<ProductGroupDTO> productGroup = (new ProductGroupDAO().getProductGroupByGroupID(rs.getInt("groupID")));
                productDTO.add(new ProductDTO(rs.getInt("productID"), rs.getString("productName"), rs.getInt("groupID"), rs.getInt("ram"), rs.getString("color"), rs.getInt("storage"), rs.getInt("price"), productGroup));
            }
            return productDTO;

        } catch (SQLException ex) {
            System.out.println("Lỗi lấy database ở getProductByProductID của ProductDAO");

            ex.printStackTrace();
        }
        return null;
    }

    public ProductDTO getProductByID(int id) {
        String sql = " select * from product where ProductID = ?";
        try (Connection con = DBUtils.getConnection();
                PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                return new ProductDTO(rs.getInt("productID"), rs.getInt("groupID"), rs.getInt("ram"), rs.getString("color"), rs.getInt("storage"), rs.getInt("price"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public ArrayList<ProductDTO> getProductByGroupID(int id) {
        String sql = " select * from Product p \n"
                + "full join ProductGroup pg on p.GroupID=pg.GroupID where p.GroupID= ?";
        try (Connection con = DBUtils.getConnection();
                PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ArrayList<ProductDTO> product = new ArrayList<>();
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ArrayList<ProductGroupDTO> productGroupDTO = (new ProductGroupDAO().getProductGroupByID(rs.getInt("groupID")));
                product.add(new ProductDTO(rs.getInt("productID"), rs.getInt("groupID"), rs.getInt("ram"), rs.getString("color"), rs.getInt("storage"), rs.getInt("price"), productGroupDTO));
                return product;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public ArrayList<ProductDTO> getProductByProductID(int id) {
        String sql = "SELECT p.ProductID,pg.ProductName, p.GroupID, p.RAM, p.Storage,p.Price,p.Color, (p.Price-pg.Discount/100*p.Price) as NewPrice FROM Product p JOIN ProductGroup pg ON p.GroupID=pg.GroupID  WHERE p.ProductID= ? ";
        try (Connection con = DBUtils.getConnection();
                PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            ArrayList<ProductDTO> list = new ArrayList<>();
            ProductImgDAO imgDAO = new ProductImgDAO();
            while (rs.next()) {
                ProductDTO product = new ProductDTO();
                product.setProductID(rs.getInt("productID"));
                product.setGroupID(rs.getInt("groupID"));
                product.setProductName(rs.getString("productName"));
                product.setRam(rs.getInt("ram"));
                product.setColor(rs.getString("color"));
                product.setStorage(rs.getInt("storage"));
                product.setPrice(rs.getInt("price"));
                product.setNewPrice(rs.getInt("newPrice"));
                List<ProductImgDTO> imgList = imgDAO.list(rs.getInt("ProductID"));
                product.setProductImg(imgList);
                list.add(product);
            }
            return list;
        } catch (SQLException ex) {
            System.out.println("Không lấy được databaase từ getProductByProductID của ProductDAO");
            System.out.println(ex.getMessage());
        }
        return null;
    }

    public void updateProduct(int productID, int ram, String color, int storage, int price, String[] images) {
        String updateProductSQL = " UPDATE Product SET RAM = ?, Color = ?, Storage = ?, Price = ? WHERE ProductID = ? ";
        String deleteImagesSQL = " DELETE FROM Group_img WHERE ProductID = ? ";
        String insertImageSQL = " INSERT INTO Group_img (imgID, ProductID) VALUES (?, ?) ";

        try (Connection con = DBUtils.getConnection()) {
            // Cập nhật thông tin sản phẩm
            try (PreparedStatement stmt = con.prepareStatement(updateProductSQL)) {
                stmt.setInt(1, ram);
                stmt.setString(2, color);
                stmt.setInt(3, storage);
                stmt.setInt(4, price);
                stmt.setInt(5, productID);
                stmt.executeUpdate();
            }

            // Xóa tất cả hình ảnh cũ
            try (PreparedStatement stmt = con.prepareStatement(deleteImagesSQL)) {
                stmt.setInt(1, productID);
                stmt.executeUpdate();
            }

            // Thêm hình ảnh mới
            for (String imgUrl : images) {
                int imgID = getImgID(imgUrl, con); // Hàm này để lấy hoặc tạo imgID cho imgUrl
                try (PreparedStatement stmt = con.prepareStatement(insertImageSQL)) {
                    stmt.setInt(1, imgID);
                    stmt.setInt(2, productID);
                    stmt.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertProduct(int groupID, int ram, String color, int storage, int price, String[] images) {
        String insertProductSQL = " INSERT INTO [Product] (GroupID, RAM, Color, Storage, Price) "
                + " VALUES (?,?,?,?,?)";
        String insertImageSQL = " INSERT INTO Group_img (imgID, ProductID) VALUES (?, ?) ";
        int productID = 0;
        try (Connection con = DBUtils.getConnection()) {
            // Them thông tin sản phẩm
            try (PreparedStatement stmt = con.prepareStatement(insertProductSQL, Statement.RETURN_GENERATED_KEYS)) {
                stmt.setInt(1, groupID);
                stmt.setInt(2, ram);
                stmt.setString(3, color);
                stmt.setInt(4, storage);
                stmt.setInt(5, price);
                stmt.executeUpdate();
                ResultSet rs = stmt.getGeneratedKeys();

                if (rs.next()) {
                    productID = rs.getInt(1);
                }
            }

            // Thêm hình ảnh mới
            for (String imgUrl : images) {
                int imgID = getImgID(imgUrl, con); // Hàm này để lấy hoặc tạo imgID cho imgUrl
                try (PreparedStatement stmt = con.prepareStatement(insertImageSQL, Statement.RETURN_GENERATED_KEYS)) {
                    stmt.setInt(1, imgID);
                    stmt.setInt(2, productID);
                    stmt.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private int getImgID(String imgUrl, Connection con) throws SQLException {
        String selectImgSQL = "SELECT imgID FROM Product_img WHERE img = ?";
        String insertImgSQL = "INSERT INTO Product_img (img) VALUES (?)";

        // Kiểm tra nếu hình ảnh đã tồn tại trong Product_img
        try (PreparedStatement stmt = con.prepareStatement(selectImgSQL)) {
            stmt.setString(1, imgUrl);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("imgID");
                }
            }
        }

        // Nếu hình ảnh không tồn tại, thêm mới vào Product_img
        try (PreparedStatement stmt = con.prepareStatement(insertImgSQL, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, imgUrl);
            stmt.executeUpdate();
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }

        throw new SQLException("Unable to get or insert imgID for image URL: " + imgUrl);
    }

    public void delete(int id) {
        try {
            Connection con = DBUtils.getConnection();
            String sql = " DELETE FROM Product WHERE ProductID = ? ";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public int loadNewID() {
        ProductDTO product = null;
        ProductImgDAO imgdao = new ProductImgDAO();
        int id = 0;
        try {
            Connection con = DBUtils.getConnection();
            String sql = " SELECT TOP(1) p.ProductID "
                    + " FROM Product p "
                    + " ORDER BY ProductID DESC";

            PreparedStatement stmt = con.prepareStatement(sql);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                id = rs.getInt("ProductID");
            }
            con.close();
        } catch (SQLException e) {

        }
        return id;
    }

    public ProductDTO load(int id, int ram, String color, int storage, int price) {
        ProductDTO product = null;
        ProductImgDAO imgdao = new ProductImgDAO();
        try {
            Connection con = DBUtils.getConnection();
            String sql = " SELECT ProductID, GroupID, RAM, Color, Storage, Price"
                    + " FROM Product "
                    + " WHERE GroupID=? AND RAM=? AND Storage=? AND Color like ? AND Price= ?";

            PreparedStatement stmt = con.prepareStatement(sql);

            stmt.setInt(1, id);
            stmt.setInt(2, ram);
            stmt.setInt(3, storage);
            stmt.setString(4, color);
            stmt.setInt(5, price);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {

                product = new ProductDTO();
                product.setGroupID(rs.getInt("GroupID"));

                product.setProductID(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setRam(rs.getInt("Ram"));
                product.setStorage(rs.getInt("Storage"));
                product.setColor(rs.getString("Color"));
                product.setPrice(rs.getInt("Price"));
                product.setNewPrice(rs.getInt("NewPrice"));
                List<ProductImgDTO> imgList = imgdao.list(product.getProductID());
                product.setProductImg(imgList);
            }
            con.close();
        } catch (SQLException e) {

        }
        return product;
    }

    public ProductDTO getProductByProductIDit(int id) { // lấy từ bảng Product với bảng ProductGroup bởi ProductID 
        String sql = "select p.ProductID,p.GroupID,p.RAM,p.Color,p.Storage,p.Price,pg.ProductName,pg.BrandID,pg.Description,pg.img,pg.Discount  from Product p \n"
                + "full join ProductGroup pg on p.GroupID=pg.GroupID where p.ProductID= ? ";
        try (Connection con = DBUtils.getConnection();
                PreparedStatement stmt = con.prepareStatement(sql)) {
            System.out.println("Setting parameter id = " + id);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            ProductDTO productDTO = new ProductDTO();
            while (rs.next()) {
                ArrayList<ProductGroupDTO> productGroup = (new ProductGroupDAO().getProductGroupByGroupID(rs.getInt("groupID")));

                productDTO.setProductID(rs.getInt("productID"));
                productDTO.setProductName(rs.getString("productName"));
                productDTO.setGroupID(rs.getInt("groupID"));
                productDTO.setRam(rs.getInt("ram"));
                productDTO.setColor(rs.getString("color"));
                productDTO.setStorage(rs.getInt("storage"));
                productDTO.setPrice(rs.getInt("price"));
                productDTO.setProductGroup(productGroup);
// productDTO.add( new ProductDTO(rs.getInt("productID"),rs.getString("productName"),rs.getInt("groupID"),rs.getInt("ram"),rs.getString("color"),rs.getInt("storage"),rs.getInt("price"),productGroup));
            }
            return productDTO;

        } catch (SQLException ex) {
            System.out.println("Lỗi lấy database ở getProductByProductID của ProductDAO");

            ex.printStackTrace();
        }
        return null;
    }
    public void insertImg(int id, String images) {

        String insertImageSQL = " INSERT INTO Group_img (imgID, ProductID) VALUES (?, ?) ";
        try (Connection con = DBUtils.getConnection()) {
            // Them thông tin sản phẩm

            // Thêm hình ảnh mới
            int imgID = getImgID(images, con); // Hàm này để lấy hoặc tạo imgID cho imgUrl
            try (PreparedStatement stmt = con.prepareStatement(insertImageSQL, Statement.RETURN_GENERATED_KEYS)) {
                stmt.setInt(1, imgID);
                stmt.setInt(2, id);
                stmt.executeUpdate();

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void deleteImg(int id){
        String sql = " DELETE FROM [Product_img] WHERE imgID = ? ";
        try{
            Connection con= DBUtils.getConnection();
            PreparedStatement stmt= con.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }catch(SQLException e){
                        e.printStackTrace();

        }
    }
    
     public ArrayList<ProductDTO> getProductByProductIDdaed(int id) { // lấy từ bảng Product với bảng ProductGroup bởi ProductID 
        String sql = "select p.ProductID,p.GroupID,p.RAM,p.Color,p.Storage,p.Price,pg.ProductName,pg.BrandID,pg.Description,pg.img,pg.Discount, (p.Price-((pg.Discount*p.Price/100))) as NewPrice   from Product p \n"
                + "full join ProductGroup pg on p.GroupID=pg.GroupID where p.ProductID= ? ";
        try (Connection con = DBUtils.getConnection();
                PreparedStatement stmt = con.prepareStatement(sql)) {
            System.out.println("Setting parameter id = " + id);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            ArrayList<ProductDTO> productDTO = new ArrayList<>();
            while (rs.next()) {
                ArrayList<ProductGroupDTO> productGroup = (new ProductGroupDAO().getProductGroupByGroupID(rs.getInt("groupID")));
                productDTO.add(new ProductDTO(rs.getInt("productID"), rs.getString("productName"), rs.getInt("groupID"), rs.getInt("ram"), rs.getString("color"), rs.getInt("storage"), rs.getInt("price"),rs.getInt("NewPrice"),rs.getInt("discount"), productGroup));
            }
            return productDTO;

        } catch (SQLException ex) {
            System.out.println("Lỗi lấy database ở getProductByProductID của ProductDAO");

            ex.printStackTrace();
        }
        return null;
    }
  
}
