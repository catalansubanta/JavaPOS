<%@ page import="java.util.List" %>
<%@ page import="com.javapos.model.User" %>
<%@ page import="com.javapos.dao.TableNoDAO" %>
<%@ page import="com.javapos.model.TableNo" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    User user = (User) session.getAttribute("loggedInUser");
    if (user == null || !"waiter".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        return;
    }

    TableNoDAO tableDAO = new TableNoDAO();
    List<TableNo> tables = tableDAO.getAllTables();
    
    for (TableNo table : tables) {
        if ("reserved".equalsIgnoreCase(table.getTableStatus())) {
            table.setReservationName("Lionel Messi");
        }
    }
    
    request.setAttribute("tables", tables);
    
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Waiter Tables - JavaPOS</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<jsp:include page="/Pages/Common/header.jsp" />


<div class="container">
    <div class="dashboard-header">
        <h1>Tables</h1>
        <p class="text-muted">Click a table to manage orders.</p>
    </div>

    <div class="tables-grid">
        <c:forEach var="table" items="${tables}">
    <div class="table-card ${table.tableStatus.toLowerCase()}">
        <c:choose>
            <c:when test="${table.tableStatus eq 'available'}">
                <form action="${pageContext.request.contextPath}/Pages/Waiter/table-orders.jsp" method="get">
                    <input type="hidden" name="tableId" value="${table.tableId}" />
                    <button type="submit" class="table-button">
                        <h3>Table ${table.tableNumber}</h3>
                        <p>Status: ${table.tableStatus}</p>
                    </button>
                </form>
            </c:when>

            <c:when test="${table.tableStatus eq 'reserved'}">
                <form action="${pageContext.request.contextPath}/Pages/Waiter/table-orders.jsp" method="get">
                            <input type="hidden" name="tableId" value="${table.tableId}" />
                            <input type="hidden" name="customerName" value="${table.reservationName}" />
                            <button type="submit" class="confirm-reservation-btn">
                                Confirm: ${table.reservationName}
                    </button>
                </form>
            </c:when>

            <c:otherwise>
                <div>
                    <h3>Table ${table.tableNumber}</h3>
                    <p>Status: ${table.tableStatus}</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</c:forEach>
    </div>
</div>

<jsp:include page="/Pages/Common/footer.jsp"/>


</body>
</html>
