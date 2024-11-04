/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.DBUtils;

/**
 *
 * @author Asus
 */
@WebServlet(name = "AccountDAO", urlPatterns = {"/AccountDAO"})
public class AccountDAO extends HttpServlet {
    public UserDTO load(int id){
        UserDTO dto = null;
        try {
            String sql = " SELECT UserID, Fullname, Email, Phone, Username, Password FROM [User] WHERE UserID = ? ";
            Connection con = DBUtils.getConnection();
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, id);
            
            ResultSet rs = stm.executeQuery();
            if(rs.next()){
              
                dto = new UserDTO();
                
                dto.setUserID(rs.getInt("UserID")); 
                
                
                dto.setFullname(rs.getString("Fullname"));
                dto.setEmail(rs.getString("Email"));
                dto.setPhone(rs.getString("Phone"));
                dto.setUsername(rs.getString("Username"));
                dto.setPassword(rs.getString("Password"));
                return dto;
            }
            con.close();
        } catch (SQLException e) {
            System.out.println("lỗi ở load (AccountDAO)" + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
  
    public boolean update(UserDTO user){
        try {
            String sql = "UPDATE [User] SET Password = ? WHERE UserID = ? ";
            Connection con = DBUtils.getConnection();
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, user.getPassword());
            stm.setInt(2, user.getUserID());
            stm.executeUpdate();
            
        } catch (SQLException e) {
            System.out.println("Lỗi ở update(AccountDAO)" + e.getMessage());
            e.getStackTrace();
        }
        return false;
    }
        public boolean update(int id, String name, String email, String phone){
        try {
            String sql = "UPDATE [User] SET [Fullname] = ? , [Email] = ? , [Phone] = ? WHERE UserID = ? ";
            Connection con = DBUtils.getConnection();
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, name);
            stm.setString(2, email);
            stm.setString(3, phone);
            stm.setInt(4, id);
            stm.executeUpdate();
            
        } catch (SQLException e) {
            System.out.println("Lỗi ở update(AccountDAO)" + e.getMessage());
            e.getStackTrace();
        }
        return false;
    }
}
