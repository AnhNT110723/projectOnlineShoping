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
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Customer;

/**
 *
 * @author Anh hung
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

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
            out.println("<title>Servlet NewServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NewServlet at " + request.getContextPath() + "</h1>");
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
        //b1: get usser and pass from cookie
        Cookie arr[] = request.getCookies();
        //b2: set usser va passs to login form
       if(arr != null) {
            for (Cookie o : arr) {
            if (o.getName().equals("userC")) {
                request.setAttribute("emailInput", o.getValue());
            }
            if (o.getName().equals("passC")) {
                request.setAttribute("passInput", o.getValue());
            }
        }
       }

        
        request.getRequestDispatcher("Login.jsp").forward(request, response);

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
        response.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");
        String pass = request.getParameter("pass");
        String rem = request.getParameter("rem");

        try {
            DbContext db = new DbContext();
            Customer a = db.login(email, pass);

            //chưa có tài khoản a trong db
            if (a == null) {
                request.setAttribute("massage", "Worng email or password! Please try again!");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            } else {
                HttpSession sesion = request.getSession();
                //Đẩy account lên session
                sesion.setAttribute("acc", a);
                //set thời gian tồn tại account trên session
                sesion.setMaxInactiveInterval(60*60*23*2);

                //Lưu account lên cookie
                Cookie e = new Cookie("userC", email);
                Cookie p = new Cookie("passC", pass);
                e.setMaxAge(60 * 60 * 24);

                if (rem != null) {
                    p.setMaxAge(60 * 60 * 24);
                  
                } else {
                    p.setMaxAge(0);
                } 
                    
                response.addCookie(e); //lưu e và p lên trên chorme (Trình duyệt)
                response.addCookie(p);
                response.sendRedirect("home");
            }

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
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
