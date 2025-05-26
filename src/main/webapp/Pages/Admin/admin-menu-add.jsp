<%@ page import="com.javapos.model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%

		User user = (User) session.getAttribute("loggedInUser");
		if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
			response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
			return;
}
%>
<% String success = request.getParameter("success");
   String error = request.getParameter("error");
%>

<c:if test="${not empty success}">
    <div style="color: green; font-weight: bold;">${param.success}</div>
</c:if>

<c:if test="${not empty error}">
    <div style="color: red; font-weight: bold;">${param.error}</div>
</c:if>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Menu Item - Restaurant POS</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<jsp:include page="/Pages/Common/header.jsp">
    <jsp:param name="currentPage" value="menu-items"/>
</jsp:include>

<div class="container">
    <h1>Add New Item</h1>
    <br>
    <form action="${pageContext.request.contextPath}/menu-items/add" method="post">
        <div class="form-group">
            <label for="itemName">Item Name:</label>
            <input type="text" name="itemName" id="itemName" required>
        </div>
        <br>

        <div class="form-group">
            <label for="description">Description:</label>
            <textarea name="description" id="description" rows="3" required></textarea>
        </div>
        <br>

        <div class="form-group">
            <label for="price">Price (Rs):</label>
            <input type="number" name="price" id="price" step="0.01" min="1" required>
        </div>
        <br>

        <div class="form-group">
            <label for="category">Category:</label>
            <select name="category" id="category" required>
                <option value="food">Food</option>
                <option value="drink">Drink</option>
            </select>
        </div>
        <br>

        <div class="form-group">
            <label for="stock">Stock:</label>
            <input type="number" name="stock" id="stock" step="0.1" min="1" required>
        </div>
        <br>

        <div class="form-group">
            <label for="unit">Unit:</label>
            <input type="text" name="unit" id="unit" required placeholder="e.g., pcs, ml, g">
        </div>
        <br>

        <div class="form-group">
            <label for="imagePath">Image URL:</label>
            <input type="url" name="imagePath" id="imagePath" placeholder="https://example.com/image.jpg">
        </div>
        <br>

        <div class="form-actions">
            <button type="submit" class="btn">Add Item</button>
            <a href="${pageContext.request.contextPath}/Pages/Admin/admin-menu.jsp"  class="btn">Cancel</a>
        </div>
        <br>

    </form>
</div>

<jsp:include page="/Pages/Common/footer.jsp"/>

</body>
</html>
