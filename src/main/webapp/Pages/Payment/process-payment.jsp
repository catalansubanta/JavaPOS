<%@ page import="com.javapos.model.Order" %>
<%@ page import="com.javapos.model.Payment" %>
<%@ page import="java.util.List" %>
<%@ page import="com.javapos.dao.OrderDAO" %>
<%@ page import="com.javapos.dao.PaymentDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Get orderId from request param
    String orderIdParam = request.getParameter("orderId");
    int orderId = 0;
    Order order = null;
    List<Payment> payments = null;

    if (orderIdParam != null) {
        try {
            orderId = Integer.parseInt(orderIdParam);

            OrderDAO orderDAO = new OrderDAO();
            order = orderDAO.getOrderById(orderId);

            PaymentDAO paymentDAO = new PaymentDAO();
            payments = paymentDAO.getPaymentsByOrderId(orderId);

            if (order == null) {
                out.println("<p>Order not found!</p>");
                return;
            }
        } catch (NumberFormatException e) {
            out.println("<p>Invalid order ID!</p>");
            return;
        }
    } else {
        out.println("<p>No order selected.</p>");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Process Payment for Order #<%= orderId %></title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css" />
</head>
<body>

<jsp:include page="/Pages/Common/header.jsp" />

<div class="container">
    <h2>Process Payment for Order #<%= orderId %></h2>

    <h3>Order Details</h3>
    <p><strong>Order ID:</strong> <%= order.getOrderId() %></p>
    <p><strong>Table:</strong> <%= order.getTableId() %></p>
    <p><strong>Order Type:</strong> <%= order.getOrderType() %></p>
    <p><strong>Status:</strong> <%= order.getStatus() %></p>
    <p><strong>Total Amount:</strong> $<%= String.format("%.2f", order.getTotalAmount()) %></p>

    <h3>Previous Payments</h3>
    <%
        if (payments != null && !payments.isEmpty()) {
    %>
        <table>
            <thead>
                <tr>
                    <th>Payment ID</th>
                    <th>Amount Paid</th>
                    <th>Payment Time</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <% for (Payment p : payments) { %>
                    <tr>
                        <td><%= p.getPaymentId() %></td>
                        <td>$<%= String.format("%.2f", p.getPaidAmount()) %></td>
                        <td><%= p.getPaymentTime() %></td>
                        <td><%= p.getPaymentStatus() %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <%
        } else {
    %>
        <p>No previous payments recorded.</p>
    <%
        }
    %>

    <h3>Make Payment</h3>
    <form action="<%= request.getContextPath() %>/process-payment" method="post">
        <input type="hidden" name="orderId" value="<%= order.getOrderId() %>" />
        
        <label for="amount">Amount to Pay:</label>
        <input type="text" id="amount" name="paidAmount" value="<%= String.format("%.2f", order.getTotalAmount()) %>" readonly />

        <br /><br />
        <button type="submit" class="btn">Confirm Payment</button>
    </form>

    <br />
    <a href="<%= request.getContextPath() %>/Pages/Cashier/cashier-order.jsp">Back to Orders</a>
</div>

<jsp:include page="/Pages/Common/footer.jsp" />

</body>
</html>
