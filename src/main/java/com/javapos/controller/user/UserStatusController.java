package com.javapos.controller.user;

import com.javapos.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/user/deactivate")
public class UserStatusController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userIdStr = request.getParameter("userId");

        if (userIdStr != null && !userIdStr.isEmpty()) {
            int userId = Integer.parseInt(userIdStr);

            boolean success = userDAO.updateUserStatus(userId, "inactive");

            if (success) {
                response.sendRedirect(request.getContextPath() + "/Pages/Admin/admin-users.jsp");
            } else {
                request.setAttribute("error", "Failed to deactivate user.");
                request.getRequestDispatcher("/Pages/Admin/admin-users.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/Pages/Admin/admin-users.jsp");
        }
    }
}
