package com.javapos.model;

public class Item {
    private int itemId;
    private String itemName;
    private String description;
    private double price;
    private String category;
    private float stock;
    private String unit;
    private String imagePath;

    // Constructors
    public Item() {}

    public Item(int itemId, String itemName, String description, double price, String category, float stock, String unit, String imagePath) {
        this.itemId = itemId;
        this.itemName = itemName;
        this.description = description;
        this.price = price;
        this.category = category;
        this.stock = stock;
        this.unit = unit;
        this.imagePath = imagePath;
    }

    // Getters and Setters
    public int getItemId() { return itemId; }
    public void setItemId(int itemId) { this.itemId = itemId; }

    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public float getStock() { return stock; }
    public void setStock(float stock) { this.stock = stock; }

    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }
    
    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }
}
