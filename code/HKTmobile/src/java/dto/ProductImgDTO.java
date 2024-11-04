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
public class ProductImgDTO {
    private int imgID;
    private String img;

    // Constructors, getters, and setters

    public ProductImgDTO() {
    }

    public ProductImgDTO(int imgID, String img) {
        this.imgID = imgID;
        this.img = img;
    }

    public int getImgID() {
        return imgID;
    }

    public void setImgID(int imgID) {
        this.imgID = imgID;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }
}
