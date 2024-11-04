/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.ContactUsDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.AbstractList;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author Asus
 */
public class ContactUsDAO {
    public void saveContact(ContactUsDTO dto) {
        try {
            Connection con = DBUtils.getConnection();
            String sql = "INSERT INTO ContactUs (Date, UserID, Message) VALUES (?, ?, ?)";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setTimestamp(1, new java.sql.Timestamp(dto.getDate().getTime()));
            stm.setInt(2, dto.getUserID());
            stm.setString(3, dto.getMessage());
            stm.executeUpdate();
            con.close();
        } catch (SQLException e) {
            System.out.println("Lỗi ở saveContact: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    
    public List<ContactUsDTO> getContactsByUser(Integer userID){
        List<ContactUsDTO> contactList = new ArrayList<>();
        try {
            Connection con = DBUtils.getConnection();
            String sql = " SELECT Date, Message FROM ContactUs WHERE UserID = ? ";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, userID);
            ResultSet rs = stm.executeQuery();
            while(rs != null && rs.next()){
                    ContactUsDTO dto = new ContactUsDTO();
                    dto.setDate(rs.getDate("Date"));
                    dto.setMessage(rs.getString("Message"));
                    contactList.add(dto);
            }
            con.close();
        } catch (SQLException e) {
            System.out.println("lỗi ở getContactDAO" + e.getMessage());
            e.printStackTrace();
        }
        return contactList;
    }
    
    
    public List<ContactUsDTO> contactDao(){
        List<ContactUsDTO> contactDto = new ArrayList<>();
        try {
            Connection con = DBUtils.getConnection();
            String sql = "SELECT * FROM ContactUs ";
            PreparedStatement stm = con.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if(rs != null){
                while(rs.next()){
                    ContactUsDTO dto = new ContactUsDTO();
                    dto.setContactID(rs.getInt("ContactID"));
                    dto.setDate(rs.getDate("Date"));
                    dto.setUserID(rs.getInt("UserID"));
                    dto.setMessage(rs.getString("Message"));
                    contactDto.add(dto);
                }
            }
            con.close();
        } catch (SQLException e) {
            System.out.println("lỗi ở contactDAO " + e.getMessage());
            e.printStackTrace();
        }
        return contactDto;
    }
}
