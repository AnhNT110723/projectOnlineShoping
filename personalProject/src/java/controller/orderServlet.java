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
@WebServlet(name = "orderServlet", urlPatterns = {"/order"})
public class orderServlet extends HttpServlet {

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
            out.println("<title>Servlet orderServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet orderServlet at " + request.getContextPath() + "</h1>");
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
        String pid = request.getParameter("pid");
        String num_raw = request.getParameter("num");
        int num = 0;
         response.getWriter().print(num_raw);
        if (num_raw != null && !num_raw.isEmpty()) {
             num = Integer.parseInt(num_raw);
           
        }
        try {

            DbContext db = new DbContext();
            Product p = db.getProductbyId(pid);

            int total = 1;
            if(num > 1){
                total += num;
            }

            request.setAttribute("num", total);
            request.setAttribute("p", p);
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(orderServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(orderServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        try {
            Cookie arr[] = request.getCookies();
            List<Product> list = new ArrayList<>();
            DbContext db = new DbContext();
            if (arr != null) {
                for (Cookie o : arr) {
                    if (o.getName().equals("id")) {
                        String txt[] = o.getValue().split(":");
                        for (String s : txt) {
                            list.add(db.getProductbyId(s));
                        }
                    }
                }
            }

            for (int i = 0; i < list.size(); i++) {
                int count = 1;
                list.get(i).setAmount(count);
                for (int j = i + 1; j < list.size(); j++) {
                    if (list.get(i).getId() == list.get(j).getId()) {
                        count++;
                        list.remove(j);
                        j--;
                        list.get(i).setAmount(count);
                    }
                }
            }

            double total = 0;
            int amount = 0;
            for (Product o : list) {
                amount += o.getAmount();
                total = total + o.getAmount() * o.getPrice();
            }

            request.setAttribute("total", total);
            request.setAttribute("amount", amount);
            request.setAttribute("list", list);
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(orderServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(orderServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
