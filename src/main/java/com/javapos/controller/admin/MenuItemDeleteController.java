package com.javapos.controller.admin;

import com.javapos.dao.ItemDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/menu-items/delete")
public class MenuItemDeleteController extends HttpServlet {

    private ItemDAO itemDAO;

    @Override
    public void init() throws ServletException {
        itemDAO = new ItemDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                boolean deleted =itemDAO.deleteItem(id);
                
                if (deleted) {
                    System.out.println("Item deleted: ID = " + id);
                } else {
                    System.out.println("Failed to delete item: ID = " + id + " (not found or error)");
                }

                
            } catch (NumberFormatException e) {
                
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/Pages/Admin/admin-menu.jsp");
    }
}
