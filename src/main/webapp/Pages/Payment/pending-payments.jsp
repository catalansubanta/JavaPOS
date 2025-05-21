<%@ page import="java.util.List" %>
<%@ page import="com.javapos.model.Order" %>
<%@ page import="com.javapos.dao.OrderDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    OrderDAO orderDAO = new OrderDAO();
    List<Order> pendingOrders = orderDAO.getOrdersByStatus("unpaid"); // now returns List<Order>
    request.setAttribute("pendingOrders", pendingOrders);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Pending Payments</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css" />
</head>
<body>

<jsp:include page="/Pages/Common/header.jsp" />

<div class="container">
    <h2>Pending Payments</h2>

    <c:if test="${empty pendingOrders}">
        <p>No pending payments found.</p>
    </c:if>

    <c:if test="${not empty pendingOrders}">
        <table class="styled-table">
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Table</th>
                    <th>Order Type</th>
                    <th>Total Amount</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% for (Order order : pendingOrders) { %>
                    <tr>
                        <td><%= order.getOrderId() %></td>
                        <td><%= order.getTableId() %></td>
                        <td><%= order.getOrderType() %></td>
                        <td>$<%= String.format("%.2f", order.getTotalAmount()) %></td>
                        <td>
                            <form action="<%= request.getContextPath() %>/process-payment" method="get">
                                <input type="hidden" name="orderId" value="<%= order.getOrderId() %>" />
                                <button type="submit" class="btn">Process Payment</button>
                            </form>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </c:if>
</div>

<jsp:include page="/Pages/Common/footer.jsp" />

</body>
</html>
