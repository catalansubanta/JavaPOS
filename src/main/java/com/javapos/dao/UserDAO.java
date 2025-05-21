package com.javapos.dao;

import com.javapos.database.DatabaseConnection;
import com.javapos.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private Connection connection;

    public UserDAO() {
        try {
            this.connection = DatabaseConnection.getConnection();
        } catch (SQLException e) {
            System.err.println("Failed to establish DB connection in UserDAO: " + e.getMessage());
            throw new RuntimeException("Cannot initialize UserDAO", e);
        }
    }

    public User validateUser(String username, String password) {
        String query = "SELECT * FROM Users WHERE Username = ? AND Password = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, username);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapUser(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (username, password, full_name, email, phone, role, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getFullName());
            stmt.setString(4, user.getEmail());
            stmt.setString(5, user.getPhone());
            stmt.setString(6, user.getRole());
            stmt.setString(7, user.getStatus());

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    public boolean updateUserProfile(User user) {
        String query = "UPDATE Users SET Full_Name = ?, Email = ?, Phone = ? WHERE User_ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhone());
            stmt.setInt(4, user.getUserId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateUserPassword(User user) {
        String query = "UPDATE Users SET Password = ? WHERE User_ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, user.getPassword());
            stmt.setInt(2, user.getUserId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isEmailExists(String email) {
        return existsByField("Email", email);
    }

    public boolean isUsernameExists(String username) {
        return existsByField("Username", username);
    }

    public boolean isPhoneExists(String phone) {
        return existsByField("Phone", phone);
    }

    private boolean existsByField(String field, String value) {
        String query = "SELECT COUNT(*) FROM Users WHERE " + field + " = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, value);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getTotalUsers() {
    	int count = 0;
        String query = "SELECT COUNT(*) FROM Users";
        try (Connection conn = DatabaseConnection.getConnection();
        		Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public int countByRole(String role) {
        String query = "SELECT COUNT(*) AS count FROM Users WHERE Role = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, role);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<User> getUsersByRole(String role) {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM Users WHERE Role = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, role);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                users.add(mapUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public List<User> getRecentUsers(int limit) {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM users ORDER BY user_id DESC LIMIT ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return users;
    }

    
    public List<User> filterUsers(String role, String status) {
        List<User> userList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM users WHERE 1=1");

        if (role != null && !role.isEmpty()) {
            sql.append(" AND role = ?");
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND status = ?");
        }

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            int index = 1;
            if (role != null && !role.isEmpty()) {
                stmt.setString(index++, role);
            }
            if (status != null && !status.isEmpty()) {
                stmt.setString(index++, status);
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));
                userList.add(user);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return userList;
    }
    
    
    public boolean updateUserStatus(int userId, String status) {
        String sql = "UPDATE users SET status = ? WHERE user_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, userId);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    
    



    public List<User> getAllUsers() {
        List<User> userList = new ArrayList<>();
        String sql = "SELECT * FROM users";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));
                userList.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return userList;
    }


    private User mapUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("User_ID"));
        user.setUsername(rs.getString("Username"));
        user.setPassword(rs.getString("Password"));
        user.setFullName(rs.getString("Full_Name"));
        user.setEmail(rs.getString("Email"));
        user.setPhone(rs.getString("Phone"));
        user.setRole(rs.getString("Role"));
        return user;
    }
    
    public User getUserById(int userId) {
        User user = null;
        String sql = "SELECT * FROM users WHERE user_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setFullName(rs.getString("full_name"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));
                    user.setRole(rs.getString("role"));
                    user.setStatus(rs.getString("status")); // if you have this column
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

}
