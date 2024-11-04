/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.OrderDetailDTO;
import dto.ProductDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author Administrator
 */
public class OrderDetailDAO extends DBUtils{
    public ArrayList<OrderDetailDTO> getOrderDetailByOrderId(int id ) { // lấy từ bảng OrderDetail với bảng Product bởi OrderID
        String sql = "select od.OrderID,od.ProductID,od.UnitPrice,od.Quantity,od.TotalPrice,p.GroupID,p.RAM,p.Color,p.Storage,p.Price from OrderDetail od \n" +
"full join Product p on od.ProductID=p.ProductID where od.OrderID = ? " ; 
        try(Connection con =DBUtils.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql)){
            stmt.setInt(1, id);
            ArrayList<OrderDetailDTO> orderDetailDTO = new ArrayList<>();
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
               // ArrayList<ProductDTO> productDTO = (new ProductDAO().getProductByProductIDda(rs.getInt("productID")));
                
                ArrayList<ProductDTO> productDTO = (new ProductDAO().getProductByProductIDdaed(rs.getInt("productID")));
                orderDetailDTO.add(new OrderDetailDTO(rs.getInt("orderID"), rs.getInt("productID"),rs.getInt("unitPrice"), rs.getInt("quantity"), rs.getInt("totalPrice"),productDTO));
            }
            return orderDetailDTO;

    }catch(SQLException ex){
            System.out.println("Lỗi lấy database ở getOrderDetailByOrderId của OrderDetailDTO");
            System.out.println(ex.getMessage());
}
    return null ; 
}
    public boolean deleteByProductID(int id ){
        String sql = "delete from OrderDetail where ProductID= ?" ; 
        try(Connection con = DBUtils.getConnection();
                PreparedStatement stmt = con.prepareStatement(sql)){
            stmt.setInt(1, id);
          return  stmt.execute();
        }catch(SQLException ex){
            ex.printStackTrace();
        }
        return false;
    }
       public boolean updateTotalByID(int id , int total){
        String sql = "update  [OrderDetail] set TotalPrice = TotalPrice -  ? where OrderID = ?  " ;
         try(Connection con = DBUtils.getConnection();
                 PreparedStatement stmt = con.prepareStatement(sql)){
            stmt.setInt(1, total);
            stmt.setInt(2, id);
             stmt.executeUpdate();
             return true ; 
         }catch(SQLException ex){
             ex.printStackTrace();
         }
         return false ; 
    }
    
}
