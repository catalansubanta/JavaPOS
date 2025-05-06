<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    </div> <!-- Close container from header -->

    <footer class="main-footer">
        <div class="footer-content">
            <div class="footer-info">
                <p>&copy; 2024 Restaurant POS. All rights reserved.</p>
                <p>Version 1.0.0</p>
            </div>
            <div class="footer-links">
                <a href="${pageContext.request.contextPath}/about">About</a>
                <a href="${pageContext.request.contextPath}/privacy">Privacy Policy</a>
                <a href="${pageContext.request.contextPath}/terms">Terms of Service</a>
            </div>
        </div>
    </footer>

    <script src="<%= request.getContextPath() %>/js/main.js"></script>
</body>
</html>
