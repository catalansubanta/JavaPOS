<%@ page import="com.javapos.model.User" %>
<%
    User user = (User) session.getAttribute("userWithSession");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        return;
    }

    // Determine dashboard URL based on user role
    String dashboardUrl = request.getContextPath() + "/Pages/Dashboard/dashboard.jsp";
    switch (user.getRole()) {
        case "admin":
            dashboardUrl = request.getContextPath() + "/Pages/Dashboard/admin-dashboard.jsp";
            break;
        case "cashier":
            dashboardUrl = request.getContextPath() + "/Pages/Dashboard/cashier-dashboard.jsp";
            break;
        case "waiter":
            dashboardUrl = request.getContextPath() + "/Pages/Dashboard/waiter-dashboard.jsp";
            break;
    }

    // Safe fallback for currentPage
    String currentPage = (String) request.getAttribute("currentPage");
    if (currentPage == null) currentPage = "";
%>

<!-- Header Bar -->
<div class="header-bar">
    <header>
        <h1>Point of Sale</h1>
        <h2>GrandLine</h2>
    </header>
</div>

<!-- Navigation Bar -->
<div class="nav-bar">
    <nav>
        <ul>
            <li><a href="<%= request.getContextPath() %>/Pages/HomePage.jsp"
                   class="<%= "HomePage".equals(currentPage) ? "active" : "" %>">Home</a></li>

            <li><a href="<%= dashboardUrl %>"
                   class="<%= "Dashboard".equals(currentPage) ? "active" : "" %>">Dashboard</a></li>

            <li><a href="<%= request.getContextPath() %>/Pages/Profile/user-profile.jsp"
                   class="<%= "Profile".equals(currentPage) ? "active" : "" %>">View Profile</a></li>

            <li><a href="<%= request.getContextPath() %>/logout">Logout</a></li>
        </ul>
    </nav>
</div>
