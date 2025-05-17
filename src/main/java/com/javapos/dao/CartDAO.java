package com.javapos.dao;

import com.javapos.database.DatabaseConnection;
import com.javapos.model.Cart;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {
    private Connection connection;

    public CartDAO() {
        try {
            this.connection = DatabaseConnection.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Get all cart items for a user
    public List<Cart> getCartByUserId(int userId) {
        List<Cart> cartList = new ArrayList<>();
        String query = "SELECT * FROM cart WHERE User_ID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Cart cart = new Cart();
                cart.setCartId(rs.getInt("Cart_ID"));
                cart.setUserId(rs.getInt("User_ID"));
                cart.setItemId(rs.getInt("Item_ID"));
                cart.setQuality(rs.getInt("Quality"));
                cart.setCreatedAt(rs.getTimestamp("Created_At"));

                cartList.add(cart);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cartList;
    }

    // Add an item to cart
    public boolean addToCart(Cart cart) {
        String query = "INSERT INTO cart (User_ID, Item_ID, Quality, Created_At) VALUES (?, ?, ?, NOW())";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, cart.getUserId());
            stmt.setInt(2, cart.getItemId());
            stmt.setInt(3, cart.getQuality());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Remove item from cart
    public boolean removeFromCart(int cartId) {
        String query = "DELETE FROM cart WHERE Cart_ID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, cartId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Clear entire cart for a user
    public boolean clearCartByUser(int userId) {
        String query = "DELETE FROM cart WHERE User_ID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}
