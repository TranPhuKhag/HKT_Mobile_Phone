/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dto;

/**
 *
 * @author Administrator
 */
public class Item {
    private ProductDTO product ;
    private int price ;
    private int quantity ;
    private OrderDetailDTO orderDetail ; 

    public Item() {
    }

    public Item(ProductDTO product, int price, int quantity, OrderDetailDTO orderDetail) {
        this.product = product;
        this.price = price;
        this.quantity = quantity;
        this.orderDetail = orderDetail;
    }
    

    public Item(ProductDTO product, int price, int quantity) {
        this.product = product;
        this.price = price;
        this.quantity = quantity;
    }

    public ProductDTO getProduct() {
        return product;
    }

    public void setProduct(ProductDTO product) {
        this.product = product;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public OrderDetailDTO getOrderDetail() {
        return orderDetail;
    }

    public void setOrderDetail(OrderDetailDTO orderDetail) {
        this.orderDetail = orderDetail;
    }
        
        
    
}
