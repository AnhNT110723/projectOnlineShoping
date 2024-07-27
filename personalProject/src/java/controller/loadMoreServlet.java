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
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Product;

/**
 *
 * @author Anh hung
 */
@WebServlet(name = "loadMoreServlet", urlPatterns = {"/load"})
public class loadMoreServlet extends HttpServlet {

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
            out.println("<title>Servlet loadMoreServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet loadMoreServlet at " + request.getContextPath() + "</h1>");
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
        String amount = request.getParameter("exits");
        int int_amount = Integer.parseInt(amount);
        try {
            DbContext db = new DbContext();
            ArrayList<Product> listP = db.getNext4Product(int_amount); // get next12 product
            PrintWriter out = response.getWriter();

            for (Product o : listP) {

                out.print(" <div class=\"amountt product col-sm-3\">\n"
                        + "                                <div class=\"product-img\">\n"
                        + "                                    <img src=\""+o.getImage()+"\" alt=\"\">\n"
                        + "                                    <div class=\"product-label\">\n"
                        + "                                        <span class=\"sale\">-30%</span>\n"
                        + "                                        <span class=\"new\">NEW</span>\n"
                        + "                                    </div>\n"
                        + "                                </div>\n"
                        + "                                <div class=\"product-body listProduct-body new\">\n"
                        + "\n"
                        + "                                    <h3 class=\"product-name\"><a href=\"detail?pid="+o.getId()+"\">"+o.getName()+"</a></h3>\n"
                        + "                                    <h4 class=\"product-price\">$"+o.getPrice()+"<del class=\"product-old-price\">$990.00</del></h4>\n"
                        + "                                    <div class=\"product-rating\" style=\" display: ruby;\">\n"
                        + "                                        <p class=\"product-category\">"+o.getTitle()+"</p>\n"
                        + "                                    </div>\n"
                        + "                                    <div class=\"product-btns\">\n"
                        + "                                        <button class=\"add-to-wishlist\"><i class=\"fa fa-heart-o\"></i><span class=\"tooltipp\">add to wishlist</span></button>\n"
                        + "                                         <a href=\"cart?cid="+o.getId()+"\" style=\"margin: 0 15px\" class=\"add-to-compare\"><i class=\"fa fa-shopping-cart\"></i><span class=\"tooltipp\"></span></a>\n"
                        + "                                        <button class=\"quick-view\"><i class=\"fa fa-eye\"></i><span class=\"tooltipp\">quick view</span></button>\n"
                        + "                                    </div>\n"
                        + "                                </div>\n"
                        + "                                <div class=\"add-to-cart\">\n"
                        + "                                      <button class=\"add-to-cart-btn\"  onclick=\"redirectToPage('order?pid="+o.getId()+"')\"><i class=\"fa fa-shopping-bag\"></i>Mua Ngay</button>\n"
                        + "                                </div>\n"
                        + "                            </div>\n"
                        + "\n"
                        + "                            <!-- /product -->\n"
                        + "");
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(loadMoreServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(loadMoreServlet.class.getName()).log(Level.SEVERE, null, ex);
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
