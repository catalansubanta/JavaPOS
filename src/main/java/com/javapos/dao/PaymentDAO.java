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

    // Add new payment
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

    // Get payment by ID
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

    // Get payments by Order ID
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

    // Update payment status
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

    // Get all payments - corrected table name and debug print
    public List<Payment> getAllPayments() {
        List<Payment> payments = new ArrayList<>();
        String query = "SELECT Payment_ID AS paymentId, Order_ID AS orderId, Paid_Amount AS paidAmount, Payment_Time AS paymentTime, Payment_Status AS paymentStatus FROM payment";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Payment payment = new Payment();
                payment.setPaymentId(rs.getInt("paymentId"));
                payment.setOrderId(rs.getInt("orderId"));
                payment.setPaidAmount(rs.getDouble("paidAmount"));
                payment.setPaymentTime(rs.getTimestamp("paymentTime"));
                payment.setPaymentStatus(rs.getString("paymentStatus"));

                System.out.println("Loaded Payment ID: " + payment.getPaymentId()); // Debug print

                payments.add(payment);
            }

            System.out.println("Total payments loaded: " + payments.size()); // Debug print

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return payments;
    }

    // Map ResultSet to Payment object
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
