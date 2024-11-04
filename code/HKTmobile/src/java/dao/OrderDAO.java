/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.Cart;
import dto.Item;
import dto.OrderDTO;
import dto.OrderDetailDTO;
import dto.StatusDTO;
import dto.UserDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import utils.DBUtils;

/**
 *
 * @author Administrator
 */
public class OrderDAO extends DBUtils{
    public ArrayList<OrderDTO> getOrder(){
        String sql = "select * from [Order] ";
        try (Connection con = DBUtils.getConnection();
                PreparedStatement stmt = con.prepareStatement(sql)){
            
            ArrayList<OrderDTO> order = new ArrayList<>();
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                ArrayList<OrderDetailDTO> orderdetailDTO = ( new OrderDetailDAO().getOrderDetailByOrderId(rs.getInt("orderID")));
                ArrayList<UserDTO> user = (new UserDAO().getUserByUserID(rs.getInt("userID")));
                ArrayList<StatusDTO> statusDTO = ( new StatusDAO().getStatusByID(rs.getInt("statusID")));
                order.add(new OrderDTO(rs.getInt("orderID"),rs.getInt("userID"),rs.getInt("amount"),rs.getDate("date"),
                        rs.getString("address"),rs.getInt("statusID"), orderdetailDTO, user, statusDTO));
            }
            return order;
            
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
            return null ; 
    
}
        public ArrayList<OrderDTO> getOrderByOrderID(int id ){
        String sql = "select * from [Order] where orderID = ? ";
        try (Connection con = DBUtils.getConnection();
                PreparedStatement stmt = con.prepareStatement(sql)){
            stmt.setInt(1, id);
            ArrayList<OrderDTO> order = new ArrayList<>();
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                ArrayList<OrderDetailDTO> orderdetailDTO = ( new OrderDetailDAO().getOrderDetailByOrderId(rs.getInt("orderID")));
                ArrayList<UserDTO> user = (new UserDAO().getUserByUserID(rs.getInt("userID")));
                ArrayList<StatusDTO> statusDTO = ( new StatusDAO().getStatusByID(rs.getInt("statusID")));
                order.add(new OrderDTO(rs.getInt("orderID"),rs.getInt("userID"),rs.getInt("amount"),rs.getDate("date"),
                        rs.getString("address"),rs.getInt("statusID"), orderdetailDTO, user, statusDTO));
            }
            return order;
            
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
            return null ; 
    
}
        public OrderDTO getOrderByID (int id ){
            String sql ="select OrderID,UserID,Amount,Date,Address,StatusID from [Order] where OrderID = ? ";
            try(Connection con = DBUtils.getConnection();
                    PreparedStatement stmt = con.prepareStatement(sql)){
                stmt.setInt(1, id);
                ResultSet rs = stmt.executeQuery();
                
                while(rs.next()){
                    return new OrderDTO(rs.getInt("orderID"),rs.getInt("userID"),rs.getInt("amount"),rs.getDate("date"),rs.getString("address"),rs.getInt("statusID"));
                }
            }catch(SQLException ex){
                ex.printStackTrace();
            }
            return null ; 
        }
        
        public boolean updateInvoiceByID(int id , String date , String address , int statusID){
        String sql = "update [Order] set date = ? ,address = ? ,statusID = ? where OrderID= ?" ;
         try(Connection con = DBUtils.getConnection();
                 PreparedStatement stmt = con.prepareStatement(sql)){
            stmt.setString(1, date);
            stmt.setString(2, address);
            stmt.setInt(3, statusID);
             stmt.setInt(4, id);
             stmt.executeUpdate();
             return true ; 
         }catch(SQLException ex){
             ex.printStackTrace();
         }
         return false ; 
    }
         public boolean updateAmountByID(int id , int amount){
        String sql = "update [Order] set amount = amount -1 where OrderID = ? " ;
         try(Connection con = DBUtils.getConnection();
                 PreparedStatement stmt = con.prepareStatement(sql)){
            stmt.setInt(1, id);
             stmt.executeUpdate();
             return true ; 
         }catch(SQLException ex){
             ex.printStackTrace();
         }
         return false ; 
    }
         
         public ArrayList<OrderDTO> getOrderDetailByOrderID(Integer id ){
        String sql = "select * from [OrderDetail] od JOIN [Order] o ON od.OrderID = o.OrderID  where o.OrderID = ? ";
        try (Connection con = DBUtils.getConnection();
                PreparedStatement stmt = con.prepareStatement(sql)){
                stmt.setInt(1, id);
                ArrayList<OrderDTO> order = new ArrayList<>();
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                ArrayList<OrderDetailDTO> orderdetailDTO = ( new OrderDetailDAO().getOrderDetailByOrderId(rs.getInt("orderID")));
                ArrayList<UserDTO> user = (new UserDAO().getUserByUserID(rs.getInt("userID")));
                ArrayList<StatusDTO> statusDTO = ( new StatusDAO().getStatusByID(rs.getInt("statusID")));
                order.add(new OrderDTO(rs.getInt("OrderID"),rs.getInt("UserID"),rs.getInt("Amount"),rs.getDate("Date"),
                        rs.getString("Address"),rs.getInt("StatusID"), orderdetailDTO, user, statusDTO));
            }
            return order;
            
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
            return null ; 
    
}                      
        
