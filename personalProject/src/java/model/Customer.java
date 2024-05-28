/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Anh hung
 */
public class Customer {

    private int id;
    private String userName;
    private double amount;
    private String pass;
    private String email;

    private int isSellId;
    private int isadmin;
    private String code;

    public Customer() {
    }

    public Customer(int id, String userName, String pass, String email, int isSellId, int isadmin, String code) {
        this.id = id;
        this.userName = userName;
        this.pass = pass;
        this.email = email;

        this.isSellId = isSellId;
        this.isadmin = isadmin;
        this.code = code;
    }

    public Customer(int id, String userName, double amount, String pass, String email, int isSellId, int isadmin, String code) {
        this.id = id;
        this.userName = userName;
        this.amount = amount;
        this.pass = pass;
        this.email = email;
        this.isSellId = isSellId;
        this.isadmin = isadmin;
        this.code = code;
    }

    public Customer(int id, String userName, String pass, String email, double amount, int isSellId, int isadmin) {
        this.id = id;
        this.userName = userName;
        this.pass = pass;
        this.email = email;
        this.amount = amount;
        this.isSellId = isSellId;
        this.isadmin = isadmin;
    }

    public Customer(String userName, String pass, String email,String code,int  isSellId, int isadmin) {

        this.userName = userName;
        this.pass = pass;
        this.email = email;
        this.code = code;
        this.isSellId = isSellId;
        this.isadmin = isadmin;
    }

    public Customer(int id, String userName, String email, String pass, int isSellId, int isadmin) {
        this.id = id;
        this.userName = userName;
        this.pass = pass;
        this.email = email;
        this.isSellId = isSellId;
        this.isadmin = isadmin;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getIsSellId() {
        return isSellId;
    }

    public void setIsSellId(int isSellId) {
        this.isSellId = isSellId;
    }

    public int getIsadmin() {
        return isadmin;
    }

    public void setIsadmin(int isadmin) {
        this.isadmin = isadmin;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Override
    public String toString() {
        return "Customer{" + "id=" + id + ", userName=" + userName + ", amount=" + amount + ", pass=" + pass + ", email=" + email + ", isSellId=" + isSellId + ", isadmin=" + isadmin + ", code=" + code + '}';
    }

}
