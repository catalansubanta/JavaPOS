<%@ page import="com.javapos.model.Item" %>
<%@ page import="com.javapos.model.User" %>
<%@ page import="com.javapos.dao.ItemDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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

    request.setAttribute("currentPage", "menu-items");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${empty menuItem ? 'Add New Menu Item' : 'Edit Menu Item'} - Restaurant POS</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
    <jsp:include page="/Pages/Common/header.jsp">
        <jsp:param name="currentPage" value="menu-items"/>
    </jsp:include>
    
    <div class="container">
        <div class="dashboard-header">
            <h1>${empty menuItem ? 'Add New Menu Item' : 'Edit Menu Item'}</h1>
            <a href="${pageContext.request.contextPath}/menu-items" class="btn">
                <i class="fas fa-arrow-left"></i> Back to Menu Items
            </a>
        </div>

        <c:if test="${not empty message}">
            <div class="alert alert-${messageType}">
                ${message}
            </div>
        </c:if>

        <div class="form-container">
            <form action="${pageContext.request.contextPath}/menu-items/save" method="post">
                <input type="hidden" name="id" value="${menuItem.id}">
                
                <div class="form-group">
                    <label for="name">Menu Item Name</label>
                    <input type="text" id="name" name="name" class="form-control" 
                           value="${menuItem.name}" required>
                </div>

                <div class="form-group">
                    <label for="category">Category</label>
                    <select id="category" name="category" class="form-control" required>
                        <option value="">Select Category</option>
                        <c:forEach items="${categories}" var="category">
                            <option value="${category}" 
                                    ${menuItem.category eq category ? 'selected' : ''}>
                                ${category}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label for="price">Price</label>
                    <input type="number" id="price" name="price" class="form-control" 
                           value="${menuItem.price}" step="0.01" min="0" required>
                </div>

                <div class="form-group">
                    <label for="stock">Stock Quantity</label>
                    <input type="number" id="stock" name="stock" class="form-control" 
                           value="${menuItem.stock}" min="0" required>
                </div>

                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" class="form-control" 
                              rows="3">${menuItem.description}</textarea>
                </div>

                <div class="form-group">
                    <label for="status">Status</label>
                    <select id="status" name="status" class="form-control" required>
                        <option value="active" ${menuItem.status eq 'active' ? 'selected' : ''}>
                            Active
                        </option>
                        <option value="inactive" ${menuItem.status eq 'inactive' ? 'selected' : ''}>
                            Inactive
                        </option>
                    </select>
                </div>

                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/menu-items" class="btn btn-secondary">
                        Cancel
                    </a>
                    <button type="submit" class="btn btn-primary">
                        ${empty menuItem ? 'Add Menu Item' : 'Save Changes'}
                    </button>
                </div>
            </form>
        </div>
    </div>

    <jsp:include page="/Pages/Common/footer.jsp" />
</body>
</html> 