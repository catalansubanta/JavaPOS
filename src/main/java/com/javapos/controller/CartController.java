package com.javapos.controller;

import com.javapos.dao.CartDAO;
import com.javapos.dao.ItemDAO;
import com.javapos.dao.OrderDAO;
import com.javapos.dao.OrderItemDAO;
import com.javapos.model.Cart;
import com.javapos.model.Item;
import com.javapos.model.Order;
import com.javapos.model.OrderItem;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

@WebServlet("/cart")
public class CartController extends HttpServlet {

    private CartDAO cartDAO;
    private ItemDAO itemDAO;
    private OrderDAO orderDAO;
    private OrderItemDAO orderItemDAO;

    @Override
    public void init() throws ServletException {
        cartDAO = new CartDAO();
        itemDAO = new ItemDAO();
        orderDAO = new OrderDAO();
        orderItemDAO = new OrderItemDAO();
    }
    
    
    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        com.javapos.model.User user = (com.javapos.model.User) session.getAttribute("loggedInUser");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
            return;
        }

        List<Cart> cartItems = cartDAO.getCartByUserId(user.getUserId());

        // Load item info for display
        for (Cart cart : cartItems) {
            Item item = itemDAO.getItemById(cart.getItemId());
            cart.setItem(item); // Ensure Cart.java has an `Item` field
        }

        request.setAttribute("cartItems", cartItems);
        request.getRequestDispatcher("/Pages/Waiter/waiter-cart.jsp").forward(request, response);
    }

    
    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("Pages/Waiter/waiter-menu-list.jsp");
            return;
        }

        switch (action) {
            case "add":
                addToCart(request, response);
                break;
            case "remove":
                removeFromCart(request, response);
                break;
            case "submit":
                submitCartAsOrder(request, response);
                break;
            default:
                response.sendRedirect("Pages/Waiter/waiter-menu-list.jsp");
        }
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
    	System.out.println("Add to Cart called");
    	
        int userId = Integer.parseInt(request.getParameter("userId"));
        int itemId = Integer.parseInt(request.getParameter("itemId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String tableId = request.getParameter("tableId");
        
        System.out.println("userId: " + userId + ", itemId: " + itemId + ", quantity: " + quantity);

        Cart cart = new Cart();
        cart.setUserId(userId);
        cart.setItemId(itemId);
        cart.setQuantity(quantity);

        boolean success = cartDAO.addOrUpdateCart(cart);

        
        HttpSession session = request.getSession();
        if (success) {
            session.setAttribute("cartMessage", "Item added to cart!");
        } else {
            session.setAttribute("cartMessage", "Failed to add item to cart.");
        }

        
        if (tableId != null && !tableId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/Pages/Waiter/table-orders.jsp?tableId=" + tableId);
        } else {
            response.sendRedirect(request.getContextPath() + "/Pages/Waiter/waiter-cart.jsp"); // fallback
        }
    }

    private void removeFromCart(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int cartId = Integer.parseInt(request.getParameter("cartId"));
        cartDAO.removeFromCart(cartId);

        String tableId = request.getParameter("tableId");
        if (tableId != null && !tableId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/Pages/Waiter/table-orders.jsp?tableId=" + tableId);
        } else {
            response.sendRedirect(request.getContextPath() + "/Pages/Waiter/waiter-cart.jsp");
        }
    }


    private void submitCartAsOrder(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String orderType = request.getParameter("orderType");

        int tableId = 0;
        if ("dinein".equalsIgnoreCase(orderType)) {
            String tableIdStr = request.getParameter("tableId");
            if (tableIdStr != null) {
                try {
                    tableId = Integer.parseInt(tableIdStr);
                } catch (NumberFormatException e) {
                    tableId = 0;
                }
            }
        }

        List<Cart> cartItems = cartDAO.getCartByUserId(userId);
        if (cartItems == null || cartItems.isEmpty()) {
            request.setAttribute("error", "Cart is empty.");
            request.getRequestDispatcher("/Pages/Waiter/waiter-cart.jsp").forward(request, response);
            return;
        }

        // Calculate total
        BigDecimal totalPrice = BigDecimal.ZERO;
        for (Cart cart : cartItems) {
            Item item = itemDAO.getItemById(cart.getItemId());
            if (item != null) {
                totalPrice = totalPrice.add(item.getItemPrice().multiply(BigDecimal.valueOf(cart.getQuantity())));
            }
        }

        // Insert order
        Order order = new Order();
        order.setUserId(userId);
        order.setOrderType(orderType);
        order.setOrderStatus("pending");
        order.setOrderTime(new Timestamp(new Date().getTime()));
        order.setTotalPrice(totalPrice.doubleValue());
        order.setTableId("dinein".equalsIgnoreCase(orderType) ? tableId : null);

        int orderId = orderDAO.insertOrder(order);

        // Insert order items
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

        // Clear cart
        cartDAO.clearCartByUser(userId);

        response.sendRedirect(request.getContextPath() + "/Pages/Waiter/waiter-my-orders.jsp");
    }



}
