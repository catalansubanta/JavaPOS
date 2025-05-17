package com.javapos.dao;

import com.javapos.database.DatabaseConnection;
import com.javapos.model.TableNo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TableNoDAO {
    private Connection connection;

    public TableNoDAO() {
        try {
            this.connection = DatabaseConnection.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ✅ Add a new table
    public boolean addTable(TableNo table) {
        String sql = "INSERT INTO table_no (Table_Number, Table_Status) VALUES (?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, table.getTableNumber());
            stmt.setString(2, table.getTableStatus());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Get table by ID
    public TableNo getTableById(int tableId) {
        String sql = "SELECT * FROM table_no WHERE Table_ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, tableId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new TableNo(
                    rs.getInt("Table_ID"),
                    rs.getInt("Table_Number"),
                    rs.getString("Table_Status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ✅ Get all tables
    public List<TableNo> getAllTables() {
        List<TableNo> tableList = new ArrayList<>();
        String sql = "SELECT * FROM table_no ORDER BY Table_Number ASC";
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                TableNo table = new TableNo(
                    rs.getInt("Table_ID"),
                    rs.getInt("Table_Number"),
                    rs.getString("Table_Status")
                );
                tableList.add(table);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tableList;
    }

    // ✅ Update table status
    public boolean updateTableStatus(int tableId, String newStatus) {
        String sql = "UPDATE table_no SET Table_Status = ? WHERE Table_ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, newStatus);
            stmt.setInt(2, tableId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Delete table
    public boolean deleteTable(int tableId) {
        String sql = "DELETE FROM table_no WHERE Table_ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, tableId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
