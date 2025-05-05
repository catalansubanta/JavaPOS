<%@ page import="java.util.List" %>
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

    ItemDAO itemDAO = new ItemDAO();
    List<Item> items = itemDAO.getAllItems();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Management - JavaPOS</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/dashboard.css">
    <style>
        .products-container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 20px;
        }

        .search-bar {
            margin-bottom: 20px;
            display: flex;
            gap: 10px;
        }

        .search-bar input {
            flex: 1;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
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

        .btn-danger {
            background-color: #dc3545;
            color: white;
        }

        .btn-danger:hover {
            background-color: #c82333;
        }

        .btn-warning {
            background-color: #ffc107;
            color: #212529;
        }

        .btn-warning:hover {
            background-color: #e0a800;
        }

        .products-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: white;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .products-table th,
        .products-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .products-table th {
            background-color: #f8f9fa;
            font-weight: 600;
        }

        .products-table tr:hover {
            background-color: #f5f5f5;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }
    </style>
</head>
<body>

<% request.setAttribute("currentPage", "Products"); %>
<jsp:include page="/Pages/Common/header.jsp" />

<div class="products-container">
    <div class="search-bar">
        <input type="text" id="searchInput" placeholder="Search products..." onkeyup="searchProducts()">
        <a href="<%= request.getContextPath() %>/Pages/Admin/product-form.jsp" class="btn btn-primary">Add Product</a>
    </div>

    <table class="products-table">
        <thead>
            <tr>
                <th>Product Name</th>
                <th>Category</th>
                <th>Price</th>
                <th>Stock</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% for (Item item : items) { %>
                <tr>
                    <td><%= item.getItemName() %></td>
                    <td><%= item.getCategory() %></td>
                    <td>Rs. <%= item.getPrice() %></td>
                    <td><%= item.getStock() %> <%= item.getUnit() %></td>
                    <td class="action-buttons">
                        <a href="<%= request.getContextPath() %>/Pages/Admin/product-form.jsp?id=<%= item.getItemId() %>" 
                           class="btn btn-warning">Edit</a>
                        <button onclick="deleteProduct(<%= item.getItemId() %>)" 
                                class="btn btn-danger">Delete</button>
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>
</div>

<script>
function searchProducts() {
    const input = document.getElementById('searchInput');
    const filter = input.value.toUpperCase();
    const table = document.querySelector('.products-table');
    const tr = table.getElementsByTagName('tr');

    for (let i = 1; i < tr.length; i++) {
        const td = tr[i].getElementsByTagName('td');
        let found = false;
        
        for (let j = 0; j < td.length - 1; j++) {
            const cell = td[j];
            if (cell) {
                const txtValue = cell.textContent || cell.innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    found = true;
                    break;
                }
            }
        }
        
        tr[i].style.display = found ? '' : 'none';
    }
}

function deleteProduct(itemId) {
    if (confirm('Are you sure you want to delete this product?')) {
        // TODO: Implement delete functionality
        alert('Delete functionality to be implemented');
    }
}
</script>

<jsp:include page="/Pages/Common/footer.jsp" />
</body>
</html> 