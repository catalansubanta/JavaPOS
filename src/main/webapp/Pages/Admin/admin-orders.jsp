<%@ page import="java.util.List" %>
<%@ page import="com.javapos.model.Order" %>
<%@ page import="com.javapos.dao.OrderDAO" %>
<%@ page import="com.javapos.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%

		User user = (User) session.getAttribute("loggedInUser");
		if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
		response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
		 	return;
		}

    OrderDAO orderDAO = new OrderDAO();
    List<Order> orders = orderDAO.getAllOrders();
    request.setAttribute("orderList", orders);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin - All Orders</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<jsp:include page="/Pages/Common/header.jsp"/>

<div class="container">
    <h1>All Orders</h1>
    <table class="table">
        <thead>
            <tr>
                <th>Order ID</th>
                <th>Table</th>
                <th>User</th>
                <th>Type</th>
                <th>Status</th>
                <th>Total</th>
                <th>Time</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="order" items="${orderList}">
                <tr>
                    <td>${order.orderId}</td>
                    <td>${order.tableId}</td>
                    <td>${order.userId}</td>
                    <td>${order.orderType}</td>
                    <td>${order.status}</td>
                    <td>$${order.totalAmount}</td>
                    <td>${order.orderDate}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<jsp:include page="/Pages/Common/footer.jsp"/>
</body>
</html>
