/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Anh hung
 */
public class Product {

    private int id;
    private String name;
    private String image;
    private String image2;
    private String image3;
    private String image4;
    private double price;
    private String title;
    private String description;
    private int amount;

    private int cateId;
    private int sellId;

    public Product() {
    }

    public Product(int id, String name, String image1, double price, String title, String description, int cateId) {
        this.id = id;
        this.name = name;
        this.image = image1;
        this.price = price;
        this.title = title;
        this.description = description;
        this.cateId = cateId;
    }

    public Product(int id, String name, String image1, double price, String title, String description) {
        this.id = id;
        this.name = name;
        this.image = image1;
        this.price = price;
        this.title = title;
        this.description = description;

    }

    public Product(int id, String name, String image, String image2, String image3, String image4, double price, String title, String description, int cateId, int sellId) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.image2 = image2;
        this.image3 = image3;
        this.image4 = image4;
        this.price = price;
        this.title = title;
        this.description = description;
        this.cateId = cateId;
        this.sellId = sellId;
    }

    public Product(int id, String name, String image, double price, int amount) {
        this.id = id;
        this.name = name;
        this.image = image;       
        this.price = price;
        this.amount = amount;
       
    }
    
    

    public String getImage() {
        return image;
    }

    public void setImage(String image1) {
        this.image = image1;
    }

    public String getImage2() {
        return image2;
    }

    public void setImage2(String image2) {
        this.image2 = image2;
    }

    public String getImage3() {
        return image3;
    }

    public void setImage3(String image3) {
        this.image3 = image3;
    }

    public String getImage4() {
        return image4;
    }

    public void setImage4(String image4) {
        this.image4 = image4;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    
    
    public int getCateId() {
        return cateId;
    }

    public void setCateId(int cateId) {
        this.cateId = cateId;
    }

    public int getSellId() {
        return sellId;
    }

    public void setSellId(int sellId) {
        this.sellId = sellId;
    }

    @Override
    public String toString() {
        return "Product{" + "id=" + id + ", name=" + name + ", image1=" + image + ", image2=" + image2 + ", image3=" + image3 + ", image4=" + image4 + ", price=" + price + ", title=" + title + ", description=" + description + ", cateId=" + cateId + ", sellId=" + sellId + '}';
    }

 

}
