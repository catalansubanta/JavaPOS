package com.javapos.model;

public class CartItemDetail {
    private Cart cart;
    private Item item;

    public CartItemDetail(Cart cart, Item item) {
        this.cart = cart;
        this.item = item;
    }

    public Cart getCart() {
        return cart;
    }

    public Item getItem() {
        return item;
    }
}
