package com.javapos.controller;

import com.javapos.dao.OrderDAO;
import com.javapos.dao.PaymentDAO;
import com.javapos.model.Order;
import com.javapos.model.Payment;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

@WebServlet("/process-payment")
public class PaymentController extends HttpServlet {

    private OrderDAO orderDAO;
    private PaymentDAO paymentDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
        paymentDAO = new PaymentDAO();
    }

    // Handles GET requests - Show all payments
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Payment> payments = paymentDAO.getAllPayments();
            request.setAttribute("payments", payments);

            // Forward to the JSP page that displays payments
            request.getRequestDispatcher("/Pages/Cashier/cashier-payment.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            // You may want to redirect to an error page or show a friendly message here
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to load payments.");
        }
    }

    // Handles POST requests - Process a new payment
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String orderIdParam = request.getParameter("orderId");
        if (orderIdParam == null || orderIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/Pages/Cashier/cashier-order.jsp?error=missingOrderId");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdParam);
            Order order = orderDAO.getOrderById(orderId);

            if (order == null) {
                response.sendRedirect(request.getContextPath() + "/Pages/Cashier/cashier-order.jsp?error=orderNotFound");
                return;
            }

            if (!"unpaid".equalsIgnoreCase(order.getStatus())) {
                response.sendRedirect(request.getContextPath() + "/Pages/Cashier/cashier-order.jsp?error=alreadyPaid");
                return;
            }

            // Create payment object
            Payment payment = new Payment();
            payment.setOrderId(orderId);
            payment.setPaidAmount(order.getTotalAmount());
            payment.setPaymentTime(new Timestamp(System.currentTimeMillis()));
            payment.setPaymentStatus("paid"); // make sure status matches your DB ENUM values (lowercase "paid")

            boolean paymentInserted = paymentDAO.addPayment(payment);

            if (paymentInserted) {
                orderDAO.updateOrderStatus(orderId, "paid");
                response.sendRedirect(request.getContextPath() + "/process-payment?success=true");
            } else {
                response.sendRedirect(request.getContextPath() + "/Pages/Cashier/cashier-order.jsp?error=paymentFailed");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/Pages/Cashier/cashier-order.jsp?error=invalidId");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/Pages/Cashier/cashier-order.jsp?error=serverError");
        }
    }
}
