/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.StatusDTO;
import dto.UserDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import utils.DBUtils;

/**
 *
 * @author Administrator
 */
public class StatusDAO {
    public ArrayList<StatusDTO> getStatusByID(int statusID){
    
        try (Connection con = DBUtils.getConnection()) {
            String sql = " select StatusID,Status from Status where  StatusID = ?" ; 
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1, statusID);
 ArrayList<StatusDTO> statusDTO = new ArrayList<>();
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
           statusDTO.add(new StatusDTO(rs.getInt(1),rs.getString(2)));
                    }
            return statusDTO;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null ;
    }

   
    }

