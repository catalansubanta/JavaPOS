package com.javapos.controller;

import com.javapos.dao.CartDAO;
import com.javapos.dao.ItemDAO;
import com.javapos.dao.OrderDAO;
import com.javapos.dao.OrderItemDAO;
import com.javapos.model.Cart;
import com.javapos.model.Item;
import com.javapos.model.Order;
import com.javapos.model.OrderItem;
import com.javapos.model.User;

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
        User user = (User) session.getAttribute("loggedInUser");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
            return;
        }

        List<Cart> cartItems = cartDAO.getCartByUserId(user.getUserId());
        for (Cart cart : cartItems) {
            Item item = itemDAO.getItemById(cart.getItemId());
            cart.setItem(item); // assuming Cart model has Item reference
        }

        request.setAttribute("cartItems", cartItems);
        request.getRequestDispatcher("/Pages/Waiter/waiter-cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
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
                submitCartAsOrder(request, response, session);
                break;
            default:
                response.sendRedirect("Pages/Waiter/waiter-menu-list.jsp");
        }
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        int itemId = Integer.parseInt(request.getParameter("itemId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String tableId = request.getParameter("tableId");

        Cart cart = new Cart();
        cart.setUserId(userId);
        cart.setItemId(itemId);
        cart.setQuantity(quantity);

        boolean success = cartDAO.addOrUpdateCart(cart);
        HttpSession session = request.getSession();
        session.setAttribute("cartMessage", success ? "Item added to cart!" : "Failed to add item to cart.");

        if (tableId != null && !tableId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/Pages/Waiter/table-orders.jsp?tableId=" + tableId);
        } else {
            response.sendRedirect(request.getContextPath() + "/Pages/Waiter/waiter-cart.jsp");
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

    private void submitCartAsOrder(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String orderType = request.getParameter("orderType");
        int tableId = 0;

        if ("dinein".equalsIgnoreCase(orderType)) {
            try {
                tableId = Integer.parseInt(request.getParameter("tableId"));
            } catch (NumberFormatException ignored) {
            }
        }

        List<Cart> cartItems = cartDAO.getCartByUserId(userId);
        if (cartItems == null || cartItems.isEmpty()) {
            session.setAttribute("cartMessage", "Cart is empty.");
            response.sendRedirect("Pages/Waiter/table-orders.jsp?tableId=" + tableId);
            return;
        }

        BigDecimal totalPrice = BigDecimal.ZERO;
        for (Cart cart : cartItems) {
            Item item = itemDAO.getItemById(cart.getItemId());
            if (item != null) {
                totalPrice = totalPrice.add(item.getItemPrice().multiply(BigDecimal.valueOf(cart.getQuantity())));
            }
        }

        Order order = new Order();
        order.setUserId(userId);
        order.setOrderType(orderType);
        order.setOrderStatus("pending");
        order.setOrderTime(new Timestamp(new Date().getTime()));
        order.setTotalPrice(totalPrice.doubleValue());
        order.setTableId("dinein".equalsIgnoreCase(orderType) ? tableId : null);

        int orderId = orderDAO.insertOrder(order);

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

        cartDAO.clearCartByUser(userId);
        session.setAttribute("cartMessage", "Order confirmed successfully.");
        response.sendRedirect("Pages/Waiter/table-orders.jsp?tableId=" + tableId);
    }
}
