<%-- 
    Document   : menu
    Created on : Feb 10, 2024, 2:35:44 PM
    Author     : Anh hung
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.util.ArrayList"%>
<%@page import = "model.Category"%>
<%@page import = "model.Product"%>
<%@page import = "model.Customer"%>


<!-- HEADER -->
<header>
    <!-- TOP HEADER -->
    <div id="top-header">
        <div class="container">
            <ul class="header-links pull-left">
                <li>
                    <p>
                        <i class="fa fa-phone"></i> 
                        <span style="color: #fff;">+84-869.620.295</span>
                    </p>
                </li>

                <li>
                    <p><i class="fa fa-envelope-o"></i> <span style="color: #fff;">tuananhhy2003@email.com</span></p>
                </li>
                <li><a href="https://www.google.com/maps/place/FPT+University/@21.0129038,105.5237586,18z/data=!4m10!1m2!2m1!1zRlBUIFVuaXZlcnNpdHkgSMOyYSBM4bqhYw!3m6!1s0x3135abc60e7d3f19:0x2be9d7d0b5abcbf4!8m2!3d21.0124167!4d105.5252892!15sChlGUFQgVW5pdmVyc2l0eSBIw7JhIEzhuqFjWhsiGWZwdCB1bml2ZXJzaXR5IGjDsmEgbOG6oWOSAQp1bml2ZXJzaXR54AEA!16s%2Fm%2F02rsytm?entry=ttu"><i class="fa fa-map-marker"></i> ĐH FPT Hà Nội</a></li>
            </ul>
            <ul class="header-links pull-right">

                <%
                    if(session.getAttribute("acc") == null) {
                %>

                <li><a href="login"><i class="fa fa-sign-in"></i>Log-in</a></li>
                    <%}%>
                    <%
                        if(session.getAttribute("acc") != null) {
                    %>
                <li><a href="editProfile"><i class="fa fa-hand-wave"></i><i class="fa fa-user-circle"></i> Hello ${sessionScope.acc.userName}</a></li>
                <li><a href="logout"><i class="fa fa-sign-out"></i> Log-out</a></li>
                    <%}%>

            </ul>
        </div>
    </div>
    <!-- /TOP HEADER -->

    <!-- MAIN HEADER -->
    <div id="header">
        <!-- container -->
        <div class="container">
            <!-- row -->
            <div class="row">
                <!-- LOGO -->
                <div class="col-md-3">
                    <div class="header-logo">
                        <a href="#" class="logo">
                            <img src="./img/logo.png" alt="">
                        </a>
                    </div>
                </div>
                <!-- /LOGO -->

                <!-- SEARCH BAR -->
                <div class="col-md-6">
                    <div class="header-search">

                        <form action="store" method="post">
                            <select class="input-select" name="cid">
                                <option value="all">All Categories</option>
                                <%
                                    ArrayList<Category> listC = (ArrayList<Category>) request.getAttribute("ListC");
                                    String cid = (String)request.getAttribute("cid");
                                    int cidInt = 0; // Giá trị mặc định nếu không thể chuyển đổi
                                    if (cid != null && cid.matches("\\d+")) {
                                        cidInt = Integer.parseInt(cid);
                                    }
                                    if (listC != null) {
                                        for (Category o : listC) {
                                %>         
                                <option value="<%=o.getCid()%>" <%=cidInt == o.getCid() ? "selected" : ""%>><%=o.getCname()%></option>
                                <%
                                        }
                                    }
                                %>
                            </select>

                            <!--search-->
                            <input class="input" placeholder="Search here" name="txt" value="${text}">
                            <button class="search-btn">Search</button>
                        </form>
                    </div>
                </div>
                <!-- /SEARCH BAR -->

                <!-- ACCOUNT -->
                <div class="col-md-3 clearfix">
                    <div class="header-ctn">
                        <!-- Wishlist -->
                        <div>
                            <a href="show">
                                <i class="fa fa-heart-o"></i>
                                <span>Your Wishlist</span>
                                <div class="qty">2</div>
                            </a>
                        </div>
                        <!-- /Wishlist -->

                        <!-- Cart -->
                        <div >
                            <a href="show">
                                <i class="fa fa-shopping-cart"></i>
                                <span>Your Cart</span>
                                <div class="qty">${amount}</div>
                            </a>

                        </div>
                        <!-- /Cart -->

                        <!-- Menu Toogle -->
                        <div class="menu-toggle">
                            <a href="#">
                                <i class="fa fa-bars"></i>
                                <span>Menu</span>
                            </a>
                        </div>
                        <!-- /Menu Toogle -->
                    </div>
                </div>
                <!-- /ACCOUNT -->
            </div>
            <!-- row -->
        </div>
        <!-- container -->
    </div>
    <!-- /MAIN HEADER -->
</header>
<!-- /HEADER -->

<!-- NAVIGATION -->
<nav id="navigation">
    <!-- container -->
    <div class="container">
        <!-- responsive-nav -->
        <div id="responsive-nav">
            <!-- NAV -->

            <ul class="main-nav nav navbar-nav">
                <li class=${cid==null ? "active" : ""}><a href="home">Home</a></li>
                    <%
                        //nếu trên session có tài khoản tồn tại
                       if(session.getAttribute("acc") != null) {
                            Customer a = (Customer) session.getAttribute("acc");
                            if(a.getIsadmin() == 1){ 
                    
                    %>
                <li><a href="ManagerAccount">Manager Account</a></li>
                    <%}%>
                    <%
                        if(a.getIsSellId() == 1){
                    %>
                <li><a href="managerProduct">Manager Product</a></li>
                    <%     }
                    }%>
                <li class=${cid == '1' ? "active" : ""}><a href="store?cid=1">Laptops</a></li>
                <li class=${cid == '2' ? "active" : ""}><a href="store?cid=2">Smartphones</a></li>
                <li class=${cid == '3' ? "active" : ""}><a href="store?cid=3">Cameras</a></li>
                <li class=${cid == '4' ? "active" : ""}><a href="store?cid=4">Accessories</a></li>
            </ul>
            <!-- /NAV -->
        </div>
        <!-- /responsive-nav -->
    </div>
    <!-- /container -->
</nav>
<!-- /NAVIGATION -->

