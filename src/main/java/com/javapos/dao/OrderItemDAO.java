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

    public void addOrderItem(OrderItem orderItem) {
        String sql = "INSERT INTO orderitems (Order_ID, Item_ID, Quantity, Price, Subtotal) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderItem.getOrderId());
            ps.setInt(2, orderItem.getItemId());
            ps.setInt(3, orderItem.getQuantity());
            ps.setDouble(4, orderItem.getPrice());
            ps.setDouble(5, orderItem.getSubtotal());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public List<OrderItem> getOrderItemsByOrderId(int orderId) {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT * FROM orderitems WHERE Order_ID = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderItem item = new OrderItem();
                    item.setOrderItemId(rs.getInt("OrderItem_ID"));
                    item.setOrderId(rs.getInt("Order_ID"));
                    item.setItemId(rs.getInt("Item_ID"));
                    item.setQuantity(rs.getInt("Quantity"));
                    item.setPrice(rs.getDouble("Price"));
                    item.setSubtotal(rs.getDouble("Subtotal"));
                    items.add(item);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return items;
    }
    
    
    
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
    
    
    public boolean insertOrderItem(OrderItem item) {
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

}
