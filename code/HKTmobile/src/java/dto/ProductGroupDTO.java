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

public class ProductGroupDTO {

    private int groupID;
    private String productName;
    private int brandId;
    private String brandName;
    private String description;
    private String img;
    private int discount;
    private List<ProductDTO> products;
    private ArrayList<BrandDTO> brands ;

    // Constructors, getters, and setters
    public ProductGroupDTO() {
    }
    

    
    public ProductGroupDTO(int groupID, String productName, int brandId, String description, String img, int discount) {
         this.groupID = groupID;
        this.productName = productName;
        this.brandId = brandId;
        this.description = description;
        this.img = img;
        this.discount = discount;
    }
    public ProductGroupDTO(int groupID, String productName, int brandId, String description, String img) {
        this.groupID = groupID;
        this.productName = productName;
        this.brandId = brandId;
        this.description = description;
        this.img = img;
      
    }

    public ProductGroupDTO(int groupID, String productName, String description, String img, int discount, ArrayList<BrandDTO> brands) {
        this.groupID = groupID;
        this.productName = productName;
        this.description = description;
        this.img = img;
        this.discount = discount;
        this.brands = brands;
    }

    public ProductGroupDTO(int groupID, String productName, int brandId, String description, String img, int discount, ArrayList<BrandDTO> brands) {
        this.groupID = groupID;
    }

    public ProductGroupDTO(String productName, int brandId, String description, String img) {
        this.productName = productName;
        this.brandId = brandId;
        this.description = description;
        this.img = img;
        this.discount = discount;
        this.brands = brands;
    }

   

    public ProductGroupDTO(int groupID, String productName, int brandId, String brandName, String description, String img, int discount, List<ProductDTO> products, ArrayList<BrandDTO> brands) {
        this.groupID = groupID;
        this.productName = productName;
        this.brandId = brandId;
        this.brandName = brandName;
        this.description = description;
        this.img = img;
        this.discount = discount;
        this.products = products;
        this.brands = brands;
    }

    
     
    


    public int getGroupID() {
        return groupID;
    }

    public void setGroupID(int groupID) {
        this.groupID = groupID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getBrandId() {
        return brandId;
    }

    public void setBrandId(int brandId) {
        this.brandId = brandId;
    }
    
    
    
    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String BrandName) {
        this.brandName = BrandName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }

    public List<ProductDTO> getProducts() {
        return products;
    }

    public void setProducts(List<ProductDTO> products) {
        this.products = products;
    }
}
