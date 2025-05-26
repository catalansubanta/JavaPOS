package com.javapos.dao;

import com.javapos.database.DatabaseConnection;
import com.javapos.model.Cart;
import com.javapos.model.Order;
import com.javapos.model.OrderItem;
import com.javapos.model.Item;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;

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
        String sql = "INSERT INTO orders (user_id, table_id, order_type, order_status, total_price, order_time) VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, order.getUserId());
            if (order.getTableId() != null) {
                stmt.setInt(2, order.getTableId());
            } else {
                stmt.setNull(2, Types.INTEGER);
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
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderId;
    }

    public boolean placeOrder(List<Cart> cartItems, int userId, String orderType, int tableId) {
        boolean success = false;

        try {
            connection.setAutoCommit(false);

            // Calculate total
            BigDecimal total = BigDecimal.ZERO;
            ItemDAO itemDAO = new ItemDAO();
            for (Cart cart : cartItems) {
                Item item = itemDAO.getItemById(cart.getItemId());
                if (item != null) {
                    BigDecimal itemTotal = item.getItemPrice().multiply(BigDecimal.valueOf(cart.getQuantity()));
                    total = total.add(itemTotal);
                }
            }

            // Create Order
            Order order = new Order();
            order.setUserId(userId);
            order.setOrderType(orderType);
            order.setOrderStatus("pending");
            order.setOrderTime(new Timestamp(new Date().getTime()));
            order.setTotalPrice(total.doubleValue());
            order.setTableId("dinein".equalsIgnoreCase(orderType) ? tableId : null);

            int orderId = insertOrder(order);

            if (orderId > 0) {
                OrderItemDAO orderItemDAO = new OrderItemDAO();

                for (Cart cart : cartItems) {
                    Item item = itemDAO.getItemById(cart.getItemId());
                    if (item != null) {
                        OrderItem orderItem = new OrderItem();
                        orderItem.setOrderId(orderId);
                        orderItem.setItemId(cart.getItemId());
                        orderItem.setQuantity(cart.getQuantity());
                        orderItem.setPrice(item.getItemPrice().doubleValue());
                        orderItem.setSubtotal(item.getItemPrice().multiply(BigDecimal.valueOf(cart.getQuantity())).doubleValue());

                        orderItemDAO.insertOrderItem(orderItem);
                    }
                }
                connection.commit();
                success = true;
            } else {
                connection.rollback();
            }

        } catch (Exception e) {
            e.printStackTrace();
            try {
                connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return success;
    }

    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_time DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setTableId(rs.getObject("table_id") != null ? rs.getInt("table_id") : null);
                order.setOrderType(rs.getString("order_type"));
                order.setOrderTime(rs.getTimestamp("order_time"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setTotalPrice(rs.getDouble("total_price"));

                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }

    public Order getOrderById(int orderId) {
        String sql = "SELECT * FROM orders WHERE order_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setTableId(rs.getObject("table_id") != null ? rs.getInt("table_id") : null);
                order.setOrderType(rs.getString("order_type"));
                order.setOrderTime(rs.getTimestamp("order_time"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setTotalPrice(rs.getDouble("total_price"));
                return order;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET order_status = ? WHERE order_id = ?";
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
        String sql = "SELECT * FROM orders";

        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setTableId(rs.getObject("table_id") != null ? rs.getInt("table_id") : null);
                order.setOrderType(rs.getString("order_type"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setTotalPrice(rs.getDouble("total_price"));
                order.setOrderTime(rs.getTimestamp("order_time"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }

    public List<Order> getOrdersByStatus(String status) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE order_status = ? ORDER BY order_time DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setOrderTime(rs.getTimestamp("order_time"));
                order.setOrderType(rs.getString("order_type"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setTotalPrice(rs.getDouble("total_price"));
                order.setTableId(rs.getObject("table_id") != null ? rs.getInt("table_id") : null);
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }

    // Stub methods to implement later
    public List<Order> getRecentOrders(int limit) {
        return new ArrayList<>();
    }

    public int getTotalOrderCount() {
        return 0;
    }

    public double getTotalSales() {
        return 0.0;
    }

    public int getUnpaidOrdersCount() {
        return 0;
    }
}
