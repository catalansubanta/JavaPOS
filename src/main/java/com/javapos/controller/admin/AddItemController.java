package com.javapos.controller.admin;

import com.javapos.dao.ItemDAO;
import com.javapos.model.Item;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/menu-items/add")
public class AddItemController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String itemName = request.getParameter("itemName");
            String description = request.getParameter("description");
            String category = request.getParameter("category");
            String unit = request.getParameter("unit");
            double price = Double.parseDouble(request.getParameter("price"));
            float stock = Float.parseFloat(request.getParameter("stock"));
            String imagePath = request.getParameter("imagePath"); // Now accepts URL input

            // Create item object
            Item item = new Item();
            item.setItemName(itemName);
            item.setDescription(description);
            item.setCategory(category);
            item.setUnit(unit);
            item.setPrice(price);
            item.setStock(stock);
            item.setImagePath(imagePath);

            // Save to DB
            ItemDAO itemDAO = new ItemDAO();
            boolean success = itemDAO.addItem(item);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/Pages/Admin/admin-menu.jsp?success=Item added successfully!");
            } else {
                response.sendRedirect(request.getContextPath() + "/Pages/Admin/admin-menu-add.jsp?error=Failed to add item. Try again.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/Pages/Admin/admin-menu-add.jsp?error=true" + e.getMessage());
        }
    }
}
