package com.javapos.controller.admin;

import com.javapos.dao.ItemDAO;
import com.javapos.model.Item;
import com.javapos.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/products")
public class AdminProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ItemDAO itemDAO;

    public void init() {
        itemDAO = new ItemDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            if ("admin".equals(user.getRole())) {
                List<Item> products = itemDAO.getAllItems();
                request.setAttribute("products", products);
                request.getRequestDispatcher("/Pages/Admin/products.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/error?message=Unauthorized access");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        }
    }
} 