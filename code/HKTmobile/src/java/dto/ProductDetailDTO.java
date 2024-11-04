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
public class ProductDetailDTO {
    private int detailID;
    private int groupID;
    private String screen;
    private String os;
    private String afterCam;
    private String frontCam;
    private String chip;
    private String sim;
    private String pin;

    // Constructors
    public ProductDetailDTO() {}

    public ProductDetailDTO( int groupID, String screen, String os, String afterCam, String frontCam, String chip, String sim, String pin) {
 
        this.groupID = groupID;
        this.screen = screen;
        this.os = os;
        this.afterCam = afterCam;
        this.frontCam = frontCam;
        this.chip = chip;
        this.sim = sim;
        this.pin = pin;
    }

    public ProductDetailDTO(String screen, String os, String afterCam, String frontCam, String chip, String sim, String pin) {
        this.screen = screen;
        this.os = os;
        this.afterCam = afterCam;
        this.frontCam = frontCam;
        this.chip = chip;
        this.sim = sim;
        this.pin = pin;
    }

    // Getters and Setters
    public int getDetailID() {
        return detailID;
    }

    public void setDetailID(int detailID) {
        this.detailID = detailID;
    }

    public int getGroupID() {
        return groupID;
    }

    public void setGroupID(int groupID) {
        this.groupID = groupID;
    }

    public String getScreen() {
        return screen;
    }

    public void setScreen(String screen) {
        this.screen = screen;
    }

    public String getOs() {
        return os;
    }

    public void setOs(String os) {
        this.os = os;
    }

    public String getAfterCam() {
        return afterCam;
    }

    public void setAfterCam(String afterCam) {
        this.afterCam = afterCam;
    }

    public String getFrontCam() {
        return frontCam;
    }

    public void setFrontCam(String frontCam) {
        this.frontCam = frontCam;
    }

    public String getChip() {
        return chip;
    }

    public void setChip(String chip) {
        this.chip = chip;
    }

    public String getSim() {
        return sim;
    }

    public void setSim(String sim) {
        this.sim = sim;
    }

    public String getPin() {
        return pin;
    }

    public void setPin(String pin) {
        this.pin = pin;
    }
}
