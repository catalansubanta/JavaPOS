package com.javapos.model;

import java.sql.Timestamp;

public class Order {
    private int orderId;
    private int userId;          
    private Integer tableId;     
    private String orderType;    
    private Timestamp orderTime;
    private String orderStatus;  
    private double totalPrice;

    public Order() {}

    public Order(int orderId, int userId, Integer tableId, String orderType,
                 Timestamp orderTime, String orderStatus, double totalPrice) {
        this.orderId = orderId;
        this.userId = userId;
        this.tableId = tableId;
        this.orderType = orderType;
        this.orderTime = orderTime;
        this.orderStatus = orderStatus;
        this.totalPrice = totalPrice;
    }

    // Getters and setters
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public Integer getTableId() { return tableId; }
    public void setTableId(Integer tableId) { this.tableId = tableId; }

    public String getOrderType() { return orderType; }
    public void setOrderType(String orderType) { this.orderType = orderType; }

    public Timestamp getOrderTime() { return orderTime; }
    public void setOrderTime(Timestamp orderTime) { this.orderTime = orderTime; }

    public String getOrderStatus() { return orderStatus; }
    public void setOrderStatus(String orderStatus) { this.orderStatus = orderStatus; }
    
    public String getStatus() {
        return orderStatus;
    }

    public double getTotalAmount() {
        return totalPrice;
    }


    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }
}
