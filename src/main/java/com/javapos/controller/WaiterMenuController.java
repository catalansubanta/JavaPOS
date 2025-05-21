package com.javapos.controller;

import com.javapos.dao.ItemDAO;
import com.javapos.model.Item;
import com.javapos.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/waiter/menu")
public class WaiterMenuController extends HttpServlet {

    private ItemDAO itemDAO;

    @Override
    public void init() throws ServletException {
        itemDAO = new ItemDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession(false).getAttribute("loggedInUser");
        if (user == null || !"waiter".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
            return;
        }

        String search = request.getParameter("search");
        String category = request.getParameter("category");

        List<Item> items = itemDAO.searchItems(search, category);
        request.setAttribute("menuItems", items);

        request.getRequestDispatcher("/Pages/Waiter/waiter-menu-list.jsp").forward(request, response);
    }
}
