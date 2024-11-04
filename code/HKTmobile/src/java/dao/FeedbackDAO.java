/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.FeedbackDTO;
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
public class FeedbackDAO {

    public List<FeedbackDTO> list(int id) {
        List<FeedbackDTO> list = new ArrayList<>();
        UserDAO userDao = new UserDAO();
        try {
            Connection con = DBUtils.getConnection();
            String sql = " SELECT [FeedbackID]"
                    + "      ,[UserID]"
                    + "      ,[ProductID]"
                    + "      , CAST([Date] AS DATE) AS OnlyDate"
                    + "      ,[Message]"
                    + "      ,[Rate]"
                    + "  FROM [Feedback] "
                    + " WHERE ProductID = ? ";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    FeedbackDTO feedback = new FeedbackDTO();
                    feedback.setFeedbackID(rs.getInt("FeedbackID"));
                    feedback.setUserID(rs.getInt("UserID"));
                    feedback.setProductID(rs.getInt("ProductID"));
                    feedback.setDate(rs.getString("OnlyDate"));
                    feedback.setMessage(rs.getString("Message"));
                    feedback.setRate(rs.getInt("rate"));
                    feedback.setUserName(userDao.getUserByID(rs.getInt("UserID")).getFullname());
                    System.out.println(feedback.getUserName());
                    list.add(feedback);
                }
            }
            con.close();
        } catch (SQLException e) {

        }
        return list;
    }

    public void insert(FeedbackDTO feedback) {
        String sql = " INSERT INTO Feedback (UserID, ProductID, Message, Rate) "
                + " VALUES (?, ? ,?,?) ";
        try{
            Connection con= DBUtils.getConnection();
            PreparedStatement stmt= con.prepareStatement(sql);
            stmt.setInt(1, feedback.getUserID());
            stmt.setInt(2, feedback.getProductID());
            stmt.setString(3, feedback.getMessage());
            stmt.setInt(4, feedback.getRate());
            stmt.executeUpdate();
        }catch(SQLException e){
            System.out.println("Insert Error" + e.getMessage());
        }
    }
}
