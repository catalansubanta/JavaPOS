package com.javapos.model;

import java.sql.Timestamp;

public class Payment {
    private int paymentId;
    private int orderId;
    private double paidAmount;
    private Timestamp paymentTime;
    private String paymentStatus;

    public Payment() {}

    public Payment(int paymentId, int orderId, double paidAmount, Timestamp paymentTime, String paymentStatus) {
        this.paymentId = paymentId;
        this.orderId = orderId;
        this.paidAmount = paidAmount;
        this.paymentTime = paymentTime;
        this.paymentStatus = paymentStatus;
    }

    // Getters and Setters
    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public double getPaidAmount() {
        return paidAmount;
    }

    public void setPaidAmount(double paidAmount) {
        this.paidAmount = paidAmount;
    }

    public Timestamp getPaymentTime() {
        return paymentTime;
    }

    public void setPaymentTime(Timestamp paymentTime) {
        this.paymentTime = paymentTime;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }
}
