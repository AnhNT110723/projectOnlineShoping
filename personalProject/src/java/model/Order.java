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
public class Order {

    private int id;
    private String firstName;
    private String lastName;
    private String address;
    private String phone;

    private Date date;
    private double toalmoney;
    private int cid;

    public Order() {
    }

    public Order(int id, String firstName, String lastName, String address, String phone, Date date, double toalmoney, int cid) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.address = address;
        this.phone = phone;
        this.date = date;
        this.toalmoney = toalmoney;
        this.cid = cid;
    }

    public Order(String firstName, String lastName, String address, String phone, Date date, double toalmoney, int cid) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.address = address;
        this.phone = phone;
        this.date = date;
        this.toalmoney = toalmoney;
        this.cid = cid;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public double getToalmoney() {
        return toalmoney;
    }

    public void setToalmoney(double toalmoney) {
        this.toalmoney = toalmoney;
    }

    @Override
    public String toString() {
        return "Order{" + "id=" + id + ", firstName=" + firstName + ", lastName=" + lastName + ", address=" + address + ", phone=" + phone + ", date=" + date + ", toalmoney=" + toalmoney + ", cid=" + cid + '}';
    }

}
