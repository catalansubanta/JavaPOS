<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    </div> <!-- Close container from header -->

    <footer class="text-center text-muted mt-5 py-3 border-top">
        &copy; <%= java.time.Year.now() %> JavaPOS. All rights reserved.
    </footer>

    <script src="<%= request.getContextPath() %>/js/main.js"></script>
</body>
</html>
