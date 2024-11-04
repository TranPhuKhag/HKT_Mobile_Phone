/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.UserDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import utils.DBUtils;

/**
 *
 * @author Admin
 */
public class UserDAO {

    public UserDTO login(String username, String password) {

        UserDTO user = null;
        try {

            Connection con = DBUtils.getConnection();
            String sql = " SELECT [UserID], [Fullname], [Email], [Phone], [Username], [Password], [role], [status] FROM [User] ";
            sql += " WHERE username = ?  AND password = ?";

            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs != null) {
                if (rs.next()) {

                    user = new UserDTO();
                    user.setUserID(rs.getInt("UserID"));
                    user.setFullname(rs.getString("Fullname"));
                    user.setEmail(rs.getString("Email"));
                    user.setPhone(rs.getString("Phone"));
                    user.setUsername(rs.getString("Username"));
                    user.setPassword(rs.getString("Password"));
                    user.setRole(rs.getInt("role"));
                    user.setStatus(rs.getInt("status"));
                }
            }
            con.close();
        } catch (SQLException ex) {
            System.out.println("Error in servlet. Details:" + ex.getMessage());
            ex.printStackTrace();

        }
        return user;

    }
    public boolean insert(UserDTO user){
        String sql = "INSERT INTO [User]( [Fullname], [Email], [Phone], [Username], [Password] ,[role],[status]) VALUES (? ,?,?,?,?,?,?)";
         try {
            Connection con = DBUtils.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, user.getFullname());
            stmt.setString(2,user.getEmail());
            stmt.setString(3, user.getPhone());
            stmt.setString(4, user.getUsername());
            stmt.setString(5, user.getPassword());
            stmt.setInt(6,user.getRole());
            stmt.setInt(7,user.getStatus());

          return stmt.execute();

        } catch (SQLException ex) {
            System.out.println("Error Register in Servlet " + ex.getMessage());
            ex.printStackTrace();

        }
         return false;
    }    

    public void register(String fullName, String email, String phone, String username, String password) {
        String sql = " INSERT INTO [User]( [Fullname], [Email], [Phone], [Username], [Password]) VALUES (?,?,?,?,?) ";

        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, fullName);
            stmt.setString(2, email);
            stmt.setString(3, phone);
            stmt.setString(4, username);
            stmt.setString(5, password);

            stmt.execute();
            stmt.close();

        } catch (SQLException ex) {
            System.out.println("Error Register in Servlet " + ex.getMessage());
            ex.printStackTrace();

        }

    }

    public UserDTO getUserByUsername(String username) {
        UserDTO user = null;
        try (Connection con = DBUtils.getConnection()) {
            String sql = " SELECT [UserID], [Fullname], [Email], [Phone], [Username], [Password], [role], [status] "
                    + " FROM [User] WHERE username = ?  ";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, username);

            ResultSet rs = stmt.executeQuery();

            if (rs != null && rs.next()) {
                user = new UserDTO();
                user.setUserID(rs.getInt("UserID"));
                user.setFullname(rs.getString("Fullname"));
                user.setEmail(rs.getString("Email"));
                user.setPhone(rs.getString("Phone"));
                user.setUsername(rs.getString("Username"));
                user.setPassword(rs.getString("Password"));
                user.setRole(rs.getInt("role"));
                user.setStatus(rs.getInt("status"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return user;
    }

    public ArrayList<UserDTO> getAll() {
        String sql = " select UserID,Fullname,Email,Phone,Username,Password,role,status from [User]";
        try (Connection con = DBUtils.getConnection();
                PreparedStatement stmt = con.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            ArrayList<UserDTO> list = new ArrayList<>();
            while (rs.next()) {
                list.add(new UserDTO(rs.getInt("UserID"), rs.getString("Fullname"), rs.getString("Email"), rs.getString("Phone"), rs.getString("Username"), rs.getString("Password"), rs.getInt("role"), rs.getInt("status")));
                // list.add(new UserDTO(rs.getInt("UserID"),rs.getString("Fullname"),rs.getString("Email"),rs.getString("Phone"),rs.getString("Username"),rs.getString("Password"),rs.getInt("role"),rs.getInt("status")));
            }
            return list;

        } catch (SQLException ex) {
            ex.printStackTrace();
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean delete(int userId) {
        String sql = "EXEC DeleteUserAndRelatedData @userID = ?";
        try (Connection con = DBUtils.getConnection();
                PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, userId);

            stmt.execute();
            return true;

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;

    }

    public UserDTO getUserByID(int userID) {
        UserDTO user = null;
        try (Connection con = DBUtils.getConnection()) {
            String sql = " SELECT [UserID], [Fullname], [Email], [Phone], [Username], [Password], [role], [status] "
                    + " FROM [User] WHERE [UserID] = ?  ";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1, userID);

            ResultSet rs = stmt.executeQuery();

            if (rs != null && rs.next()) {
                user = new UserDTO();
                user.setUserID(rs.getInt("UserID"));
                user.setFullname(rs.getString("Fullname"));
                user.setEmail(rs.getString("Email"));
                user.setPhone(rs.getString("Phone"));
                user.setUsername(rs.getString("Username"));
                user.setPassword(rs.getString("Password"));
                user.setRole(rs.getInt("role"));
                user.setStatus(rs.getInt("status"));
            }
            con.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return user;
    }

     public ArrayList<UserDTO> getUserByUserID(int userID) {
        ArrayList<UserDTO> user = new ArrayList<>();
        try (Connection con = DBUtils.getConnection()) {
            String sql = " SELECT [UserID], [Fullname], [Email], [Phone], [Username], [Password], [role], [status] "
                    + " FROM [User] WHERE [UserID] = ?  ";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1, userID);
            ResultSet rs = stmt.executeQuery();

            if (rs != null && rs.next()) {
                user.add( new UserDTO(rs.getInt("UserID"),rs.getString("Fullname"),rs.getString("Email"),rs.getString("Phone"),rs.getString("Username"),rs.getString("Password"),rs.getInt("role"),rs.getInt("status")));
          
            }
            return user;
        } catch (SQLException ex) {
            ex.printStackTrace();
            
        }
        return null;
    }
    public boolean update(UserDTO userDTO) {
        String sql = "  Update [User] set fullname = ?, email = ? , phone = ?, Username= ? ,[Password] = ?, role  =? ,status = ? where UserID =? ";
        try (Connection con = DBUtils.getConnection();
                PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1,userDTO.getFullname());
            stmt.setString(2,userDTO.getEmail());
            stmt.setString(3,userDTO.getPhone());
            stmt.setString(4,userDTO.getUsername());
            stmt.setString(5,userDTO.getPassword());
            stmt.setInt(6,userDTO.getRole());
            stmt.setInt(7,userDTO.getStatus());
            stmt.setInt(8,userDTO.getUserID());
        return  stmt.execute();

        } catch (SQLException ex) {
            System.out.println("không thể câp nhât được ");
            System.out.println(ex.getMessage());
        }
        return false ;
    }
    public boolean updateInvoiceByID(int id , String fullname , String email , String phone){
        String sql = "update [User] set Fullname= ? , Email = ? , Phone = ? where UserID = ?" ;
         try(Connection con = DBUtils.getConnection();
                 PreparedStatement stmt = con.prepareStatement(sql)){
            stmt.setString(1, fullname);
            stmt.setString(2, email);
            stmt.setString(3, phone);
             stmt.setInt(4, id);
             stmt.executeUpdate();
             return true ; 
         }catch(SQLException ex){
             ex.printStackTrace();
         }
         return false ; 
    }
}
