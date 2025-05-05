package com.javapos.dao;

import com.javapos.model.Order;
import com.javapos.database.DatabaseConnection;
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

    public double getTotalSales() {
        String query = "SELECT SUM(Total_Amount) as total FROM Orders WHERE Status = 'Completed'";
        double total = 0.0;
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            if (rs.next()) {
                total = rs.getDouble("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return total;
    }

    public List<Order> getOrdersByDateRange(Date startDate, Date endDate) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM Orders WHERE Order_Date BETWEEN ? AND ? ORDER BY Order_Date DESC";
        
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setDate(1, startDate);
            stmt.setDate(2, endDate);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("Order_ID"));
                order.setOrderDate(rs.getDate("Order_Date"));
                order.setTotalAmount(rs.getDouble("Total_Amount"));
                order.setStatus(rs.getString("Status"));
                order.setPaymentMethod(rs.getString("Payment_Method"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return orders;
    }

    public List<Order> getOrdersByStatus(String status) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM Orders WHERE Status = ? ORDER BY Order_Date DESC";
        
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("Order_ID"));
                order.setOrderDate(rs.getDate("Order_Date"));
                order.setTotalAmount(rs.getDouble("Total_Amount"));
                order.setStatus(rs.getString("Status"));
                order.setPaymentMethod(rs.getString("Payment_Method"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return orders;
    }

    public boolean createOrder(Order order) {
        String query = "INSERT INTO Orders (Order_Date, Total_Amount, Status, Payment_Method) VALUES (?, ?, ?, ?)";
        
        try (PreparedStatement stmt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setDate(1, new java.sql.Date(order.getOrderDate().getTime()));
            stmt.setDouble(2, order.getTotalAmount());
            stmt.setString(3, order.getStatus());
            stmt.setString(4, order.getPaymentMethod());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        order.setOrderId(generatedKeys.getInt(1));
                        return true;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }

    public boolean updateOrderStatus(int orderId, String status) {
        String query = "UPDATE Orders SET Status = ? WHERE Order_ID = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
} 