        public ArrayList<OrderDTO> getOrder(int id){ // bat userID
            ArrayList<OrderDTO> od = new ArrayList<>();
            try {
                Connection con = DBUtils.getConnection();
                String sql = "SELECT OrderID, Amount, Date, Address, StatusID FROM [Order] WHERE UserID = ?";
                PreparedStatement stm = con.prepareStatement(sql);
                stm.setInt(1, id);
                ResultSet rs = stm.executeQuery();
                if(rs != null){
                    while(rs.next()){
                        int orderID = rs.getInt("OrderID");
                        int amount = rs.getInt("Amount");
                        Date date = rs.getDate("Date");
                        String address = rs.getString("Address");
                        int statusID = rs.getInt("StatusID");
                             ArrayList<StatusDTO> statusDTO = ( new StatusDAO().getStatusByID(statusID));
                        OrderDTO order = new OrderDTO();
                        order.setOrderID(orderID);
                        order.setAmount(amount);
                        order.setDate(date);
                        order.setAddress(address);
                        order.setStatusID(statusID);
                        order.setStatusDTO(statusDTO);
                        od.add(order);
                    }
                }
                con.close();
            } catch (SQLException e) {
                System.out.println("lỗi ở hàm getOrder" + e.getMessage());
                e.printStackTrace();
            }
               return od;
        }
        
        public ArrayList<OrderDTO> getOrderAfterDelete(int id){
            ArrayList<OrderDTO> od = new ArrayList<>();
            try {
                Connection con = DBUtils.getConnection();
                String sql = "SELECT OrderID, Amount, Date, Address FROM [Order] WHERE UserID = ? ";
                PreparedStatement stm = con.prepareStatement(sql);
                stm.setInt(1, id);
                ResultSet rs = stm.executeQuery();
                if(rs != null){
                    while(rs.next()){
                        int orderID = rs.getInt("OrderID");
                        int amount = rs.getInt("Amount");
                        Date date = rs.getDate("Date");
                        String address = rs.getString("Address");
                        
                        OrderDTO order = new OrderDTO();
                        order.setOrderID(orderID);
                        order.setAmount(amount);
                        order.setDate(date);
                        order.setAddress(address);
                        od.add(order);
                    }
                }
                con.close();
            } catch (SQLException e) {
                System.out.println("lỗi ở hàm getOrder" + e.getMessage());
                e.printStackTrace();
            }
               return od;
        }
        
        public boolean DeleteOrder(Integer orderID){
            try {
                Connection con = DBUtils.getConnection();
                String sql = " DELETE [Order] WHERE OrderID = ? ";
                PreparedStatement stm = con.prepareStatement(sql);
                stm.setInt(1, orderID);
                stm.executeUpdate();
                con.close();
                return true;
            } catch (SQLException e) {
                System.out.println("lỗi ở deleteOrder" + e.getMessage());
                e.printStackTrace();
            }
             return false;
        }

         public boolean deleteByOrderID ( int id ){
             String sql = "EXEC DeleteOrder @OrderID = ?";
             try(Connection con = DBUtils.getConnection();
                     PreparedStatement stmt = con.prepareStatement(sql)){
                 stmt.setInt(1, id);
            return  stmt.execute();
              
             }catch(SQLException ex){
                 ex.printStackTrace();
             }
             return false ; 
         }
         public void addOrder(UserDTO user,Cart cart){
             LocalDate userDate = java.time.LocalDate.now();
             String date = userDate.toString();
             String sql = " insert into [Order] values (?,?,?,?,?)";
             try(Connection con = DBUtils.getConnection()){
             PreparedStatement stmt = con.prepareStatement(sql);
             stmt.setInt(1, user.getUserID());
             stmt.setInt(2, cart.getAmountCart());
             stmt.setString(3, date);
             stmt.setString(4, cart.getAddressCart());
             stmt.setInt(5,1); // auto confirm 
             stmt.executeUpdate();
             String sql1 = "select Top 1 OrderID from [Order] order by OrderID desc ";
             PreparedStatement stmt1 = con.prepareStatement(sql1);
             ResultSet rs = stmt1.executeQuery();
             if(rs.next()){
                int orderID = rs.getInt(1);
             
             for(Item i : cart.getItems()){
                 String sql2=" insert into [OrderDetail] values (?,?,?,?,?) ";
                 PreparedStatement stmt2 = con.prepareStatement(sql2);
                 stmt2.setInt(1, orderID);
                 stmt2.setInt(2, i.getProduct().getProductID());
                 stmt2.setInt(3, i.getPrice());
                 stmt2.setInt(4, i.getQuantity());
                stmt2.setDouble(5, cart.getTotalMoney());
                stmt2.executeUpdate();
             }
             }
             }catch(SQLException ex){
                 ex.printStackTrace();
             }
             
         }

}
