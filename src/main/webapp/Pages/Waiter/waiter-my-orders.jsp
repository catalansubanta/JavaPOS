<%@ page import="java.util.List" %>
<%@ page import="com.javapos.model.Order" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    com.javapos.model.User user = (com.javapos.model.User) session.getAttribute("loggedInUser");
    if (user == null || !"waiter".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        return;
    }
    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Orders - JavaPOS</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<jsp:include page="/Pages/Common/header.jsp"/>

<div class="container">
    <h1>My Orders</h1>

    <c:if test="${not empty orders}">
        <table>
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Order Date</th>
                    <th>Status</th>
                    <th>Total</th>
                    <th>Details</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="order" items="${orders}">
                    <tr>
                        <td>${order.orderId}</td>
                        <td>${order.orderDate}</td>
                        <td>${order.status}</td>
                        <td>$${order.totalAmount}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/waiter/orders?action=details&orderId=${order.orderId}">View</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <c:if test="${empty orders}">
        <p>You have no orders.</p>
    </c:if>
</div>

<jsp:include page="/Pages/Common/footer.jsp"/>
</body>
</html>









6