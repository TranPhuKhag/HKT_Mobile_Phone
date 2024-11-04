/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dto;

/**
 *
 * @author Admin
 */
import java.util.ArrayList;
import java.util.Date;

public class OrderDTO {
    private int orderID;
    private int userID;
    private int amount;
    private Date date;
    private String address;
    private int statusID;
    private ArrayList<OrderDetailDTO> orderdetailDTO ; 
    private ArrayList<UserDTO> userDTO ;
    private ArrayList<StatusDTO> statusDTO ;  

    public OrderDTO() {
    }

   
    
    public OrderDTO(int orderID, int userID, int amount, Date date, String address, int statusID) {
        this.orderID = orderID;
        this.userID = userID;
        this.amount = amount;
        this.date = date;
        this.address = address;
        this.statusID = statusID;
    }



    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getStatusID() {
        return statusID;
    }

    public void setStatusID(int statusID) {
        this.statusID = statusID;
    }

    public OrderDTO(int orderID, int userID, int amount, Date date, String address, int statusID, ArrayList<OrderDetailDTO> orderdetailDTO) {
        this.orderID = orderID;
        this.userID = userID;
        this.amount = amount;
        this.date = date;
        this.address = address;
        this.statusID = statusID;
        this.orderdetailDTO = orderdetailDTO;
    }

    public OrderDTO(int orderID, int amount, Date date, String address, int statusID, ArrayList<StatusDTO> statusDTO) {
        this.orderID = orderID;
        this.amount = amount;
        this.date = date;
        this.address = address;
        this.statusID = statusID;
        this.statusDTO = statusDTO;
    }

    public OrderDTO(int orderID, int userID, int amount, Date date, String address, int statusID, ArrayList<OrderDetailDTO> orderdetailDTO, ArrayList<UserDTO> userDTO, ArrayList<StatusDTO> statusDTO) {
        this.orderID = orderID;
        this.userID = userID;
        this.amount = amount;
        this.date = date;
        this.address = address;
        this.statusID = statusID;
        this.orderdetailDTO = orderdetailDTO;
        this.userDTO = userDTO;
        this.statusDTO = statusDTO;
    }

    public ArrayList<OrderDetailDTO> getOrderdetailDTO() {
        return orderdetailDTO;
    }

    public void setOrderdetailDTO(ArrayList<OrderDetailDTO> orderdetailDTO) {
        this.orderdetailDTO = orderdetailDTO;
    }

    public ArrayList<UserDTO> getUserDTO() {
        return userDTO;
    }

    public void setUserDTO(ArrayList<UserDTO> userDTO) {
        this.userDTO = userDTO;
    }

    public ArrayList<StatusDTO> getStatusDTO() {
        return statusDTO;
    }

    public void setStatusDTO(ArrayList<StatusDTO> statusDTO) {
        this.statusDTO = statusDTO;
    }

   
    
    
    
}

