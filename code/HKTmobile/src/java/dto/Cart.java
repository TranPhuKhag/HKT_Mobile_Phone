/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dto;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Administrator
 */
public class Cart {
    private  List<Item> items ;
    private String addressCart ; 
    private int amountCart ;

    
    public Cart() {
        items = new ArrayList<>();
    }

    public Cart(List<Item> items) {
        this.items = items;
    }

    public Cart(List<Item> items, String addressCart, int amountCart) {
        this.items = items;
        this.addressCart = addressCart;
        this.amountCart = amountCart;
    }

    public Cart(String addressCart, int amountCart) {
        this.addressCart = addressCart;
        this.amountCart = amountCart;
    }
   
    

    public List<Item> getItems() {
        return items;
    }

    public void setItems(List<Item> items) {
        this.items = items;
    }

    public String getAddressCart() {
        return addressCart;
    }

    public void setAddressCart(String addressCart) {
        this.addressCart = addressCart;
    }

    public int getAmountCart() {
        return amountCart;
    }

    public void setAmountCart(int amountCart) {
        this.amountCart = amountCart;
    }
    
    public Item getItemByID (int id ){
        for(Item i :items){
            if(i.getProduct().getProductID()==id){
                return i ; 
            }
        }
        return null ;
    }
    // lấy số lượng của sản phẩm có trong giỏ hàng 
    public int getQuantityByID (int id ){
        return getItemByID(id).getQuantity();
    }
    //thêm sản phẩm vào giỏ hàng 
    public void addItem (Item t){
        if(getItemByID(t.getProduct().getProductID())!=null){
            Item i = getItemByID(t.getProduct().getProductID());
            i.setQuantity(i.getQuantity()+t.getQuantity());
        }else {
            items.add(t);
        }
    }
    
    //Xoá sản phẩm có trong giỏ hàng 
    public void removeItemByID (int id ){
        if(getItemByID(id)!=null){
            items.remove(getItemByID(id));
        }
    }
    // tổng tiền cảu hoá đơn đó 
    public double getTotalMoney(){
        double t = 0 ;
                for(Item i : items){
                    t+=i.getQuantity()*i.getProduct().getNewPrice();
                }
                return t ; 
    }
    
}
