/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dto;

import dao.ProductDAO;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */


public class OrderDetailDTO {
    private int orderID;
    private int productID;
    private int unitPrice;
    private int quantity;
    private int totalPrice ; 
    private ArrayList<ProductDTO> product ;
    private List<ProductDTO> productList ;

    public OrderDetailDTO(int orderID, int productID, int unitPrice, int quantity, int totalPrice, List<ProductDTO> productList) {
        this.orderID = orderID;
        this.productID = productID;
        this.unitPrice = unitPrice;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
        this.productList = productList;
    }
    
    

    public OrderDetailDTO(int orderID, int productID, int unitPrice, int quantity, int totalPrice, ArrayList<ProductDTO> product) {
        this.orderID = orderID;
        this.productID = productID;
        this.unitPrice = unitPrice;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
        this.product = product;
    }
    

    public OrderDetailDTO() {
    }

    public OrderDetailDTO(int orderID, int productID, int unitPrice, int quantity) {
        this.orderID = orderID;
        this.productID = productID;
        this.unitPrice = unitPrice;
        this.quantity = quantity;
    }

    public OrderDetailDTO(int orderID, int productID, int unitPrice, int quantity, ArrayList<ProductDTO> product) {
        this.orderID = orderID;
        this.productID = productID;
        this.unitPrice = unitPrice;
        this.quantity = quantity;
        this.product = product;
    }

    public List<ProductDTO> getProductList() {
        return productList;
    }

    public void setProductList(List<ProductDTO> productList) {
        this.productList = productList;
    }
    


    

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(int unitPrice) {
        this.unitPrice = unitPrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public ArrayList<ProductDTO> getProduct() {
        return product;
    }

    public void setProduct(ArrayList<ProductDTO> product) {
        this.product = product;
    }

    public int getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(int totalPrice) {
        this.totalPrice = totalPrice;
    }
    
}

