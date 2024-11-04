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
public class BrandDTO {
    private int brandID;
    private String brandName;
    private int number;

    public BrandDTO() {
    }

    public BrandDTO(int brandID, String brandName) {
        this.brandID = brandID;
        this.brandName = brandName;
    }
    

    public BrandDTO(int brandID, String brandName, int number) {
        this.brandID = brandID;
        this.brandName = brandName;
        this.number = number;
    }
    

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public int getBrandID() {
        return brandID;
    }

    public void setBrandID(int brandID) {
        this.brandID = brandID;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }


}

