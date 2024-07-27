/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author Anh hung
 */
public class review {
    private String id;
    private String name;
    private String email;
    private int rating;
    private String review_text;
    private Date date;
    private int pid;
    private int accid;
    private String username;
    private int sum;
    public review() {
    }

    public review(String id, String name, String email, int rating, Date date, int pid, int accid) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.rating = rating;
        this.date = date;
        this.pid = pid;
        this.accid = accid;
    }

    public review(String id, String name, String email, int rating, String review_text, Date date, int pid,  String username) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.rating = rating;
        this.review_text = review_text;
        this.date = date;
        this.pid = pid;
        this.username = username;
    }

    public review(String id,int sum) {
        this.id = id;
        this.sum = sum;
    }

    public int getSum() {
        return sum;
    }

    public void setSum(int sum) {
        this.sum = sum;
    }

    
    
    public String getReview_text() {
        return review_text;
    }

    public void setReview_text(String review_text) {
        this.review_text = review_text;
    }


    
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    
    

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    
    


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public int getAccid() {
        return accid;
    }

    public void setAccid(int accid) {
        this.accid = accid;
    }

    @Override
    public String toString() {
        return "review{" + "id=" + id + ", name=" + name + ", email=" + email + ", rating=" + rating + ", pid=" + pid + ", accid=" + accid + '}';
    }
    
     
}
