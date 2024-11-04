/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.ProductDetailDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import utils.DBUtils;

/**
 *
 * @author Admin
 */
public class ProductDetailDAO {

    public ProductDetailDTO load(int id) {
        ProductDetailDTO detail = new ProductDetailDTO();
        try {
            Connection con = DBUtils.getConnection();
            String sql = " SELECT [DetailID]\n"
                    + "      ,[GroupID]\n"
                    + "      ,[screen]\n"
                    + "      ,[OS]\n"
                    + "      ,[After_cam]\n"
                    + "      ,[Front_cam]\n"
                    + "      ,[Chip]\n"
                    + "      ,[SIM]\n"
                    + "      ,[Pin]\n"
                    + "  FROM [Product_Detail] "
                    + " WHERE GroupID = ? ";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    detail.setDetailID(rs.getInt("DetailID"));
                    detail.setGroupID(rs.getInt("GroupID"));
                    detail.setScreen(rs.getString("screen"));
                    detail.setOs(rs.getString("OS"));
                    detail.setAfterCam(rs.getString("After_cam"));
                    detail.setFrontCam(rs.getString("Front_cam"));
                    detail.setChip(rs.getString("Chip"));
                    detail.setSim(rs.getString("SIM"));
                    detail.setPin(rs.getString("Pin"));
                }
            }
            con.close();
        } catch (SQLException e) {
        }
        return detail;
    }
     public void insert(ProductDetailDTO detail) {
        // SQL insert statement
        String sql = " INSERT INTO Product_Detail (GroupID, screen, OS, After_cam, Front_cam, Chip, SIM, Pin) " +
                     " VALUES (?, ?, ?, ?, ?, ?, ?, ?) ";

        try (
            // Get connection from DBUtils (Assuming DBUtils manages connection)
            Connection con = DBUtils.getConnection();
            // Prepare statement with SQL
            PreparedStatement stmt = con.prepareStatement(sql)
        ) {
            // Set values for parameters
            stmt.setInt(1, detail.getGroupID());
            stmt.setString(2, detail.getScreen());
            stmt.setString(3, detail.getOs());
            stmt.setString(4, detail.getAfterCam());
            stmt.setString(5, detail.getFrontCam());
            stmt.setString(6, detail.getChip());
            stmt.setString(7, detail.getSim());
            stmt.setString(8, detail.getPin());

            // Execute insert
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("detail");
            System.out.println(e.getMessage()); // Handle SQL exceptions
        }
    }

    // Method to update product detail
    public void update(ProductDetailDTO detail) {
        // SQL update statement
        String sql = " UPDATE Product_Detail " +
                     " SET " +
                     "    screen = ?, " +
                     "    OS = ?, " +
                     "    After_cam = ?, " +
                     "    Front_cam = ?, " +
                     "    Chip = ?, " +
                     "    SIM = ?, " +
                     "    Pin = ? " +
                     "WHERE " +
                     "    GroupID = ?";

        try (
            // Get connection from DBUtils (Assuming DBUtils manages connection)
            Connection con = DBUtils.getConnection();
            // Prepare statement with SQL
            PreparedStatement stmt = con.prepareStatement(sql)
        ) {
            // Set values for parameters
            stmt.setString(1, detail.getScreen());
            stmt.setString(2, detail.getOs());
            stmt.setString(3, detail.getAfterCam());
            stmt.setString(4, detail.getFrontCam());
            stmt.setString(5, detail.getChip());
            stmt.setString(6, detail.getSim());
            stmt.setString(7, detail.getPin());
            stmt.setInt(8, detail.getGroupID());

            // Execute update
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage()); // Handle SQL exceptions
            e.printStackTrace();
        }
    }

    
}
