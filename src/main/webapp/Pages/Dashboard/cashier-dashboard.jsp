<%@ page import="com.javapos.model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Cashier Dashboard - JavaPOS</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/dashboard.css">
</head>
<body class="dashboard-body">

<%
    User user = (User) session.getAttribute("loggedInUser");
    if (user == null || !"cashier".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        return;
    }
%>

<% request.setAttribute("currentPage", "cashier-dashboard"); %>
<jsp:include page="/Pages/Common/header.jsp" />

<main class="dashboard-container">

    <h2 class="dashboard-title">Welcome, <%= user.getFullName() %>!</h2>

    <!-- Quick Search -->
    <div class="quick-search">
        <input type="text" placeholder="Search Orders or Payments..." />
        <button type="button">Search</button>
    </div>

    <div class="dashboard-sections">

        <!-- Recent Orders -->
        <section class="dashboard-box">
            <h3>Recent Orders</h3>
            <div class="box-content">
                <p>No. of recent unpaid orders: 5</p>
                <button onclick="location.href='<%= request.getContextPath() %>/Pages/Cashier/cashier-orders.jsp'">View Orders</button>
                <button onclick="location.href='<%= request.getContextPath() %>/Pages/Payment/process-payment.jsp'">Process to Payment</button>
            </div>
        </section>

        <!-- Recent Payments -->
        <section class="dashboard-box">
            <h3>Recent Payments</h3>
            <div class="box-content">
                <p>Latest transactions completed today.</p>
                <button onclick="location.href='<%= request.getContextPath() %>/Pages/Cashier/cashier-payment.jsp'">View All Payments</button>
            </div>
        </section>

    </div>

</main>

<jsp:include page="/Pages/Common/footer.jsp" />

</body>
</html>
