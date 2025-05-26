package com.javapos.controller.admin;

import com.javapos.dao.ItemDAO;
import com.javapos.model.Item;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/menu-items/form")
public class MenuItemEditController extends HttpServlet {

    private ItemDAO itemDAO;

    @Override
    public void init() throws ServletException {
        itemDAO = new ItemDAO();
    }

    // Show edit form
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                Item item = itemDAO.getItemById(id);
                if (item != null) {
                    request.setAttribute("item", item);
                    request.getRequestDispatcher("/Pages/Admin/admin-menu-form.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                // Invalid id format
            }
        }
        // If no id or item not found, redirect back to menu list
        response.sendRedirect(request.getContextPath() + "/Pages/Admin/admin-menu.jsp");
    }

    // Handle update form submission
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int itemId = Integer.parseInt(request.getParameter("itemId"));
            String itemName = request.getParameter("itemName");
            String category = request.getParameter("category");
            double price = Double.parseDouble(request.getParameter("price"));

            Item item = new Item();
            item.setItemId(itemId);
            item.setItemName(itemName);
            item.setCategory(category);
            item.setPrice(price);

            boolean updated = itemDAO.updateItem(item);

            if (updated) {
                // Redirect back to list on success
                response.sendRedirect(request.getContextPath() + "/Pages/Admin/admin-menu.jsp");
            } else {
                request.setAttribute("error", "Failed to update item.");
                request.setAttribute("item", item);
                request.getRequestDispatcher("/Pages/Admin/admin-menu-form.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input.");
            request.getRequestDispatcher("/Pages/Admin/admin-menu-form.jsp").forward(request, response);
        }
    }
}
