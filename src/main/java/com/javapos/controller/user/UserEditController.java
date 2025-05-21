package com.javapos.controller.user;

import com.javapos.dao.UserDAO;
import com.javapos.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/user/edit")
public class UserEditController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String userIdStr = request.getParameter("id");

        if (userIdStr != null && !userIdStr.isEmpty()) {
            int userId = Integer.parseInt(userIdStr);
            User user = userDAO.getUserById(userId);

            if (user != null) {
                request.setAttribute("user", user);
                request.getRequestDispatcher("/Pages/Admin/admin-edit-user.jsp").forward(request, response);
                return;
            }
        }

        response.sendRedirect(request.getContextPath() + "/Pages/Admin/admin-users.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        // handle form submission if needed
    }
}
