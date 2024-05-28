/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DbContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Customer;

/**
 *
 * @author Anh hung
 */
public class editProfile extends HttpServlet {

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
            out.println("<title>Servlet editProfile</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet editProfile at " + request.getContextPath() + "</h1>");
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

        HttpSession s = request.getSession();
        Customer cus = (Customer) s.getAttribute("acc");

        request.setAttribute("user", cus.getUserName());
        request.setAttribute("email", cus.getEmail());
        request.setAttribute("pass", cus.getPass());

        request.getRequestDispatcher("editProfile.jsp").forward(request, response);
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
            HttpSession s = request.getSession();
            Customer cus = (Customer) s.getAttribute("acc");

            String name = request.getParameter("user");
            String email = request.getParameter("email");
            String pass = request.getParameter("pass");
            String Newpass = request.getParameter("newpass");

            DbContext db = new DbContext();
            if (name.isEmpty() ||  email.isEmpty() ||  Newpass.isEmpty() || pass.isEmpty()) {
                
                request.setAttribute("msg", "You must input all texts");
                request.setAttribute("user", name);
                request.setAttribute("email", email);
                request.setAttribute("pass", pass);
                request.setAttribute("newpass", Newpass);

                
            } else {
                Customer cs = new Customer(cus.getId(), name, email, Newpass, cus.getIsSellId(), cus.getIsadmin());
                db.updateAccount(cs);
                s.setAttribute("acc", cs);
                Customer curentCus = db.getAccountById(String.valueOf(cus.getId()));
                request.setAttribute("msg", "Edit successful !");
                request.setAttribute("user", curentCus.getUserName());
                request.setAttribute("email", curentCus.getEmail());
                request.setAttribute("pass", curentCus.getPass());
                
                
            }
            request.getRequestDispatcher("editProfile.jsp").forward(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(editProfile.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(editProfile.class.getName()).log(Level.SEVERE, null, ex);
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
