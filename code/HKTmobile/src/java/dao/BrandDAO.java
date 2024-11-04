/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.BrandDTO;
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
public class BrandDAO {

    public List<BrandDTO> list() {
        List<BrandDTO> list = new ArrayList<BrandDTO>();
        try {
            Connection con = DBUtils.getConnection();
            String sql = " SELECT b.BrandID, b.BrandName,COUNT(pg.GroupID) as number "
                    + "FROM Brand b LEFT JOIN ProductGroup pg ON b.BrandID=pg.BrandID "
                    + "GROUP BY b.BrandID, BrandName";
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    BrandDTO brand = new BrandDTO();
                    brand.setBrandID(rs.getInt("BrandID"));
                    brand.setBrandName(rs.getString("BrandName"));
                    brand.setNumber(rs.getInt("number"));
                    list.add(brand);
                }
            }
            con.close();
        } catch (SQLException ex) {
            System.out.println("Error in servlet. Details:" + ex.getMessage());
            ex.printStackTrace();
        }
        return list;
    }

    public BrandDTO load(int id) {
        BrandDTO brand = new BrandDTO();
        try {

            Connection con = DBUtils.getConnection();
            String sql = " SELECT BrandID, BrandName "
                    + " FROM Brand  "
                    + " WHERE BrandID = ?";

            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1, id);

            ResultSet rs = stmt.executeQuery();

            if (rs != null) {
                while (rs.next()) {

                    brand.setBrandID(rs.getInt("BrandID"));
                    brand.setBrandName(rs.getString("BrandName"));

                }
            }
            con.close();
        } catch (SQLException ex) {
            System.out.println("Error in servlet. Details:" + ex.getMessage());
            ex.printStackTrace();

        }
        return brand;
    }

    public ArrayList<BrandDTO> getBrandByBrandID(int id) {
        String sql = "select  brandID , brandName from Brand  where BrandID = ? ";
        ArrayList<BrandDTO> brand = new ArrayList<>();
        try (Connection con = DBUtils.getConnection();
                PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                brand.add(new BrandDTO(rs.getInt("brandID"), rs.getString("brandName")));
            }
            return brand;
        } catch (SQLException ex) {
            System.out.println("Lỗi databasse ở getBrandByBrandID của BrandDAO");
            System.out.println(ex.getMessage());
            ex.printStackTrace();

        }
        return null;
    }

    public void insert(String name) {
        String sql = " INSERT INTO Brand (BrandName) "
                + " VALUES (?) ";
        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, name);

            stmt.executeUpdate();
            con.close();
        } catch (SQLException e) {
            System.out.println("Insert Error" + e.getMessage());
        }
    }

    public void delete(int id) {
        String sql = " DELETE FROM Brand WHERE BrandID = ? ";

        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1, id);

            stmt.executeUpdate();
            con.close();
        } catch (SQLException e) {
            System.out.println("Delete Error" + e.getMessage());
        }
    }

    public void update(String name, int id) {
        String sql = " UPDATE Brand SET BrandName = ? WHERE BrandID = ? ";

        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setInt(2, id);
            stmt.executeUpdate();
            con.close();
        } catch (SQLException e) {
            System.out.println("update Error" + e.getMessage());
        }

    }

    public List<BrandDTO> listUser() {
        List<BrandDTO> list = new ArrayList<BrandDTO>();
        try {
            Connection con = DBUtils.getConnection();
            String sql = " WITH CountProduct as ( SELECT b.BrandID,b.BrandName,pg.GroupID,ROW_NUMBER() OVER (PARTITION BY pg.GroupID ORDER BY pg.GroupID) AS RowNum FROM Brand b LEFT JOIN ProductGroup pg ON b.BrandID=pg.BrandID "
                    + " Right JOIN Product p ON pg.GroupID=p.GroupID)"
                    + " SELECT BrandID,BrandName,COUNT(GroupID) as number "
                    + " FROM CountProduct"
                    + " WHERE RowNum=1"
                    + " GROUP BY BrandID, BrandName";
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    BrandDTO brand = new BrandDTO();
                    brand.setBrandID(rs.getInt("BrandID"));
                    brand.setBrandName(rs.getString("BrandName"));
                    brand.setNumber(rs.getInt("number"));
                    list.add(brand);
                }
            }
            con.close();
        } catch (SQLException ex) {
            System.out.println("Error in servlet. Details:" + ex.getMessage());
            ex.printStackTrace();
        }
        return list;
    }
}
