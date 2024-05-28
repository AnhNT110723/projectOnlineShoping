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
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Category;
import model.Product;
import model.Customer;

/**
 *
 * @author Anh hung
 */
@WebServlet(name = "MnProductServlet", urlPatterns = {"/managerProduct"})
public class MnProductServlet extends HttpServlet {

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
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        //lấy tài khoản từ trên session về để lấy id của người bán
        Customer a = (Customer) session.getAttribute("acc");

        String index_page = request.getParameter("index");
        int count = 0;
        int end_page = 0;
        //Khi mình bắt đầu chạy thì nó tự động load dữ liệu lên trang 1
        if (index_page == null) {
            index_page = "1";
        }
        int index = Integer.parseInt(index_page);
        //tài khoản bị xóa khỏi session
        if (a == null) {
            out.print("Vui lòng đăng nhập lại!!!");
        } else {
            int id = a.getId();

            try {
                DbContext db = new DbContext();
                ArrayList<Product> listP = db.Mnpaging5Product(id, index);//lấy được 5 sản phẩm của người bán bởi id
                ArrayList<Category> listC = db.getAllCategory();

                //Lấy tổng sản phẩm
                count = db.getTotalProductBySellId(id);
                end_page = count / 5;
                if (count % 5 != 0) {
                    end_page++;
                }

                request.setAttribute("ListC", listC);
                request.setAttribute("listP", listP);// Truyền 5 product sang fi;e jsp
                request.setAttribute("endP", end_page);// truyền end page tùy thuộc vào số lượng sản phẩm
                request.setAttribute("tag", index); // truyền index để xử lí phân trang
                request.setAttribute("total", count);
                request.getRequestDispatcher("managerProduct.jsp").forward(request, response);

            } catch (ClassNotFoundException ex) {
                Logger.getLogger(MnProductServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                Logger.getLogger(MnProductServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

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
