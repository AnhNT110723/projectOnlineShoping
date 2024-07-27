/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DbContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Category;
import model.Product;

/**
 *
 * @author Anh hung
 */
public class HomeServlet extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");
        String txtSearch = request.getParameter("txt"); // lấy được txt từ url
        PrintWriter out = response.getWriter();
        try {
            DbContext db = new DbContext();
            ArrayList<Product> listP = db.getTop8(); // list all product
            ArrayList<Category> listC = db.getAllCategory(); // list all category
            ArrayList<Product> listNew = db.getNewProduct(); // list new product

            request.setAttribute("ListAll", listP);
            request.setAttribute("listNew", listNew);
            request.setAttribute("ListC", listC);
            request.setAttribute("text", txtSearch);

            //Lấy lượng sản phẩm đã thêm trong giỏ hàng
            Cookie arr[] = request.getCookies();
            List<Product> list = new ArrayList<>();

            if (arr != null) {
                for (Cookie o : arr) {
                    if (o.getName().equals("id") && o.getValue() != null) {
                        String txt[] = o.getValue().split(":");
                        for (String s : txt) {
                            list.add(db.getProductbyId(s));
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
            }
            int amount = 0;

            for (Product o : list) {
                if (o != null) {
                    amount += o.getAmount();
                }
            }

            request.setAttribute("amount", amount);
            request.getRequestDispatcher("home.jsp").forward(request, response);

        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace(); // In ra lỗi nếu có
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request try { DbContext db = new DbContext();
     * ArrayList<Product> listP = db.getAllProduct(); // list all product
     * ArrayList<Category> listC = db.getAllCategory(); // list all category
     * ArrayList<Product> listNew = db.getNewProduct(); // list new product
     * ArrayList<Product> list; // list for choose category ArrayList<Product>
     * listName; // list for search * if (cateID != null && !cateID.isEmpty() &&
     * !cateID.equalsIgnoreCase("all")) { list = db.getProductbyCid(cateID); }
     * else { // Hiển thị tất cả sản phẩm nếu cateID là null hoặc "all" list =
     * listP; }
     *
     * if (txtSearch != null && !txtSearch.isEmpty()) { listName =
     * db.searchByName(txtSearch); } else { listName = listP; }
     *
     * request.setAttribute("ListAll", list); request.setAttribute("ListAll",
     * listName); request.setAttribute("listNew", listNew);
     * request.setAttribute("ListC", listC); request.setAttribute("text",
     * txtSearch);
     *
     * request.getRequestDispatcher("home.jsp").forward(request, response); }
     * catch (ClassNotFoundException | SQLException ex) { ex.printStackTrace();
     * // In ra lỗi nếu có }
     *
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
