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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            
            System.out.println("AddItemController: Form received");

            // Read and trim inputs
            String itemName = request.getParameter("itemName").trim();
            String description = request.getParameter("description").trim();
            String category = request.getParameter("category").trim();
            String unit = request.getParameter("unit").trim();
            String imagePath = request.getParameter("imagePath").trim();

            double price = Double.parseDouble(request.getParameter("price").trim());
            float stock = Float.parseFloat(request.getParameter("stock").trim());

            
            System.out.println("AddItemController: Creating item:");
            System.out.println("itemName = " + itemName);
            System.out.println("description = " + description);
            System.out.println("category = " + category);
            System.out.println("unit = '" + unit + "'");
            System.out.println("price = " + price);
            System.out.println("stock = " + stock);
            System.out.println("imagePath = " + imagePath);

            // Create and set item
            Item item = new Item();
            item.setItemName(itemName);
            item.setDescription(description);
            item.setCategory(category);
            item.setUnit(unit);
            item.setPrice(price);
            item.setStock(stock);
            item.setImagePath(imagePath);

            // Save item to database
            ItemDAO itemDAO = new ItemDAO();
            boolean success = itemDAO.addItem(item);

            if (success) {
                System.out.println("AddItemController: Item added successfully");
                response.sendRedirect(request.getContextPath() + "/Pages/Admin/admin-menu.jsp?success=Item added successfully!");
            } else {
                System.out.println("AddItemController: Failed to add item");
                response.sendRedirect(request.getContextPath() + "/Pages/Admin/admin-menu-add.jsp?error=Failed to add item. Try again.");
            }

        } catch (Exception e) {
            e.printStackTrace();  // Still log to console for debugging
            String errorMessage = "Failed to add item: " + e.getMessage();
            response.sendRedirect(request.getContextPath() + "/Pages/Admin/admin-menu-add.jsp?error=" + java.net.URLEncoder.encode(errorMessage, "UTF-8"));
        }

    }
}
