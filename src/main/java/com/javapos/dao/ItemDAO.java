package com.javapos.dao;

import com.javapos.database.DatabaseConnection;
import com.javapos.model.Item;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemDAO {
    private Connection connection;

    public ItemDAO() {
        try {
            this.connection = DatabaseConnection.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // to Get all items
    public List<Item> getAllItems() {
        List<Item> itemList = new ArrayList<>();
        String sql = "SELECT * FROM items";

        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Item item = new Item(
                    rs.getInt("Item_ID"),
                    rs.getString("Item_Name"),
                    rs.getString("Description"),
                    rs.getDouble("Price"),
                    rs.getString("Category"),
                    rs.getFloat("Stock"),
                    rs.getString("Unit"),
                    rs.getString("Image_Path")
                );
                itemList.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return itemList;
    }

    // to Get item by ID
    public Item getItemById(int itemId) {
        String sql = "SELECT * FROM items WHERE Item_ID = ?";
        Item item = null;

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, itemId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                item = new Item(
                    rs.getInt("Item_ID"),
                    rs.getString("Item_Name"),
                    rs.getString("Description"),
                    rs.getDouble("Price"),
                    rs.getString("Category"),
                    rs.getFloat("Stock"),
                    rs.getString("Unit"),
                    rs.getString("Image_Path")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return item;
    }

    // to Add new item
    public boolean addItem(Item item) {
        String sql = "INSERT INTO items (Item_Name, Description, Price, Category, Stock, Unit) VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, item.getItemName());
            stmt.setString(2, item.getDescription());
            stmt.setDouble(3, item.getPrice());
            stmt.setString(4, item.getCategory());
            stmt.setFloat(5, item.getStock());
            stmt.setString(6, item.getUnit());
            stmt.setString(7, item.getImagePath());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // to Update item
    public boolean updateItem(Item item) {
        String sql = "UPDATE items SET Item_Name = ?, Description = ?, Price = ?, Category = ?, Stock = ?, Unit = ? WHERE Item_ID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, item.getItemName());
            stmt.setString(2, item.getDescription());
            stmt.setDouble(3, item.getPrice());
            stmt.setString(4, item.getCategory());
            stmt.setFloat(5, item.getStock());
            stmt.setString(6, item.getUnit());
            stmt.setInt(7, item.getItemId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // ✅ Delete item
    public boolean deleteItem(int itemId) {
        String sql = "DELETE FROM items WHERE Item_ID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, itemId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // to Search by name
    public List<Item> searchItems(String name, String category) {
        List<Item> itemList = new ArrayList<>();
        String sql = "SELECT * FROM items WHERE 1=1";

        if (name != null && !name.isEmpty()) {
            sql += " AND Item_Name LIKE ?";
        }
        if (category != null && !category.isEmpty()) {
            sql += " AND Category = ?";
        }

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            int index = 1;
            if (name != null && !name.isEmpty()) {
                stmt.setString(index++, "%" + name + "%");
            }
            if (category != null && !category.isEmpty()) {
                stmt.setString(index++, category);
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Item item = new Item(
                    rs.getInt("Item_ID"),
                    rs.getString("Item_Name"),
                    rs.getString("Description"),
                    rs.getDouble("Price"),
                    rs.getString("Category"),
                    rs.getFloat("Stock"),
                    rs.getString("Unit"),
                    rs.getString("Image_Path")
                );
                itemList.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return itemList;
    }


    // to Get total item count
    public int getTotalItems() {
        String sql = "SELECT COUNT(*) AS total FROM items";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
