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
import java.util.List;

public class ProductDTO { 
    private int productID;
    private String productName;
    private int groupID;
    private int ram;
    private String color;
    private int storage;
    private int price;
    private int newPrice;
    private double rate;
    private int discount;
    private List<ProductImgDTO> productImg;
    private ArrayList<ProductGroupDTO> productGroup ; 


    // Constructors, getters, and setters

    public ProductDTO() {
      
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }

    public ProductDTO(int productID, String productName, int groupID, int ram, String color, int storage, int price, int newPrice, int discount, ArrayList<ProductGroupDTO> productGroup) {
        this.productID = productID;
        this.productName = productName;
        this.groupID = groupID;
        this.ram = ram;
        this.color = color;
        this.storage = storage;
        this.price = price;
        this.newPrice = newPrice;
        this.discount = discount;
        this.productGroup = productGroup;
    }
    

    public ProductDTO(int productID, int groupID, int ram, String color, int storage, int price) {
        this.productID = productID;
        this.groupID = groupID;
        this.ram = ram;
        this.color = color;
        this.storage = storage;
        this.price = price;
    }

    public ProductDTO(int productID, int groupID, int ram, String color, int storage, int price, ArrayList<ProductGroupDTO> productGroup) {
        this.productID = productID;
        this.groupID = groupID;
        this.ram = ram;
        this.color = color;
        this.storage = storage;
        this.price = price;
        this.productGroup = productGroup;
    }
    



    public ProductDTO(int productID, String productName, int groupID, int ram, String color, int storage, int price, int newPrice, ArrayList<ProductGroupDTO> productGroup) {
        this.productID = productID;
        this.productName = productName;
        this.groupID = groupID;
        this.ram = ram;
        this.color = color;
        this.storage = storage;
        this.price = price;
        this.newPrice = newPrice;
        this.productGroup = productGroup;
    }

    public ProductDTO(int productID, String productName, int groupID, int ram, String color, int storage, int price, int newPrice, double rate, ArrayList<ProductGroupDTO> productGroup) {
        this.productID = productID;
        this.productName = productName;
        this.groupID = groupID;
        this.ram = ram;
        this.color = color;
        this.storage = storage;
        this.price = price;
        this.newPrice = newPrice;
        this.rate = rate;
        this.productGroup = productGroup;
    }

    public ProductDTO(int productID, String productName, int groupID, int ram, String color, int storage, int price, ArrayList<ProductGroupDTO> productGroup) {
        this.productID = productID;
        this.productName = productName;
        this.groupID = groupID;
        this.ram = ram;
        this.color = color;
        this.storage = storage;
        this.price = price;
        this.productGroup = productGroup;
    }
    

  

    public ProductDTO(int productID, String productName, int groupID, int ram, String color, int storage, int price, int newPrice, List<ProductImgDTO> productImg) {
        this.productID = productID;
        this.productName = productName;
        this.groupID = groupID;
        this.ram = ram;
        this.color = color;
        this.storage = storage;
        this.price = price;
        this.newPrice = newPrice;
        this.productImg = productImg;
    }

   
    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getGroupID() {
        return groupID;
    }

    public void setGroupID(int groupID) {
        this.groupID = groupID;
    }

    public int getRam() {
        return ram;
    }

    public void setRam(int ram) {
        this.ram = ram;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public int getStorage() {
        return storage;
    }

    public void setStorage(int storage) {
        this.storage = storage;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getNewPrice() {
        return newPrice;
    }

    public void setNewPrice(int newPrice) {
        this.newPrice = newPrice;
    }

    public List<ProductImgDTO> getProductImg() {
        return productImg;
    }

    public void setProductImg(List<ProductImgDTO> productImg) {
        this.productImg = productImg;
    }

    public ArrayList<ProductGroupDTO> getProductGroup() {
        return productGroup;
    }

    public void setProductGroup(ArrayList<ProductGroupDTO> productGroup) {
        this.productGroup = productGroup;
    }

 
    public double getRate() {
        return rate;
    }

    public void setRate(double rate) {
        this.rate = rate;
    }
                            
   

   



    

}
