package com.javapos.model;

import java.util.Date;

public class Cart {
    private int cartId;
    private int userId;
    private int itemId;
    private int quantity;
    private Date createdAt;
    private Item item;

    // Getters and Setters
    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
    
    public Item getItem() {
        return item;
    }

    public void setItem(Item item) {
        this.item = item;
    }
}
