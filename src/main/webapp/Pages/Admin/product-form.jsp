<%@ page import="com.javapos.model.Item" %>
<%@ page import="com.javapos.model.User" %>
<%@ page import="com.javapos.dao.ItemDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        return;
    }

    Item item = null;
    String itemId = request.getParameter("id");
    if (itemId != null && !itemId.isEmpty()) {
        ItemDAO itemDAO = new ItemDAO();
        item = itemDAO.getItemById(Integer.parseInt(itemId));
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= item == null ? "Add" : "Edit" %> Product - JavaPOS</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/dashboard.css">
    <style>
        .form-container {
            max-width: 600px;
            margin: 40px auto;
            padding: 20px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }

        .form-actions {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            margin-top: 20px;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background-color: #4996d1;
            color: white;
        }

        .btn-primary:hover {
            background-color: #3a7ab0;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>

<% request.setAttribute("currentPage", "Products"); %>
<jsp:include page="/Pages/Common/header.jsp" />

<div class="form-container">
    <h2><%= item == null ? "Add New Product" : "Edit Product" %></h2>
    
    <form action="<%= request.getContextPath() %>/product" method="post">
        <% if (item != null) { %>
            <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
        <% } %>
        
        <div class="form-group">
            <label for="itemName">Product Name</label>
            <input type="text" id="itemName" name="itemName" 
                   value="<%= item != null ? item.getItemName() : "" %>" required>
        </div>

        <div class="form-group">
            <label for="category">Category</label>
            <select id="category" name="category" required>
                <option value="">Select Category</option>
                <option value="Food" <%= item != null && "Food".equals(item.getCategory()) ? "selected" : "" %>>Food</option>
                <option value="Beverage" <%= item != null && "Beverage".equals(item.getCategory()) ? "selected" : "" %>>Beverage</option>
                <option value="Dessert" <%= item != null && "Dessert".equals(item.getCategory()) ? "selected" : "" %>>Dessert</option>
            </select>
        </div>

        <div class="form-group">
            <label for="price">Price (Rs.)</label>
            <input type="number" id="price" name="price" step="0.01" min="0"
                   value="<%= item != null ? item.getPrice() : "" %>" required>
        </div>

        <div class="form-group">
            <label for="stock">Stock</label>
            <input type="number" id="stock" name="stock" min="0"
                   value="<%= item != null ? item.getStock() : "" %>" required>
        </div>

        <div class="form-group">
            <label for="unit">Unit</label>
            <select id="unit" name="unit" required>
                <option value="">Select Unit</option>
                <option value="pcs" <%= item != null && "pcs".equals(item.getUnit()) ? "selected" : "" %>>Pieces</option>
                <option value="kg" <%= item != null && "kg".equals(item.getUnit()) ? "selected" : "" %>>Kilograms</option>
                <option value="l" <%= item != null && "l".equals(item.getUnit()) ? "selected" : "" %>>Liters</option>
            </select>
        </div>

        <div class="form-group">
            <label for="description">Description</label>
            <input type="text" id="description" name="description"
                   value="<%= item != null ? item.getDescription() : "" %>">
        </div>

        <div class="form-actions">
            <a href="<%= request.getContextPath() %>/Pages/Admin/products.jsp" class="btn btn-secondary">Cancel</a>
            <button type="submit" class="btn btn-primary">Save</button>
        </div>
    </form>
</div>

<jsp:include page="/Pages/Common/footer.jsp" />
</body>
</html> 