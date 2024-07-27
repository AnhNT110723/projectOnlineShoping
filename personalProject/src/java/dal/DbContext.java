/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;
import model.Category;
import model.Product;
import model.Customer;
import model.Order;
import model.review;

/**
 *
 * @author Anh hung
 */
public class DbContext {

    Connection connection;

    public DbContext() throws ClassNotFoundException, SQLException {

        String user = "sa";
        String pass = "Tuan2003";
        String url = "jdbc:sqlserver://localhost:1433;databaseName=project_prj";
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        connection = DriverManager.getConnection(url, user, pass);
    }

    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        DbContext db = new DbContext();
        //    Customer cs = new Customer(3, "Huyen", "Huyen@qo.com", "Tuan2003", 1, 1);
        //db.insertReview("A", "a@gmail.com", 5, Date.valueOf("2023-3-3"), "qua ok", 1, 1);
        System.out.println(db);
//        ArrayList<Product> list = db.pagingAllProduct(0);
//        for (Product o : list) {
//            System.out.println(o);
//        }
    }

    //======== LOAD DỮ LIỆU TỪ DATABASE ============
    //Lấy ra tất cả sản phẩm trong database 
    public ArrayList<Product> getAllProduct() throws SQLException {
        ArrayList<Product> list = new ArrayList<>();
        String sql = "select  [id]\n"
                + "      ,[name]\n"
                + "      ,[image]\n"
                + "      ,[price]\n"
                + "      ,[title]\n"
                + "      ,[description]\n"
                + "      ,[catId]\n"
                + "      ,[sellId] from product";
        PreparedStatement statement = connection.prepareStatement(sql);
        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
            int id = rs.getInt(1);
            String name = rs.getString(2);
            String image = rs.getString(3);
            double price = rs.getDouble(4);
            String title = rs.getString(5);
            String descritption = rs.getString(6);

            list.add(new Product(id, name, image, price, title, descritption));
        }
        return list;
    }

    //Lấy ra những sản phẩm bởi category Id
    public ArrayList<Product> getProductbyCid(String cid) throws SQLException {
        ArrayList<Product> list = new ArrayList<>();
        String sql = "select  [id]\n"
                + "      ,[name]\n"
                + "      ,[image]\n"
                + "      ,[price]\n"
                + "      ,[title]\n"
                + "      ,[description]\n"
                + "      ,[catId]\n"
                + "      ,[sellId] from product where catID = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, cid);
        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
            int id = rs.getInt(1);
            String name = rs.getString(2);
            String image = rs.getString(3);
            double price = rs.getDouble(4);
            String title = rs.getString(5);
            String descritption = rs.getString(6);

            list.add(new Product(id, name, image, price, title, descritption));
        }
        return list;
    }

    //Lấy ra những sản phẩm theo người bán
    public ArrayList<Product> getProductbySellId(int Sid) throws SQLException {
        ArrayList<Product> list = new ArrayList<>();
        String sql = "  select  [id]\n"
                + "      ,[name]\n"
                + "      ,[image]\n"
                + "      ,[price]\n"
                + "      ,[title]\n"
                + "      ,[description]\n"
                + "      ,[catId]\n"
                + "      ,[sellId] from product where sellId = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, Sid);
        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
            int id = rs.getInt(1);
            String name = rs.getString(2);
            String image = rs.getString(3);
            double price = rs.getDouble(4);
            String title = rs.getString(5);
            String descritption = rs.getString(6);

            list.add(new Product(id, name, image, price, title, descritption));
        }
        return list;
    }

    //Lấy ra những sản phẩm khi search
    public ArrayList<Product> searchByName(String txtSearch) throws SQLException {
        ArrayList<Product> list = new ArrayList<>();
        String sql = "	select  [id]\n"
                + "      ,[name]\n"
                + "      ,[image]\n"
                + "      ,[price]\n"
                + "      ,[title]\n"
                + "      ,[description]\n"
                + "      ,[catId]\n"
                + "      ,[sellId] from product where [name] like ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, "%" + txtSearch + "%");
        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
            int id = rs.getInt(1);
            String name = rs.getString(2);
            String image = rs.getString(3);
            double price = rs.getDouble(4);
            String title = rs.getString(5);
            String descritption = rs.getString(6);

            list.add(new Product(id, name, image, price, title, descritption));
        }
        return list;
    }

    //Lấy ra những product bởi category và name(Khi chọn category và search)
    public ArrayList<Product> getProductByCategoryAndName(String cateId, String txtSearch) throws SQLException {
        ArrayList<Product> list = new ArrayList<>();
        String sql = "SELECT  [id]\n"
                + "      ,[name]\n"
                + "      ,[image]\n"
                + "      ,[price]\n"
                + "      ,[title]\n"
                + "      ,[description]\n"
                + "      ,[catId]\n"
                + "      ,[sellId] FROM product WHERE catId = ? AND name LIKE ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, cateId);
        statement.setString(2, "%" + txtSearch + "%");
        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
            int id = rs.getInt(1);
            String name = rs.getString(2);
            String image = rs.getString(3);
            double price = rs.getDouble(4);
            String title = rs.getString(5);
            String description = rs.getString(6);

            list.add(new Product(id, name, image, price, title, description));
        }
        return list;
    }

    //Lấy ra những product bởi category và name(Khi chọn category và search)
    public ArrayList<Product> getProductByPrice(String price1, String price2) throws SQLException {
        ArrayList<Product> list = new ArrayList<>();
        String sql = "SELECT  [id]\n"
                + "      ,[name]\n"
                + "      ,[image]\n"
                + "      ,[price]\n"
                + "      ,[title]\n"
                + "      ,[description]\n"
                + "      ,[catId]\n"
                + "      ,[sellId] FROM product WHERE CAST(REPLACE(REPLACE(price, '.', ''), ',', '') AS INT) \n"
                + "BETWEEN ? AND ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, price1);
        statement.setString(2, price2);
        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
            int id = rs.getInt(1);
            String name = rs.getString(2);
            String image = rs.getString(3);
            double price = rs.getDouble(4);
            String title = rs.getString(5);
            String description = rs.getString(6);

            list.add(new Product(id, name, image, price, title, description));
        }
        return list;
    }

    //Lấy ra những product bởi id
    public Product getProductbyId(String Id) throws SQLException {

        String sql = "select  [id]\n"
                + "      ,[name]\n"
                + "      ,[image]\n"
                + "      ,[price]\n"
                + "      ,[title]\n"
                + "      ,[description]\n"
                + "      ,[catId]\n"
                + "      ,[sellId] from product where id = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, Id);
        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
            int id = rs.getInt(1);
            String name = rs.getString(2);
            String image = rs.getString(3);
            double price = rs.getDouble(4);
            String title = rs.getString(5);
            String descritption = rs.getString(6);
            int cid = rs.getInt(7);

            return new Product(id, name, image, price, title, descritption, cid);
        }
        return null;
    }

    //Lấy ra những product bởi id nhưng lấy hết tất cả các ảnh
    public Product getProductbyIdForDetail(String Id) throws SQLException {

        String sql = "select  [id]\n"
                + "      ,[name]\n"
                + "      ,[image]\n"
                + "      ,[image1]\n"
                + "      ,[image2]\n"
                + "      ,[image3]\n"
                + "      ,[price]\n"
                + "      ,[title]\n"
                + "      ,[description]\n"
                + "      ,[catId]\n"
                + "      ,[sellId] from product where id = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, Id);
        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
            int id = rs.getInt(1);
            String name = rs.getString(2);
            String image1 = rs.getString(3);
            String image2 = rs.getString(4);
            String image3 = rs.getString(5);
            String image4 = rs.getString(6);

            double price = rs.getDouble(7);
            String title = rs.getString(8);
            String descritption = rs.getString(9);
            int cid = rs.getInt(10);

            return new Product(id, name, image1, image2, image3, image4, price, title, descritption, cid, cid);
        }
        return null;
    }

    //Lấy ra tất cả category
    public ArrayList<Category> getAllCategory() throws SQLException {
        ArrayList<Category> list = new ArrayList<>();
        String sql = "select *  from Category c";
        PreparedStatement statement = connection.prepareStatement(sql);
        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
            int cid = rs.getInt(1);
            String cname = rs.getString(2);

            list.add(new Category(cid, cname));
        }
        return list;
    }

    // Lấy ra 5 sản phẩm mới nhất
    public ArrayList<Product> getNewProduct() throws SQLException {
        ArrayList<Product> list = new ArrayList<>();
        String sql = "select top 5  [id]\n"
                + "      ,[name]\n"
                + "      ,[image]\n"
                + "      ,[price]\n"
                + "      ,[title]\n"
                + "      ,[description]\n"
                + "      ,[catId]\n"
                + "      ,[sellId] from product order by product.id desc";
        PreparedStatement statement = connection.prepareStatement(sql);
        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
            int id = rs.getInt(1);
            String name = rs.getString(2);
            String image = rs.getString(3);
            double price = rs.getDouble(4);
            String title = rs.getString(5);
            String descritption = rs.getString(6);

            list.add(new Product(id, name, image, price, title, descritption));
        }
        return list;
    }

    // Lấy ra 4 sản phẩm mới nhất
    public ArrayList<Product> getNewProductById(int cid) throws SQLException {
        ArrayList<Product> list = new ArrayList<>();
        String sql = "select top 4 [id]\n"
                + "      ,[name]\n"
                + "      ,[image]\n"
                + "      ,[price]\n"
                + "      ,[title]\n"
                + "      ,[description]\n"
                + "      ,[catId]\n"
                + "      ,[sellId] from product where catId =? order by product.id desc";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, cid);
        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
            int id = rs.getInt(1);
            String name = rs.getString(2);
            String image = rs.getString(3);
            double price = rs.getDouble(4);
            String title = rs.getString(5);
            String descritption = rs.getString(6);

            list.add(new Product(id, name, image, price, title, descritption));
        }
        return list;
    }

    // Lấy ra 8 sản phẩm 
    public ArrayList<Product> getTop8() throws SQLException {
        ArrayList<Product> list = new ArrayList<>();
        String sql = "select top 8  [id]\n"
                + "      ,[name]\n"
                + "      ,[image]\n"
                + "      ,[price]\n"
                + "      ,[title]\n"
                + "      ,[description]\n"
                + "      ,[catId]\n"
                + "      ,[sellId] from product";
        PreparedStatement statement = connection.prepareStatement(sql);
        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
            int id = rs.getInt(1);
            String name = rs.getString(2);
            String image = rs.getString(3);
            double price = rs.getDouble(4);
            String title = rs.getString(5);
            String descritption = rs.getString(6);

            list.add(new Product(id, name, image, price, title, descritption));
        }
        return list;
    }

    // Lấy ra tất cả tài khoản
    public ArrayList<Customer> getAllAccount() throws SQLException {
        ArrayList<Customer> list = new ArrayList<>();
        String sql = "select * from account";
        PreparedStatement statement = connection.prepareStatement(sql);
        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
            int u_id = rs.getInt(1);
            String u_name = rs.getString(2);
            String pass = rs.getString(3);
            String email = rs.getString(4);
            double amount = rs.getDouble(5);
            String code = rs.getString(6);
               int is_sell = rs.getInt(7);
            int is_admin = rs.getInt(8);
            list.add(new Customer(u_id, u_name, amount, pass, email, is_sell, is_admin, code));
        }
        return list;
    }

    // Lấy ra tài khoản theo id
    public Customer getAccountById(String id) throws SQLException {

        String sql = "select * from account where uid = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, id);
        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
            int u_id = rs.getInt(1);
            String u_name = rs.getString(2);
            String pass = rs.getString(3);
            String email = rs.getString(4);
            double amount = rs.getDouble(5);
            String code = rs.getString(6);
            int is_sell = rs.getInt(7);
            int is_admin = rs.getInt(8);
            
            return new Customer(u_id, u_name, amount, pass, email, is_sell, is_admin, code);
        }
        return null;
    }

    //Lấy ra những review bởi id sản phẩm
    public ArrayList<review> getReviewbyId(String Id) throws SQLException {
        ArrayList<review> list = new ArrayList<>();
        String sql = "  SELECT [review_id]\n"
                + "      ,[product_id]\n"
                + "      ,[user_name]\n"
                + "      ,r.[email]\n"
                + "      ,[rating]\n"
                + "      ,[review_text]\n"
                + "      ,[review_date]\n"
                + "      ,a.[user]\n"
                + "  FROM [project_PRJ].[dbo].[reviews] r\n"
                + "  join [dbo].[account] a on r.accid = a.uid\n"
                + "  where r.product_id = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, Id);
        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
            String id = rs.getString(1);
            int pid = rs.getInt(2);
            String name = rs.getString(3);
            String email = rs.getString(4);
            int rating = rs.getInt(5);
            String review_text = rs.getString(6);
            Date date = rs.getDate(7);
            String user_name = rs.getString(8);

            list.add(new review(id, name, email, rating, review_text, date, pid, user_name));
        }
        return list;
    }

    //Lấy ra trung bình đánh giá sao by id sản phẩm
    public int getAVGreview(String Id) throws SQLException {

        String sql = "SELECT AVG(rating) AS average_rating\n"
                + "FROM reviews\n"
                + "WHERE product_id = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, Id);
        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
            int id = rs.getInt(1);

            return id;
        }
        return 0;
    }

    //Lấy ra tất cả sao đánh giá by id sản phẩm
    public ArrayList<Integer> getRating(String Id) throws SQLException {
        ArrayList<Integer> list = new ArrayList<>();
        String sql = "    \n"
                + "      SELECT\n"
                + "    rating\n"
                + "FROM \n"
                + "    reviews\n"
                + "WHERE \n"
                + "    product_id = ?;";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, Id);
        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
            int id = rs.getInt(1);

            list.add(id);
        }
        return list;
    }

    //========== PHÂN TRANG THEO TIM KIEM SẢN PHẨM ============
    // Lấy ra 5 sản phẩm mới nhất (Ajax)
    public ArrayList<Product> getNext4Product(int amount) throws SQLException {
        ArrayList<Product> list = new ArrayList<>();
        String sql = "select [id],[name]\n"
                + "            ,[image]\n"
                + "            ,[price]\n"
                + "            ,[title]\n"
                + "            ,[description]\n"
                + "            ,[catId]\n"
                + "            ,[sellId] from product order by id offset ? rows fetch next 4 rows only";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, amount);
        ResultSet rs = statement.executeQuery();

        while (rs.next()) {
            int id = rs.getInt(1);
            String name = rs.getString(2);
            String image = rs.getString(3);
            double price = rs.getDouble(4);
            String title = rs.getString(5);
            String descritption = rs.getString(6);

            list.add(new Product(id, name, image, price, title, descritption));
        }
        return list;
    }

    // Chuyển sang trang thì hiện 12 sản phẩm khác theo tất cả sản phẩm
    public ArrayList<Product> pagingAllProduct(String from, String to, int index) throws SQLException {
        ArrayList<Product> list = new ArrayList<>();
        String sql = "select	[id],\n"
                + "		[name],\n"
                + "		[image]\n"
                + "       ,[price]\n"
                + "       ,[title]\n"
                + "		,[description]\n"
                + "       ,[catId]\n"
                + "       ,[sellId] from product\n"
                + "	   where price BETWEEN ? AND ? order by id offset ? rows fetch next 12 rows only";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, from);
        statement.setString(2, to);
        statement.setInt(3, (index - 1) * 12);
        ResultSet rs = statement.executeQuery();

        while (rs.next()) {
            int id = rs.getInt(1);
            String name = rs.getString(2);
            String image = rs.getString(3);
            double price = rs.getDouble(4);
            String title = rs.getString(5);
            String descritption = rs.getString(6);

            list.add(new Product(id, name, image, price, title, descritption));
        }
        return list;
    }

    // Chuyển sang trang thì HIỆN 12 sản phẩm khác theo category id và search
    public ArrayList<Product> pagingProductByCidAndTxt(String from, String to, int index, String cateId, String txtSearch) throws SQLException {
        ArrayList<Product> list = new ArrayList<>();
        String sql = "SELECT [id],[name],[image],[price],[title],[description],[catId],[sellId] \n"
                + "FROM product\n"
                + "WHERE [catId] = ? and name LIKE ? and price BETWEEN ? AND ?\n"
                + "ORDER BY id\n"
                + "OFFSET ? ROWS\n"
                + "FETCH NEXT 12 ROWS ONLY;";
        PreparedStatement statement = connection.prepareStatement(sql);

        statement.setString(1, cateId);
        statement.setString(2, "%" + txtSearch + "%");
        statement.setString(3, from);
        statement.setString(4, to);
        statement.setInt(5, (index - 1) * 12);
        ResultSet rs = statement.executeQuery();

        while (rs.next()) {
            int id = rs.getInt(1);
            String name = rs.getString(2);
            String image = rs.getString(3);
            double price = rs.getDouble(4);
            String title = rs.getString(5);
            String descritption = rs.getString(6);

            list.add(new Product(id, name, image, price, title, descritption));
        }
        return list;
    }

    // Chuyển sang trang thì HIÊN 12 sản phẩm khác theo category id
    public ArrayList<Product> pagingProductByCid(String from, String to, int index, String cateId) throws SQLException {
        ArrayList<Product> list = new ArrayList<>();
        String sql = "SELECT [id],[name],[image],[price],[title],[description],[catId],[sellId] \n"
                + "FROM product\n"
                + "WHERE [catId] = ? and price BETWEEN ? AND ?\n"
                + "ORDER BY id\n"
                + "OFFSET ? ROWS\n"
                + "FETCH NEXT 12 ROWS ONLY;";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, cateId);
        statement.setString(2, from);
        statement.setString(3, to);
        statement.setInt(4, (index - 1) * 12);
        ResultSet rs = statement.executeQuery();

        while (rs.next()) {
            int id = rs.getInt(1);
            String name = rs.getString(2);
            String image = rs.getString(3);
            double price = rs.getDouble(4);
            String title = rs.getString(5);
            String descritption = rs.getString(6);

            list.add(new Product(id, name, image, price, title, descritption));
        }
        return list;
    }

    // Chuyển sang trang thì HIÊN 12 sản phẩm khác theo search
    public ArrayList<Product> pagingProductByTxt(String from, String to, int index, String txtSearch) throws SQLException {
        ArrayList<Product> list = new ArrayList<>();
        String sql = "SELECT [id],[name],[image],[price],[title],[description],[catId],[sellId] \n"
                + "FROM product\n"
                + "WHERE  name LIKE ? and price BETWEEN ? AND ?\n"
                + "ORDER BY id\n"
                + "OFFSET ? ROWS\n"
                + "FETCH NEXT 12 ROWS ONLY";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, "%" + txtSearch + "%");
        statement.setString(2, from);
        statement.setString(3, to);
        statement.setInt(4, (index - 1) * 12);
        ResultSet rs = statement.executeQuery();

        while (rs.next()) {
            int id = rs.getInt(1);
            String name = rs.getString(2);
            String image = rs.getString(3);
            double price = rs.getDouble(4);
            String title = rs.getString(5);
            String descritption = rs.getString(6);

            list.add(new Product(id, name, image, price, title, descritption));
        }
        return list;
    }

    //========== PHÂN TRANG THEO QUẢN LÍ SẢN PHẨM VÀ QUẢN LÝ TÀI KHOẢN============
    // Chuyển sang trang thì hiện 5 sản phẩm khác theo tất cả sản phẩm
    public ArrayList<Product> Mnpaging5Product(int sellID, int index) throws SQLException {
        ArrayList<Product> list = new ArrayList<>();
        String sql = "   select [id],[name]\n"
                + "            ,[image]\n"
                + "            ,[price]\n"
                + "            ,[title]\n"
                + "            ,[description]\n"
                + "            ,[catId]\n"
                + "            ,[sellId] from product p\n"
                + "			where p.sellId = ?\n"
                + "			order by id offset ? rows fetch next 5 rows only";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, sellID);
        statement.setInt(2, (index - 1) * 5);
        ResultSet rs = statement.executeQuery();

        while (rs.next()) {
            int id = rs.getInt(1);
            String name = rs.getString(2);
            String image = rs.getString(3);
            double price = rs.getDouble(4);
            String title = rs.getString(5);
            String descritption = rs.getString(6);

            list.add(new Product(id, name, image, price, title, descritption));
        }
        return list;
    }

    // Chuyển sang trang thì hiện 5 sản phẩm khác theo tất cả sản phẩm
    public ArrayList<Customer> Mnpaging10Account(int index) throws SQLException {
        ArrayList<Customer> list = new ArrayList<>();
        String sql = "   select * from account p\n"
                + "			order by uid offset ? rows fetch next 10 rows only";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, (index - 1) * 10);
        ResultSet rs = statement.executeQuery();

        while (rs.next()) {
            int u_id = rs.getInt(1);
            String u_name = rs.getString(2);
            String pass = rs.getString(3);
            String email = rs.getString(4);
            double amount = rs.getDouble(5);
            String code = rs.getString(6);
            int is_sell = rs.getInt(7);
            int is_admin = rs.getInt(8);
            
            list.add(new Customer(u_id, u_name, amount, pass, email, is_sell, is_admin, code));
        }
        return list;
    }

    //========= LOG IN =============
    //Login, kiểm tra xem tài khoản đã được tạo hay chưa để đăng nhập (Lấy tài khoản này ra)
    public Customer login(String email, String pass) throws SQLException {
        String sql = "select * from account where email = ? and [password] = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, email);
        statement.setString(2, pass);
        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
            int id = rs.getInt(1);
            String username = rs.getString(2);
            String password = rs.getString(3);
            String emails = rs.getString(4);
            Double amount = rs.getDouble(5);
        String code = rs.getString(6);
            int isSellId = rs.getInt(7);
            int isAdmin = rs.getInt(8);
            
            return new Customer(id, username, amount, pass, email, isSellId, isAdmin, code);
        }
        return null;
    }

    //Kiểm tra xem tài khoản có tồn tại với email này hay không
    public Customer checkAcountExist(String email) throws SQLException {
        String sql = "select * from account where email = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, email);
        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
            int id = rs.getInt(1);
            String username = rs.getString(2);
            String password = rs.getString(3);
            String emails = rs.getString(4);
            Double amount = rs.getDouble(5);

            int isSellId = rs.getInt(6);
            int isAdmin = rs.getInt(7);
            String code = rs.getString(8);
            return new Customer(id, username, amount, password, email, isSellId, isAdmin, code);
        }
        return null;
    }

    //============== COUNT ==============
    //Đếm số lượng sản phẩm trong database
    public int getTotalProduct() throws SQLException {
        String sql = "select count (*) from product";
        PreparedStatement statement = connection.prepareStatement(sql);
        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
            return rs.getInt(1);
        }

        return 0;
    }

    //Đếm  sản phẩm theo cid và txt trong database
    public int getTotalProductByCidAndTxt(String cateId, String txtSearch, double from, double to) throws SQLException {
        String sql = "select count (*) from product\n"
                + "where [catId] = ? and [name] like ? and price between ? and ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, cateId);
        statement.setString(2, "%" + txtSearch + "%");
        statement.setDouble(3, from);
        statement.setDouble(4, to);
        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
            return rs.getInt(1);
        }

        return 0;
    }

    //Đếm  sản phẩm theo cid và txt trong database
    public int getTotalProductByCid(String cateId, double from, double to) throws SQLException {
        String sql = "select count (*) from product\n"
                + "where [catId] = ? and price between ? and ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, cateId);
        statement.setDouble(2, from);
        statement.setDouble(3, to);
        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
            return rs.getInt(1);
        }

        return 0;
    }

    //Đếm  sản phẩm theo cid và txt trong database
    public int getTotalProductByTxt(String txtSearch, double from, double to) throws SQLException {
        String sql = "select count (*) from product\n"
                + "where [name] like ? and price between ? and ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, "%" + txtSearch + "%");
        statement.setDouble(2, from);
        statement.setDouble(3, to);
        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
            return rs.getInt(1);
        }

        return 0;
    }

    //Đếm số lượng sản phẩm trong database
    public int getTotalProductBySellId(int sellId) throws SQLException {
        String sql = "select count (*) from product where sellId = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, sellId);

        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
            return rs.getInt(1);
        }

        return 0;
    }

    //Đếm số lượng sản phẩm trong database
    public int getTotalProductByPrice(double from, double to) throws SQLException {
        String sql = "select count (*) from product where price between ? and ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setDouble(1, from);
        statement.setDouble(2, to);
        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
            return rs.getInt(1);
        }

        return 0;
    }

    //Đếm số lượng sản phẩm trong database
    public int getTotalAccount() throws SQLException {
        String sql = "select count (*) from account";
        PreparedStatement statement = connection.prepareStatement(sql);

        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
            return rs.getInt(1);
        }

        return 0;
    }

    //=========== UPDATE =============
    //đăng kí thành công và add tài khoản vào database
    public void signUp(String user, String email, String pass, String issell, String isAdmin, String code, double amount) throws SQLException {
        String sql = "insert into account values (?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, user);
        statement.setString(2, pass);
        statement.setString(3, email);
        statement.setDouble(4, amount);
        statement.setString(5, issell);
        statement.setString(6, isAdmin);
        statement.setString(7, code);

        statement.executeUpdate();
    }

    //Chèn đánh giá sản phẩm vào db
    public void insertReview(String name, String email, int rating, Date date, String rvtext, int pid, int accid) throws SQLException {
        String sql = "insert into reviews values (?, ?, ?, ?, ?,?,?)";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, pid);
        statement.setString(2, name);
        statement.setString(3, email);
        statement.setInt(4, rating);
        statement.setString(5, rvtext);
        statement.setDate(6, date);
        statement.setInt(7, accid);

        statement.executeUpdate();
    }

    //xóa sản phẩm theo id
    public void deleteById(String id) throws SQLException {
        String sql = "delete from product where id = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, id);

        statement.executeUpdate();
    }

    //xóa tài khoản theo id
    public void deleteAccountById(String id) throws SQLException {
        String sql = "delete from account where uid = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, id);

        statement.executeUpdate();
    }

    //add một sản phẩm vào database
    public void insertProduct(String name, String image1, String image2, String image3, String image4, String price, String title, String description, String cid, int sId) throws SQLException {
        String sql = "insert into product values(?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, name);
        statement.setString(2, image1);
        statement.setString(3, image2);
        statement.setString(4, image3);
        statement.setString(5, image4);
        statement.setString(6, price);
        statement.setString(7, title);
        statement.setString(8, description);
        statement.setString(9, cid);
        statement.setInt(10, sId);

        statement.executeUpdate();
    }

    //update sản phẩm theo id
    public void updateProduct(String name, String image1, String image2, String image3, String image4, String price, String title, String description, String cid, String pId) throws SQLException {
        String sql = "update product \n"
                + "	  set \n"
                + "      [name] = ?\n"
                + "      ,[image] = ?\n"
                + "      ,[image1] = ?\n"
                + "      ,[image2] = ?\n"
                + "      ,[image3] = ?\n"
                + "      ,[price] = ?\n"
                + "      ,[title] = ?\n"
                + "      ,[description] = ?\n"
                + "      ,[catId] = ?\n"
                + "   where product.id = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, name);
        statement.setString(2, image1);
        statement.setString(3, image2);
        statement.setString(4, image3);
        statement.setString(5, image4);

        statement.setString(6, price);
        statement.setString(7, title);
        statement.setString(8, description);
        statement.setString(9, cid);
        statement.setString(10, pId);

        statement.executeUpdate();
    }

    // Lấy lại mật khẩu
    public void updatePassWord(String email, String pass) throws SQLException {
        String sql = "update account\n"
                + "set [password] = ?\n"
                + "where account.email = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, pass);
        statement.setString(2, email);

        statement.executeUpdate();
    }

    //update sản phẩm theo id
    public void updateAccount(Customer cs) throws SQLException {
        String sql = "update account \n"
                + "set [user] = ?,\n"
                + "	[password] = ?,\n"
                + "	[email] = ?,\n"
                + "	[isSellId] = ?,\n"
                + "	[isAdmin] = ?\n"
                + "where account.[uid] = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, cs.getUserName());
        statement.setString(2, cs.getPass());
        statement.setString(3, cs.getEmail());
        statement.setInt(4, cs.getIsSellId());
        statement.setInt(5, cs.getIsadmin());
        statement.setInt(6, cs.getId());
        statement.executeUpdate();
    }

    //============== INSERT ============
    public void addOderLine(int oid, int pid, int quantity, double price) throws SQLException {
        String sql = "insert into orderDetail\n"
                + "values(?,?,?,?)";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, oid);
        statement.setInt(2, pid);
        statement.setInt(3, quantity);
        statement.setDouble(4, price);

        statement.executeUpdate();

    }

    public int addOder(Order o) throws SQLException {
        String sql = "insert into [order]\n"
                + "values(?,?,?,?,?,?,?)";
        PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        statement.setString(1, o.getFirstName());
        statement.setString(2, o.getLastName());
        statement.setString(3, o.getAddress());
        statement.setString(4, o.getPhone());
        statement.setDate(5, o.getDate());

        statement.setDouble(6, o.getToalmoney());
        statement.setInt(7, o.getCid());
        statement.executeUpdate();

        try (ResultSet resultSet = statement.getGeneratedKeys()) {
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
            resultSet.close();
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
        return 0;

    }

    public void AddCodeToSignu(int oid, int pid, int quantity, double price) throws SQLException {
        String sql = "insert into orderDetail\n"
                + "values(?,?,?,?)";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, oid);
        statement.setInt(2, pid);
        statement.setInt(3, quantity);
        statement.setDouble(4, price);

        statement.executeUpdate();

    }

}
