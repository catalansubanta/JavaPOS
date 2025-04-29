package com.javapos.dao;

import com.javapos.database.DatabaseConnection;
import com.javapos.model.Item;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemDAO {
    public List<Item> getAllItems() {
        List<Item> itemList = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT * FROM Items";
            PreparedStatement stmt = conn.prepareStatement(sql);
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
}
