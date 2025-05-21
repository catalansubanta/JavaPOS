<%@ page import="com.javapos.dao.OrderDAO" %>
<%@ page import="com.javapos.dao.UserDAO" %>
<%@ page import="com.javapos.model.User" %>
<%

	User user = (User) session.getAttribute("loggedInUser");
	if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
	response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
 	return;
}

    OrderDAO orderDAO = new OrderDAO();
    UserDAO userDAO = new UserDAO();

    int totalOrders = orderDAO.getTotalOrderCount();
    double totalSales = orderDAO.getTotalSales();
    int unpaidOrders = orderDAO.getUnpaidOrdersCount();
    int totalUsers = userDAO.getTotalUsers();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Report</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<jsp:include page="/Pages/Common/header.jsp"/>

<div class="container">
    <h1>Admin - Reports</h1>

    <div class="report-box">
        <p><strong>Total Orders:</strong> <%= totalOrders %></p>
        <p><strong>Total Sales:</strong> Rs <%= totalSales %></p>
        <p><strong>Unpaid Orders:</strong> <%= unpaidOrders %></p>
        <p><strong>Total Users:</strong> <%= totalUsers %></p>
    </div>
</div>

<jsp:include page="/Pages/Common/footer.jsp"/>
</body>
</html>
