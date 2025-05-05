package com.javapos.controller.profile;

import com.javapos.dao.UserDAO;
import com.javapos.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/profile")
public class ProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        request.setAttribute("user", user);
        request.getRequestDispatcher("/Pages/profile/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("user");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        currentUser.setUsername(username);
        currentUser.setEmail(email);
        if (password != null && !password.isEmpty()) {
            currentUser.setPassword(password);
        }

        if (userDAO.updateUser(currentUser)) {
            session.setAttribute("user", currentUser);
            response.sendRedirect(request.getContextPath() + "/profile");
        } else {
            request.setAttribute("error", "Failed to update profile");
            request.getRequestDispatcher("/Pages/profile/profile.jsp").forward(request, response);
        }
    }
} 