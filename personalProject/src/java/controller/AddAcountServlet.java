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
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Customer;
import model.SendMail;

/**
 *
 * @author Anh hung
 */
@WebServlet(name = "AddAcountServlet", urlPatterns = {"/addacount"})
public class AddAcountServlet extends HttpServlet {

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
            out.println("<title>Servlet AddAcountServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddAcountServlet at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String pass = request.getParameter("pass");
        String sell = request.getParameter("sell");
        String ad = request.getParameter("ad");
        String seller, Admin = "";
        if (sell != null) {
            seller = "1";
        } else {
            seller = "0";
        }
        if (ad != null) {
            Admin = "1";
        } else {
            Admin = "0";
        }

        try {
            DbContext db = new DbContext();
            Customer a = db.checkAcountExist(email);

            if (a == null) {
                //được sign up

                db.signUp(name, email, pass, seller, Admin, "0", 0);

                response.sendRedirect("ManagerAccount"); // Chuyển hướng đến trang verify.jsp để kích hoạt tài khoản khi thông tin hợp lệ
            } else {
                // không được sign up
                request.setAttribute("massages", "Account is exist");
                request.getRequestDispatcher("managerAccount.jsp").forward(request, response);

            }

        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(signupServlet.class.getName()).log(Level.SEVERE, null, ex);
            // Nếu có lỗi, bạn có thể chuyển hướng hoặc hiển thị thông báo lỗi tùy thuộc vào yêu cầu
            request.setAttribute("massage", "Error occurred while signing up. Please try again!");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
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
