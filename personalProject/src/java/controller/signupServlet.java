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
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Customer;
import model.SendMail;

/**
 *
 * @author Anh hung
 */
@WebServlet(name = "signupServlet", urlPatterns = {"/signup"})
public class signupServlet extends HttpServlet {

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
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SentCodeServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SentCodeServlet at " + request.getContextPath() + "</h1>");
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
    String code_raw = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("signup.jsp").forward(request, response);

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
        String re_pass = request.getParameter("repass");

        String email_from = "tanhh244466666@gmail.com";
        String password = "cdsppymuqbmstijr";
        String subject = "This is your code to sign up";
        Random code = new Random();
        int OTP = code.nextInt(999999);
        String message = "<!DOCTYPE html>\n"
                + "<html lang=\"en\">\n"
                + "<h1>This is your Code:</h1>"
                + "</br>"
                + "<h2>" + OTP + "</h2>"
                + "</html>\n";

        Customer user = new Customer(name, pass, email, String.valueOf(OTP), 0, 0);
        double amount = 0;

        if (pass.length() < 6 || !pass.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{6,}$")) {
            //đẩy dữ liệu về trang signup.jsp 
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.setAttribute("pass", pass);
            request.setAttribute("repass", re_pass);
            request.setAttribute("massage", "Password not Strong! please try again!");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        } else if (!pass.equals(re_pass)) {
            //đẩy dữ liệu về trang signup.jsp 
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.setAttribute("pass", pass);
            request.setAttribute("repass", re_pass);
            request.setAttribute("massage", "Password not equal! please try again!");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        } else {
            try {
                DbContext db = new DbContext();
                Customer a = db.checkAcountExist(email);

                if (a == null) {
                    //được sign up nhưng chuyển đến trang verify để xác nhận

                    HttpSession s = request.getSession();
                    s.setAttribute("account", user);
                    // Gửi code về emai
                    SendMail.send(email, subject, message, email_from, password);

                    response.sendRedirect("verify"); // Chuyển hướng đến trang verify.jsp để kích hoạt tài khoản khi thông tin hợp lệ
                } else {
                    // không được sign up
                    request.setAttribute("massages", "Account is exist");

                    request.setAttribute("name", name);
                    request.setAttribute("email", email);
                    request.setAttribute("pass", pass);
                    request.setAttribute("repass", re_pass);
                    request.getRequestDispatcher("signup.jsp").forward(request, response);

                }

            } catch (ClassNotFoundException | SQLException ex) {
                Logger.getLogger(signupServlet.class.getName()).log(Level.SEVERE, null, ex);
                // Nếu có lỗi, bạn có thể chuyển hướng hoặc hiển thị thông báo lỗi tùy thuộc vào yêu cầu
                request.setAttribute("massage", "Error occurred while signing up. Please try again!");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
            }
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
