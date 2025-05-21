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

    public int insertOrder(Order order) {
        int orderId = 0;

        String sql = "INSERT INTO orders (user_id, table_id, order_type, status, total_price, order_time) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, order.getUserId());
            if (order.getTableId() != null) {
                stmt.setInt(2, order.getTableId());
            } else {
                stmt.setNull(2, java.sql.Types.INTEGER);
            }
            stmt.setString(3, order.getOrderType());
            stmt.setString(4, order.getOrderStatus());
            stmt.setDouble(5, order.getTotalPrice());
            stmt.setTimestamp(6, order.getOrderTime());

            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        orderId = rs.getInt(1);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orderId;
    }


    // Get all orders placed by a specific user (waiter)
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE User_ID = ? ORDER BY Order_Time DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("Order_ID"));
                order.setUserId(rs.getInt("User_ID"));
                order.setTableId(rs.getObject("Table_ID") != null ? rs.getInt("Table_ID") : null);
                order.setOrderType(rs.getString("Order_Type"));
                order.setOrderTime(rs.getTimestamp("Order_Time"));
                order.setOrderStatus(rs.getString("Order_Status"));
                order.setTotalPrice(rs.getDouble("Total_Price"));

                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }

    // Optional: get a specific order by ID
    public Order getOrderById(int orderId) {
        String sql = "SELECT * FROM orders WHERE Order_ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("Order_ID"));
                order.setUserId(rs.getInt("User_ID"));
                order.setTableId(rs.getObject("Table_ID") != null ? rs.getInt("Table_ID") : null);
                order.setOrderType(rs.getString("Order_Type"));
                order.setOrderTime(rs.getTimestamp("Order_Time"));
                order.setOrderStatus(rs.getString("Order_Status"));
                order.setTotalPrice(rs.getDouble("Total_Price"));

                return order;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
    
    
    public List<Order> getRecentOrders(int limit) { return new ArrayList<>(); }
    public int getTotalOrderCount() { return 0; }
    public double getTotalSales() { return 0.0; }
    public int getUnpaidOrdersCount() { return 0; }

    // For PaymentController
    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET Order_Status = ? WHERE Order_ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM orders");
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setTableId(rs.getInt("table_id"));
                order.setOrderType(rs.getString("order_type"));
                order.setOrderStatus(rs.getString("status"));
                order.setTotalPrice(rs.getDouble("total_price"));
                order.setOrderTime(rs.getTimestamp("order_time"));

                orders.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace(); // Optionally use a logger
        }

        return orders;
    }

    
    
    public List<Order> getOrdersByStatus(String status) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE orderStatus = ? ORDER BY orderTime DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("orderId"));
                order.setUserId(rs.getInt("userId"));
                order.setOrderTime(rs.getTimestamp("orderTime"));
                order.setOrderType(rs.getString("orderType"));
                order.setOrderStatus(rs.getString("orderStatus"));
                order.setTotalPrice(rs.getDouble("totalPrice"));
                order.setTableId((Integer) rs.getObject("tableId"));
                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }


    
}
