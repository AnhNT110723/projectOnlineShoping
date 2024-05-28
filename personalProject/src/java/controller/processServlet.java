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
@WebServlet(name = "processServlet", urlPatterns = {"/process"})
public class processServlet extends HttpServlet {

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
            out.println("<title>Servlet processServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet processServlet at " + request.getContextPath() + "</h1>");
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
        String num_raw = request.getParameter("num");
        String id = request.getParameter("id");
        String pid = request.getParameter("pid");

        try {
            DbContext db = new DbContext();
            List<Product> list = new ArrayList<>();

            // Lấy danh sách sản phẩm từ cookie
            Cookie[] arr = request.getCookies();
            if (arr != null) {
                for (Cookie cookie : arr) {
                    if (cookie.getName().equals("id")) {
                        String[] txt = cookie.getValue().split(":");
                        for (String s : txt) {
                            list.add(db.getProductbyId(s));
                        }
                        // Xóa cookie cũ đi
                        cookie.setMaxAge(0);
                        response.addCookie(cookie);
                    }
                }
            }

            if (num_raw != null && id != null) {

                Product p = db.getProductbyId(id);

                int productId = Integer.parseInt(id);
                int num = Integer.parseInt(num_raw);

                // Nếu num là 1, thêm sản phẩm vào giỏ hàng
                // Nếu num là -1, xóa sản phẩm khỏi giỏ hàng
                if (num == 1) {
                    list.add(p);
                } else if (num == -1) {
                    // Tìm và loại bỏ sản phẩm có id tương ứng
                    for (int i = list.size() - 1; i >= 0; i--) {
                        if (list.get(i).getId() == productId) {
                            list.remove(i);
                            break; // Đảm bảo chỉ xóa một sản phẩm
                        }
                    }
                }
            } else if (pid != null && !pid.isEmpty()) {
                int productId = Integer.parseInt(pid);

                // Tìm và loại bỏ tất cả các sản phẩm có id tương ứng
                for (int i = list.size() - 1; i >= 0; i--) {
                    if (list.get(i).getId() == productId) {
                        list.remove(i);
                    }
                }
            }
            // Lưu danh sách sản phẩm vào cookie
            String txt = "";
            if (!list.isEmpty()) {
                txt = "" + list.get(0).getId();
                for (int i = 1; i < list.size(); i++) {
                    txt += ":" + list.get(i).getId();
                }
            }
            Cookie cartCookie = new Cookie("id", txt);
            response.addCookie(cartCookie);

            // Chuyển hướng đến trang giỏ hàng
            response.sendRedirect("show");

        } catch (ClassNotFoundException | SQLException ex) {
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
