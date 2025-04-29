<%@ page import="java.util.List" %>
<%@ page import="com.javapos.model.Item" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.javapos.dao.ItemDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("userWithSession") == null) {
        response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        return;
    }

    List<Item> itemList = new com.javapos.dao.ItemDAO().getAllItems();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Menu List</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/dashboard.css">
    <style>
        .menu-container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 10px;
        }

        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        .menu-card {
            background-color: #F0F8FF;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s ease;
        }

        .menu-card:hover {
            transform: translateY(-5px);
            background-color: #e6f3ff;
        }

        .menu-card h3 {
            margin-bottom: 10px;
            color: #333;
        }

        .menu-card p {
            margin: 4px 0;
            color: #556B7C;
        }
    </style>
</head>
<body>

<jsp:include page="/Pages/Common/header.jsp" />

<div class="menu-container">
    <h2 class="text-center mb-4">Available Menu Items</h2>
    <div class="menu-grid">
        <% for (Item item : itemList) { %>
            <div class="menu-card">
                <h3><%= item.getItemName() %></h3>
                <p><%= item.getDescription() %></p>
                <p><strong>Category:</strong> <%= item.getCategory() %></p>
                <p><strong>Price:</strong> Rs. <%= item.getPrice() %></p>
                <p><strong>Stock:</strong> <%= item.getStock() %> <%= item.getUnit() %></p>
            </div>
        <% } %>
    </div>
</div>

<jsp:include page="/Pages/Common/footer.jsp" />
</body>
</html>
