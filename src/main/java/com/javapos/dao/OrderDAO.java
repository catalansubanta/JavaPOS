package com.javapos.dao;

import com.javapos.database.DatabaseConnection;
import com.javapos.model.Order;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    private Connection connection;

    public OrderDAO() {
        try {
            this.connection = DatabaseConnection.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Get total sales from the Total_Price of completed orders
    public double getTotalSales() {
        String query = "SELECT SUM(Total_Price) AS total FROM Orders WHERE Order_Status = 'completed'";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            if (rs.next()) {
                return rs.getDouble("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    // Get recent orders
    public List<Order> getRecentOrders(int limit) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM Orders ORDER BY Order_Time DESC LIMIT ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                orders.add(mapOrder(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    // Map ResultSet to Order object
    private Order mapOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setOrderId(rs.getInt("Order_ID"));
        order.setUserId(rs.getInt("User_ID"));
        order.setTableId(rs.getInt("Table_ID"));
        order.setOrderType(rs.getString("Order_Type"));
        order.setOrderDate(rs.getTimestamp("Order_Time"));
        order.setStatus(rs.getString("Order_Status"));
        order.setTotalAmount(rs.getDouble("Total_Price"));
        return order;
    }

    // Optionally get order count
    public int getTotalOrderCount() {
        String query = "SELECT COUNT(*) AS total FROM Orders";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Optional: get number of orders by status
    public int getOrdersByStatus(String status) {
        String query = "SELECT COUNT(*) AS total FROM Orders WHERE Order_Status = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
