package com.javapos.controller.admin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

import com.javapos.database.DatabaseConnection;

@WebServlet("/admin/order-count")
public class OrderCountController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");

        List<String> labels = new ArrayList<>();
        List<Integer> values = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT DATE_FORMAT(order_time, '%b %Y') AS month, COUNT(*) AS order_count FROM orders GROUP BY YEAR(order_time), MONTH(order_time) ORDER BY order_time";
            try (PreparedStatement stmt = conn.prepareStatement(sql);
                 ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    labels.add(rs.getString("month"));
                    values.add(rs.getInt("order_count"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Build JSON manually
        StringBuilder json = new StringBuilder();
        json.append("{\"labels\":[");
        for (int i = 0; i < labels.size(); i++) {
            json.append("\"").append(escapeJson(labels.get(i))).append("\"");
            if (i < labels.size() - 1) {
                json.append(",");
            }
        }
        json.append("],\"values\":[");
        for (int i = 0; i < values.size(); i++) {
            json.append(values.get(i));
            if (i < values.size() - 1) {
                json.append(",");
            }
        }
        json.append("]}");

        response.getWriter().write(json.toString());
    }

    // Basic JSON escape for strings
    private String escapeJson(String str) {
        return str.replace("\"", "\\\"").replace("\\", "\\\\");
    }
}
