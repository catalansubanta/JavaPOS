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

    public List<Item> getAllItems() {
        List<Item> itemList = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Items";
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Item item = new Item(
                    rs.getInt("Item_ID"),
                    rs.getString("Item_Name"),
                    rs.getString("Description"),
                    rs.getDouble("Price"),
                    rs.getString("Category"),
                    rs.getFloat("Stock"),
                    rs.getString("Unit")
                );
                itemList.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return itemList;
    }

    public Item getItemById(int itemId) {
        String query = "SELECT * FROM Items WHERE Item_ID = ?";
        Item item = null;
        
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, itemId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                item = new Item();
                item.setItemId(rs.getInt("Item_ID"));
                item.setItemName(rs.getString("Item_Name"));
                item.setCategory(rs.getString("Category"));
                item.setPrice(rs.getDouble("Price"));
                item.setStock(rs.getInt("Stock"));
                item.setUnit(rs.getString("Unit"));
                item.setDescription(rs.getString("Description"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return item;
    }

    public int getTotalItems() {
        String query = "SELECT COUNT(*) as total FROM Items";
        int total = 0;
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            if (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return total;
    }
}
