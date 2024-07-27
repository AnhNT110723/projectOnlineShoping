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
import java.sql.SQLException;
import java.util.ArrayList;

import model.Category;
import model.Product;

/**
 *
 * @author Anh hung
 */
@WebServlet(name = "StoreServlet", urlPatterns = {"/store"})
public class StoreServlet extends HttpServlet {

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
            out.println("<title>Servlet StoreServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StoreServlet at " + request.getContextPath() + "</h1>");
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
        String cateID = request.getParameter("cid"); //lấy được cid từ url
        String txtSearch = request.getParameter("txt"); // lấy được txt từ url
        String index_page = request.getParameter("index");
        String from = request.getParameter("from");
        String to = request.getParameter("to");
        int count = 0;
        int end_page = 0;
        if (index_page == null) {
            index_page = "1";
        }
        int index = Integer.parseInt(index_page);

        try {
            DbContext db = new DbContext();

            ArrayList<Product> listP = db.pagingAllProduct("0", "999", index); // list all product
            ArrayList<Category> listC = db.getAllCategory(); // list all category
//            ArrayList<Brand> lis_Brand = db.getBrand(cateID); //list brand for cid

            ArrayList<Product> list; // list to show 

            if (cateID != null && !cateID.isEmpty() && !cateID.equalsIgnoreCase("all") && txtSearch != null && !txtSearch.isEmpty()) {
                // Nếu cả hai tham số đều tồn tại, thực hiện lấy danh sách sản phẩm dựa trên cả hai điều kiện
                if ((from == null || from.isEmpty()) && (to == null || to.isEmpty())) {
                    list = db.pagingProductByCidAndTxt("0", "999", index, cateID, txtSearch);
                    count = db.getTotalProductByCidAndTxt(cateID, txtSearch, 0, 999);
                } else {
                    //
                    list = filterProductsByPrice(db.pagingProductByCidAndTxt(from, to, index, cateID, txtSearch), Double.parseDouble(from), Double.parseDouble(to));
                    count = db.getTotalProductByCidAndTxt(cateID,txtSearch, Double.parseDouble(from), Double.parseDouble(to));
                }
                end_page = count / 12;
                if (count % 12 != 0) {
                    end_page++;
                }
            } else if (cateID != null && !cateID.isEmpty() && !cateID.equalsIgnoreCase("all")) {
                // Nếu chỉ có tham số cid tồn tại, lấy danh sách sản phẩm theo category
                if ((from == null || from.isEmpty()) && (to == null || to.isEmpty())) {
                    list = db.pagingProductByCid("0", "999", index, cateID);
                    count = db.getTotalProductByCid(cateID, 0, 999);
                } else {//
                    list = filterProductsByPrice(db.pagingProductByCid(from, to, index, cateID), Double.parseDouble(from), Double.parseDouble(to));
                    count = db.getTotalProductByCid(cateID, Double.parseDouble(from), Double.parseDouble(to));
                }
                end_page = count / 12;
                if (count % 12 != 0) {
                    end_page++;
                }
            } else if (txtSearch != null && !txtSearch.isEmpty()) {
                //Nếu chỉ có tham số txt tồn tại, lấy danh sách sản phẩm theo txtSearch
                if ((from == null || from.isEmpty()) && (to == null || to.isEmpty())) {
                    list = db.pagingProductByTxt("0", "999", index, txtSearch);
                    count = db.getTotalProductByTxt(txtSearch, 0, 999);

                } else {//
                    list = filterProductsByPrice(db.pagingProductByTxt(from, to, index, txtSearch), Double.parseDouble(from), Double.parseDouble(to));
                    count = db.getTotalProductByTxt(txtSearch, Double.parseDouble(from), Double.parseDouble(to));
                }

                end_page = count / 12;
                if (count % 12 != 0) {
                    end_page++;
                }
            } else {
                // Nếu không có tham số nào tồn tại, hiển thị tất cả sản phẩm
                if ((from == null || from.isEmpty()) && (to == null || to.isEmpty())) {
                    list = listP;

                    count = db.getTotalProduct();
                    end_page = count / 12;
                    if (count % 12 != 0) {
                        end_page++;
                    }
                } else {
                    list = filterProductsByPrice(db.pagingAllProduct(from, to, index), Double.parseDouble(from), Double.parseDouble(to));
                    count = db.getTotalProductByPrice(Double.parseDouble(from), Double.parseDouble(to));
                    //response.getWriter().print(count);
                    end_page = count / 12;
                    if (count % 12 != 0) {
                        end_page++;
                    }
                }
            }
//            request.setAttribute("listb", lis_Brand);
            request.setAttribute("endP", end_page);// truyền end page tùy thuộc vào số lượng sản phẩm
            request.setAttribute("ListP", list); // Truyền list product sang file jsp
            request.setAttribute("tag", index); // truyền index để xử lí phân trang
            request.setAttribute("ListC", listC); // Truyền list category sang file jsp
            request.setAttribute("text", txtSearch); //để lưu trữ giá trị search khi ấn search
            request.setAttribute("cid", cateID); // để lưu trữ category khi ấn search
            request.setAttribute("from", from); // để lưu trữ category khi ấn search
            request.setAttribute("to", to); // để lưu trữ category khi ấn search

            request.getRequestDispatcher("store.jsp").forward(request, response);
        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace(); // In ra lỗi nếu có
        }
        PrintWriter out = response.getWriter();
        out.print(cateID);

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
        String cateID = request.getParameter("cid"); //lấy được cid từ url
        String txtSearch = request.getParameter("txt"); // lấy được txt từ url
        String index_page = request.getParameter("index");
        String from = request.getParameter("from");
        String to = request.getParameter("to");

