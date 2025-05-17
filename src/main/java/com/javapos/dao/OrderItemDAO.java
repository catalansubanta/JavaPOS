package com.javapos.dao;

import com.javapos.database.DatabaseConnection;
import com.javapos.model.OrderItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderItemDAO {
    private Connection connection;

    public OrderItemDAO() {
        try {
            this.connection = DatabaseConnection.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ✅ Add OrderItem
    public boolean addOrderItem(OrderItem item) {
        String sql = "INSERT INTO orderitems (Order_ID, Item_ID, Quantity, Price, Subtotal) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, item.getOrderId());
            stmt.setInt(2, item.getItemId());
            stmt.setInt(3, item.getQuantity());
            stmt.setDouble(4, item.getPrice());
            stmt.setDouble(5, item.getSubtotal());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Get OrderItems by Order_ID
    public List<OrderItem> getOrderItemsByOrderId(int orderId) {
        List<OrderItem> itemList = new ArrayList<>();
        String sql = "SELECT * FROM orderitems WHERE Order_ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                OrderItem item = new OrderItem(
                    rs.getInt("OrderItem_ID"),
                    rs.getInt("Order_ID"),
                    rs.getInt("Item_ID"),
                    rs.getInt("Quantity"),
                    rs.getDouble("Price"),
                    rs.getDouble("Subtotal")
                );
                itemList.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return itemList;
    }

    // ✅ Delete all order items by Order_ID
    public boolean deleteOrderItemsByOrderId(int orderId) {
        String sql = "DELETE FROM orderitems WHERE Order_ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Delete order item by OrderItem_ID
    public boolean deleteOrderItemById(int orderItemId) {
        String sql = "DELETE FROM orderitems WHERE OrderItem_ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderItemId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Update order item quantity and subtotal
    public boolean updateOrderItem(OrderItem item) {
        String sql = "UPDATE orderitems SET Quantity = ?, Price = ?, Subtotal = ? WHERE OrderItem_ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, item.getQuantity());
            stmt.setDouble(2, item.getPrice());
            stmt.setDouble(3, item.getSubtotal());
            stmt.setInt(4, item.getOrderItemId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
