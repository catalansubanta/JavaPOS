package com.javapos.dao;

import com.javapos.database.DatabaseConnection;
import com.javapos.model.Payment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {
    private Connection connection;

    public PaymentDAO() {
        try {
            this.connection = DatabaseConnection.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ✅ Add new payment
    public boolean addPayment(Payment payment) {
        String sql = "INSERT INTO payment (Order_ID, Paid_Amount, Payment_Time, Payment_Status) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, payment.getOrderId());
            stmt.setDouble(2, payment.getPaidAmount());
            stmt.setTimestamp(3, payment.getPaymentTime());
            stmt.setString(4, payment.getPaymentStatus());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Get payment by ID
    public Payment getPaymentById(int paymentId) {
        String sql = "SELECT * FROM payment WHERE Payment_ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, paymentId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapPayment(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ✅ Get payments by Order ID
    public List<Payment> getPaymentsByOrderId(int orderId) {
        List<Payment> paymentList = new ArrayList<>();
        String sql = "SELECT * FROM payment WHERE Order_ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                paymentList.add(mapPayment(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return paymentList;
    }

    // ✅ Update payment status
    public boolean updatePaymentStatus(int paymentId, String status) {
        String sql = "UPDATE payment SET Payment_Status = ? WHERE Payment_ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, paymentId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Get all payments
    public List<Payment> getAllPayments() {
        List<Payment> payments = new ArrayList<>();
        String sql = "SELECT * FROM payment ORDER BY Payment_Time DESC";
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                payments.add(mapPayment(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payments;
    }

    // ✅ Map ResultSet to Payment object
    private Payment mapPayment(ResultSet rs) throws SQLException {
        return new Payment(
            rs.getInt("Payment_ID"),
            rs.getInt("Order_ID"),
            rs.getDouble("Paid_Amount"),
            rs.getTimestamp("Payment_Time"),
            rs.getString("Payment_Status")
        );
    }
}
