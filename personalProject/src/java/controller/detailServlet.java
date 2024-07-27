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
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Category;
import model.Customer;
import model.Product;
import model.review;

/**
 *
 * @author Anh hung
 */
@WebServlet(name = "detailServlet", urlPatterns = {"/detail"})
public class detailServlet extends HttpServlet {

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
        String id = request.getParameter("pid");
        try {
            DbContext db = new DbContext();
            Product p = db.getProductbyIdForDetail(id);//lấy sản phẳm theo id
            ArrayList<Category> listC = db.getAllCategory();
            ArrayList<review> list_Review = db.getReviewbyId(id);
            int avgRating = db.getAVGreview(id);

            ArrayList<Integer> listStars_Db = db.getRating(id);
            int star1 = 0, star2 = 0, star3 = 0, star4 = 0, star5 = 0;
            for (Integer l : listStars_Db) {
                if (l == 1) {
                    star1++;
                } else if (l == 2) {
                    star2++;
                } else if (l == 3) {
                    star3++;
                } else if (l == 4) {
                    star4++;
                } else {
                    star5++;
                }
            }

            ArrayList<review> listStars = new ArrayList<>();
            listStars.add(new review("1", star1));
            listStars.add(new review("2", star2));
            listStars.add(new review("3", star3));
            listStars.add(new review("4", star4));
            listStars.add(new review("5", star5));

            request.setAttribute("listStars", listStars);
            request.setAttribute("avg", avgRating);
            request.setAttribute("ListReview", list_Review);
            request.setAttribute("ListC", listC);
            request.setAttribute("detail", p);
            request.getRequestDispatcher("detail.jsp").forward(request, response);

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(detailServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(detailServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        try {
            String pid = request.getParameter("pid");
            String your_name = request.getParameter("name");
            String your_email = request.getParameter("email");
            String your_review = request.getParameter("review");
            String rating = request.getParameter("rating");
            int rating_int = 0;
            if (rating != null && !rating.isEmpty()) {
                rating_int = Integer.parseInt(rating);
            }
            HttpSession s = request.getSession();
            Customer cus = (Customer) s.getAttribute("acc");
            DbContext db = new DbContext();

            if (cus == null) {
                response.sendRedirect("login");
            } else {
                db.insertReview(your_name, your_email, rating_int, java.sql.Date.valueOf(LocalDate.now()), your_review, Integer.parseInt(pid), cus.getId());
                response.sendRedirect("detail?pid=" + pid);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(detailServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(detailServlet.class.getName()).log(Level.SEVERE, null, ex);
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
