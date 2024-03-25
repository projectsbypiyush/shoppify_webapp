
package com.learn.mycart.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import org.hibernate.annotations.ManyToAny;

@Entity
public class Product{
    
    @Id
    @GeneratedValue(strategy =GenerationType.IDENTITY )
    private int pId;
    private String pName;
    @Column(length = 2000)    
    private String pDesc;
    private String pPic;
    private int pPrice;
    private int pDiscount;
    private int pQty;
    @ManyToOne 
    private Category category;

    public Product() {
    }

    public Product(int pId, String pName, String pDesc, String pPic, int pPrice, int pDiscount, int pQty, Category category) {
        this.pId = pId;
        this.pName = pName;
        this.pDesc = pDesc;
        this.pPic = pPic;
        this.pPrice = pPrice;
        this.pDiscount = pDiscount;
        this.pQty = pQty;
        this.category = category;
        
    }

    public Product(String pName, String pDesc, String pPic, int pPrice, int pDiscount, int pQty) {
        this.pName = pName;
        this.pDesc = pDesc;
        this.pPic = pPic;
        this.pPrice = pPrice;
        this.pDiscount = pDiscount;
        this.pQty = pQty;
    }

    public int getpId() {
        return pId;
    }

    public void setpId(int pId) {
        this.pId = pId;
    }

    public String getpName() {
        return pName;
    }

    public void setpName(String pName) {
        this.pName = pName;
    }

    public String getpDesc() {
        return pDesc;
    }

    public void setpDesc(String pDesc) {
        this.pDesc = pDesc;
    }

    public String getpPic() {
        return pPic;
    }

    public void setpPic(String pPic) {
        this.pPic = pPic;
    }

    public int getpPrice() {
        return pPrice;
    }

    public void setpPrice(int pPrice) {
        this.pPrice = pPrice;
    }

    public int getpDiscount() {
        return pDiscount;
    }

    public void setpDiscount(int pDiscount) {
        this.pDiscount = pDiscount;
    }

    public int getpQty() {
        return pQty;
    }

    public void setpQty(int pQty) {
        this.pQty = pQty;
    }

    @Override
    public String toString() {
        return "Product{" + "pId=" + pId + ", pName=" + pName + ", pDesc=" + pDesc + ", pPic=" + pPic + ", pPrice=" + pPrice + ", pDiscount=" + pDiscount + ", pQty=" + pQty + '}';
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }
    
    public int getDiscountedPrice(){
        int d = (int)((this.getpDiscount()/100.0)*this.getpPrice());
        return (this.getpPrice()-d);
    }
    
}