        int count = 0;
        int end_page = 0;
        //Khi mình bắt đầu chạy thì nó tự động load dữ liệu lên trang 1
        if (index_page == null) {
            index_page = "1";
        }
        int index = Integer.parseInt(index_page);

        try {
            DbContext db = new DbContext();

            ArrayList<Product> listP = db.pagingAllProduct("0", "999", index); // list all product
            ArrayList<Category> listC = db.getAllCategory(); // list all category
//            ArrayList<Brand> lis_Brand = db.getBrand(cateID); //list brand for cid

            ArrayList<Product> list; // list to show 

            if (cateID != null && !cateID.isEmpty() && !cateID.equalsIgnoreCase("all") && txtSearch != null && !txtSearch.isEmpty()) {
                // Nếu cả hai tham số đều tồn tại, thực hiện lấy danh sách sản phẩm dựa trên cả hai điều kiện
                list = db.pagingProductByCidAndTxt("0", "999", index, cateID, txtSearch);
                count = db.getTotalProductByCidAndTxt(cateID, txtSearch, 0, 999);
                end_page = count / 12;
                if (count % 12 != 0) {
                    end_page++;
                }
            } else if (cateID != null && !cateID.isEmpty() && !cateID.equalsIgnoreCase("all")) {
                // Nếu chỉ có tham số cid tồn tại, lấy danh sách sản phẩm theo category
                list = db.pagingProductByCid("0", "999", index, cateID);
                count = db.getTotalProductByCid(cateID, 0, 999);
                end_page = count / 12;
                if (count % 12 != 0) {
                    end_page++;
                }
            } else if (txtSearch != null && !txtSearch.isEmpty()) {
                //Nếu chỉ có tham số txt tồn tại, lấy danh sách sản phẩm theo txtSearch
                list = db.pagingProductByTxt("0", "999", index, txtSearch);
                count = db.getTotalProductByTxt(txtSearch, 0, 999);
                end_page = count / 12;
                if (count % 12 != 0) {
                    end_page++;
                }
            } else {
                // Nếu không có tham số nào tồn tại, hiển thị tất cả sản phẩm

                list = listP;

                count = db.getTotalProduct();
                end_page = count / 12;
                if (count % 12 != 0) {
                    end_page++;
                }

            }
//            request.setAttribute("listb", lis_Brand);
            request.setAttribute("endP", end_page);// truyền end page tùy thuộc vào số lượng sản phẩm
            request.setAttribute("ListP", list); // Truyền list product sang fi;e jsp
            request.setAttribute("tag", index); // truyền index để xử lí phân trang
            request.setAttribute("ListC", listC); // Truyền list category sang file jsp
            request.setAttribute("text", txtSearch); //để lưu trữ giá trị search khi ấn search
            request.setAttribute("cid", cateID); // để lưu trữ category khi ấn search

            request.getRequestDispatcher("store.jsp").forward(request, response);
        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace(); // In ra lỗi nếu có
        }
    }

    private ArrayList<Product> filterProductsByPrice(ArrayList<Product> products, double fromPrice, double toPrice) {
        // Giả sử có một danh sách sản phẩm
        // Điền dữ liệu sản phẩm vào đây

        // Lọc sản phẩm theo giá
        ArrayList<Product> filteredProducts = new ArrayList<>();
        for (Product product : products) {
            if (product.getPrice() >= fromPrice && product.getPrice() <= toPrice) {
                filteredProducts.add(product);
            }
        }
        return filteredProducts;
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
