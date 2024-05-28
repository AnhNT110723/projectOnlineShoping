<%-- 
    Document   : cart
    Created on : Feb 19, 2024, 11:56:43 PM
    Author     : Anh hung
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.util.ArrayList"%>
<%@page import = "model.Category"%>
<%@page import = "model.Product"%>
<%@page import = "model.Customer"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart Page</title>
        <!-- Google font -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

        <!-- Bootstrap -->
        <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>

        <!-- Slick -->
        <link type="text/css" rel="stylesheet" href="css/slick.css"/>
        <link type="text/css" rel="stylesheet" href="css/slick-theme.css"/>

        <!-- nouislider -->
        <link type="text/css" rel="stylesheet" href="css/nouislider.min.css"/>

        <!-- Font Awesome Icon -->
        <link rel="stylesheet" href="css/font-awesome.min.css">

        <!-- Custom stlylesheet -->
        <link type="text/css" rel="stylesheet" href="css/style.css"/>

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
        <style>
            .img-cart {
                display: block;
                max-width: 50px;
                height: auto;
                margin-left: auto;
                margin-right: auto;
            }
            table tr td{
                border:1px solid #FFFFFF;
            }

            table tr th {
                background:#eee;
            }

            .panel-shadow {
                box-shadow: rgba(0, 0, 0, 0.3) 7px 7px 7px;
            }



        </style>
                <!--Start of Fchat.vn--><script type="text/javascript" src="https://cdn.fchat.vn/assets/embed/webchat.js?id=65eefd87d712f32d1375b79a" async="async"></script><!--End of Fchat.vn-->
    </head>

    <body>
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

                        <li><a href="Login.jsp"><i class="fa fa-sign-in"></i>Log-in</a></li>
                            <%}%>
                            <%
                                if(session.getAttribute("acc") != null) {
                            %>
                        <li><a href="#"><i class="fa fa-hand-wave"></i><i class="fa fa-user-circle"></i> Hello ${sessionScope.acc.userName}</a></li>
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
                                    <a href="#">
                                        <i class="fa fa-heart-o"></i>
                                        <span>Your Wishlist</span>
                                        <div class="qty">2</div>
                                    </a>
                                </div>
                                <!-- /Wishlist -->

                                <!-- Cart -->
                                <div class="dropdown">
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


                    <!-- /NAV -->
                </div>
                <!-- /responsive-nav -->
            </div>
            <!-- /container -->
        </nav>
        <!-- /NAVIGATION -->
        <link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css">
        <div class="container bootstrap snippets bootdey "  style="margin-right: -200px; width: 100%;">
            <div class="col-md-9 col-sm-8 content">
                <div class="row">
                    <div class="col-md-12">
                        <ol style="margin-top: 1px" class="breadcrumb">
                            <li><a href="home">Home</a></li>
                            <li class="active">Cart</li>
                        </ol>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">

                        <form action="order" method="POST">

                            <div class="panel panel-info panel-shadow">

                                <div class="panel-body"> 
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th>Product</th>
                                                    <th>Name</th>
                                                    <th>Qty</th>
                                                    <th>Price</th>
                                                    <th>Total</th>
                                                </tr>
                                            </thead>
                                            <thead>
                                                <!-- Tiêu đề các cột -->
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${list}" var="p">
                                                    <tr>
                                                        <td><img src="${p.getImage()}" class="img-cart"></td>
                                                        <td>
                                                            <strong>${p.getName()}</strong>

                                                        </td>
                                                        <td>
                                                            <c:if test="${p.getId() != null}">
                                                                <!--- SẢN PHẨM-->
                                                                <a style="text-decoration: none;
                                                                   color: chocolate;
                                                                   font-size: 22px;
                                                                   font-weight: bold;
                                                                   margin: 0 10px" href="process?num=-1&id=${p.getId()}">-</a>




                                                                <input style="    display: inline-block;
                                                                       width: 50px;
                                                                       height: 34px;
                                                                       padding: 6px 12px;
                                                                       font-size: 14px;
                                                                       line-height: 1.42857143;
                                                                       color: #555;
                                                                       background-color: #fff;
                                                                       text-align: center;
                                                                       background-image: none;
                                                                       border: 1px solid #ccc;
                                                                       border-radius: 4px;" type="text" value="${p.getAmount()}">


                                                                <!--+ SẢN PHẨM-->
                                                                <a style="text-decoration: none;
                                                                   color: chocolate;
                                                                   font-size: 22px;
                                                                   font-weight: bold;
                                                                   margin: 0 10px" href="process?num=1&id=${p.getId()}">+</a>


                                                                <!--DELETE-->
                                                                <a style="margin-left: 50px" href="process?pid=${p.getId()}" class="btn btn-primary"><i class="fa fa-trash-o"></i></a>

                                                            </td>

                                                            <td>$ ${p.getPrice()}</td>
                                                            <td>$ ${p.getPrice()*p.getAmount()}</td>
                                                        </tr>
                                                    </c:if>
                                                </c:forEach>
                                            </tbody>


                                            <tr>
                                                <td colspan="6">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" class="text-right">Total Product</td>
                                                <td>${amount}</td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" class="text-right">Total Shipping</td>
                                                <td>$2.00</td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" class="text-right"><strong>Total</strong></td>
                                                <td>$ ${sum}</td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <input class="btn btn-primary pull-right" type="submit"  name="name" value="Check out">
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp"></jsp:include>

    </body>
</html>
