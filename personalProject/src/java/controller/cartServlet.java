/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DbContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Product;

/**
 *
 * @author Anh hung
 */
@WebServlet(name = "cartServlet", urlPatterns = {"/show"})
public class cartServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet cartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet cartServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            Cookie arr[] = request.getCookies();
            List<Product> list = new ArrayList<>();
            DbContext db = new DbContext();
            if (arr != null) {
                for (Cookie o : arr) {
                    if (o.getName().equals("id")) {
                        String txt[] = o.getValue().split(":");
                        if (txt != null) {
                            for (String s : txt) {
                                list.add(db.getProductbyId(s));
                            }
                        }
                    }
                }
            }

            for (int i = 0; i < list.size(); i++) {
                int count = 1;
                Product product = list.get(i); // Retrieve the product at index i
                if (product != null) { // Check if the product is not null
                    product.setAmount(count); // Set the amount for the product
                    for (int j = i + 1; j < list.size(); j++) {
                        if (product.getId() == list.get(j).getId()) {
                            count++;
                            list.remove(j);
                            j--;
                            product.setAmount(count);
                        }
                    }
                }
            }

            double total = 0;
            int amount = 0;
            for (Product o : list) {
                if (o != null) { // Check if the product is not null
                    amount += o.getAmount();
                    total += o.getAmount() * o.getPrice();
                }
            }

            request.setAttribute("list", list);
            request.setAttribute("total", total);
            request.setAttribute("amount", amount);

            request.setAttribute("vat", 0.1 * total);
            request.setAttribute("sum", 2 + total);

            request.getRequestDispatcher("cart.jsp").forward(request, response);

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(cartServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(cartServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
