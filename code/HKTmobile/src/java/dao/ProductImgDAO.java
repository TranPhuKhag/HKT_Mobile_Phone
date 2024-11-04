/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.ProductImgDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.spi.DirStateFactory;
import utils.DBUtils;

/**
 *
 * @author Admin
 */
public class ProductImgDAO {

    public List<ProductImgDTO> list(int id) {
        List<ProductImgDTO> list = new ArrayList<>();
        try {
            Connection con = DBUtils.getConnection();
            String sql = " SELECT pi.imgID, pi.img FROM Product_img pi JOIN Group_img g ON pi.imgID=g.imgID "
                    + " WHERE g.ProductID = ?";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    ProductImgDTO img = new ProductImgDTO();
                    img.setImgID(rs.getInt("imgID"));
                    img.setImg(rs.getString("img"));
                    list.add(img);
                }
            }con.close();
        } catch (SQLException e) {

        }
        return list;
    }
}
