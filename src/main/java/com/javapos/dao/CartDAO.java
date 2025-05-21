package com.javapos.dao;

import com.javapos.database.DatabaseConnection;
import com.javapos.model.Cart;
import com.javapos.model.Item;

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
        String sql = "SELECT * FROM cart WHERE user_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            ItemDAO itemDAO = new ItemDAO(); // Fetch item details

            while (rs.next()) {
                Cart cart = new Cart();
                cart.setCartId(rs.getInt("cart_id"));
                cart.setUserId(rs.getInt("user_id"));
                cart.setItemId(rs.getInt("item_id"));
                cart.setQuantity(rs.getInt("quantity"));
                cart.setCreatedAt(rs.getTimestamp("created_at"));

                // Fetch item and attach
                Item item = itemDAO.getItemById(cart.getItemId());
                cart.setItem(item);

                cartList.add(cart);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cartList;
    }


    // Add an item to cart
    public boolean addToCart(Cart cart) {
        String query = "INSERT INTO cart (User_ID, Item_ID, Quantity, Created_At) VALUES (?, ?, ?, NOW())";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, cart.getUserId());
            stmt.setInt(2, cart.getItemId());
            stmt.setInt(3, cart.getQuantity());

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
    
    
    public boolean addOrUpdateCart(Cart cart) {
        String checkQuery = "SELECT * FROM cart WHERE User_ID = ? AND Item_ID = ?";
        String updateQuery = "UPDATE cart SET Quantity = Quantity + ? WHERE User_ID = ? AND Item_ID = ?";
        String insertQuery = "INSERT INTO cart (User_ID, Item_ID, Quantity, Created_At) VALUES (?, ?, ?, NOW())";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {

            checkStmt.setInt(1, cart.getUserId());
            checkStmt.setInt(2, cart.getItemId());
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                    updateStmt.setInt(1, cart.getQuantity());
                    updateStmt.setInt(2, cart.getUserId());
                    updateStmt.setInt(3, cart.getItemId());
                    return updateStmt.executeUpdate() > 0;
                }
            } else {
                try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
                    insertStmt.setInt(1, cart.getUserId());
                    insertStmt.setInt(2, cart.getItemId());
                    insertStmt.setInt(3, cart.getQuantity());
                    return insertStmt.executeUpdate() > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }


    
 // Update quantity of existing cart item
    public boolean updateCartQuantity(Cart cart) {
        String sql = "UPDATE cart SET Quality = ? WHERE Cart_ID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, cart.getQuantity());
            stmt.setInt(2, cart.getCartId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

   

    
    
}
