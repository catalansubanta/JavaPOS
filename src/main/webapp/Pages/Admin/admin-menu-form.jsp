<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.javapos.model.Item" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    Item item = (Item) request.getAttribute("item");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Menu Item - Restaurant POS</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

<jsp:include page="/Pages/Common/header.jsp">
    <jsp:param name="currentPage" value="menu-items"/>
</jsp:include>

<div class="container">
    <div class="dashboard-header">
        <h1>Edit Menu Item</h1>
        <p class="text-muted">Modify the selected item details below.</p>
    </div>

    <form action="${pageContext.request.contextPath}/menu-items/form" method="post" class="form">
        <input type="hidden" name="itemId" value="<%= item.getItemId() %>">

        <div class="form-group">
            <label>Name:</label>
            <input type="text" name="itemName" value="<%= item.getItemName() %>" required>
        </div>

        <div class="form-group">
            <label>Category:</label>
            <select name="category" required>
                <option value="food" <%= "food".equals(item.getCategory()) ? "selected" : "" %>>Food</option>
                <option value="drink" <%= "drink".equals(item.getCategory()) ? "selected" : "" %>>Drink</option>
            </select>
        </div>

        <div class="form-group">
            <label>Price (Rs):</label>
            <input type="number" name="price" step="0.01" value="<%= item.getPrice() %>" required>
        </div>

        <button type="submit" class="btn"><i class="fas fa-save"></i> Update Item</button>
        <a href="${pageContext.request.contextPath}/Pages/Admin/admin-menu.jsp" class="btn-secondary">Cancel</a>
    </form>
</div>

<jsp:include page="/Pages/Common/footer.jsp"/>
</body>
</html>
