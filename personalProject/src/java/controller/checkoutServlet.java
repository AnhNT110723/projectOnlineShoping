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
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Customer;
import model.Order;
import model.OrderDetail;
import model.Product;

/**
 *
 * @author Anh hung
 */
@WebServlet(name = "checkoutServlet", urlPatterns = {"/checkout"})
public class checkoutServlet extends HttpServlet {

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
            out.println("<title>Servlet checkoutServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet checkoutServlet at " + request.getContextPath() + "</h1>");
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
        PrintWriter out = response.getWriter();

        try {

            DbContext db = new DbContext();
            HttpSession sesion = request.getSession();
            Customer a = (Customer) sesion.getAttribute("acc");
            Cookie arr[] = request.getCookies();
            List<Product> list = new ArrayList<>();
            String first_name = request.getParameter("first-name");
            String last_name = request.getParameter("last-name");
            String address = request.getParameter("address");
            String phone = request.getParameter("tel");
            String total = request.getParameter("productTotal");

            String id = request.getParameter("productId");
            String price = request.getParameter("productPrice");

            if (a == null) {
                response.sendRedirect("login");
            } else {
                Order o = new Order(first_name, last_name, address, phone, Date.valueOf(LocalDate.now()), Double.parseDouble(total), a.getId());

                int oid = db.addOder(o); //add dữ liệu vào order và lấy lại oid
                //mua sản phẩm trực tiếp
                if (id != null && !id.isEmpty() && price != null && !price.isEmpty()) {
                    db.addOderLine(oid, Integer.parseInt(id), 1, Double.parseDouble(price));

                } else {

                    // mua sp trong giỏ hàng
                    if (arr != null) {
                        for (Cookie co : arr) {
                            if (co.getName().equals("id")) {
                                String txt[] = co.getValue().split(":");
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

                    //xóa cookie khi người dùng ấn mua
                    for (Cookie co : arr) {
                        if (co.getName().equals("id")) {
                            co.setMaxAge(0);
                            response.addCookie(co);
                        }
                    }

                    double Total = 0;
                    int amount = 0;
                    for (Product co : list) {
                        amount += co.getAmount();
                        total = total + co.getAmount() * co.getPrice();
                        db.addOderLine(oid, co.getId(), co.getAmount(), co.getPrice());

                    }

                }
                response.sendRedirect("home");
            }

            

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(checkoutServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(checkoutServlet.class.getName()).log(Level.SEVERE, null, ex);
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
