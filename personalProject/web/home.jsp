<%-- 
    Document   : home
    Created on : Feb 5, 2024, 10:07:37 AM
    Author     : Anh hung
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.util.ArrayList"%>
<%@page import = "model.Category"%>
<%@page import = "model.Product"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>ANH NT WEB</title>

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

            .load-more {
                margin-top: 30px;
                margin-left: 110px;
                background-color: #ff0000; /* Màu đỏ */
                color: #ffffff; /* Màu chữ trắng */
                padding: 10px 20px; /* Kích thước lề */
                border: none; /* Không có viền */
                border-radius: 5px; /* Bo tròn góc */
                cursor: pointer; /* Con trỏ biểu tượng tay */
                font-size: 18px; /* Cỡ chữ lớn hơn */
                font-weight: bold; /* Chữ in đậm */
            }

            .load-more:hover {
                background-color: #cc0000; /* Màu đỏ nhạt khi di chuột vào */
            }


            @keyframes blink {
                0% {
                    color: #2B2D42;
                }
                50% {
                    color: #FFFFFF;
                }
                100% {
                    color: #2B2D42;
                }
            }

            .blink-text {
                animation: blink 10s infinite;
            }

            /* Định nghĩa keyframes cho hiệu ứng nhấp nháy */
            @keyframes rainbow {


                0% {
                    color: orange;
                }
                50% {
                    color: red;
                }
                100% {
                    color: black;
                }

            }

            /* Áp dụng hiệu ứng cho tiêu đề */
            .title {
                animation: rainbow 5s infinite; /* Sử dụng hiệu ứng 'rainbow' trong 5 giây và lặp vô hạn */
            }

        </style>
        <!--Start of Fchat.vn-->
        <script type="text/javascript" src="https://cdn.fchat.vn/assets/embed/webchat.js?id=6642d5817e8080519367b502" async="async"></script>
        <!--End of Fchat.vn-->


        <!-- Hoa đào rơi -->
        <!--<script type="text/javascript" src="https://webquangnam.com/jsShare/hoa-dao-roi.js"></script>-->
        <!-- Hoa mai rơi -->	
        <!--<script type="text/javascript" src="https://webquangnam.com/jsShare/hoa-mai-roi.js"></script>-->
        <!-- Tuyết rơi (nhỏ) -->
        <script type="text/javascript" src="https://web.nvnstatic.net/js/events/snow.js"></script>
        <!--Tuyết rơi (Lớn)-->
        <!--<script type="text/javascript" src="https://web.nvnstatic.net/js/events/snow2.js"></script>-->
    </head>
    <body>

        <jsp:include page="menu.jsp"></jsp:include>

            <!-- SECTION -->
            <div class="section">
                <!-- container -->
                <div class="container">
                    <!-- row -->
                    <div class="row">
                        <!-- shop -->
                        <div class="col-md-4 col-xs-6">
                            <div class="shop">
                                <div class="shop-img">
                                    <img src="./img/shop01.png" alt="">
                                </div>
                                <div class="shop-body">
                                    <h3>Laptop<br>Collection</h3>
                                    <a href="store?cid=1" class="cta-btn">Shop now <i class="fa fa-arrow-circle-right"></i></a>
                                </div>
                            </div>
                        </div>
                        <!-- /shop -->

                        <!-- shop -->
                        <div class="col-md-4 col-xs-6">
                            <div class="shop">
                                <div class="shop-img">
                                    <img src="./img/shop03.png" alt="">
                                </div>
                                <div class="shop-body">
                                    <h3>Accessories<br>Collection</h3>
                                    <a href="store?cid=3" class="cta-btn">Shop now <i class="fa fa-arrow-circle-right"></i></a>
                                </div>
                            </div>
                        </div>
                        <!-- /shop -->

                        <!-- shop -->
                        <div class="col-md-4 col-xs-6">
                            <div class="shop">
                                <div class="shop-img">
                                    <img src="./img/shop02.png" alt="">
                                </div>
                                <div class="shop-body">
                                    <h3>Cameras<br>Collection</h3>
                                    <a href="store?cid=4" class="cta-btn">Shop now <i class="fa fa-arrow-circle-right"></i></a>
                                </div>
                            </div>
                        </div>
                        <!-- /shop -->
                    </div>
                    <!-- /row -->
                </div>
                <!-- /container -->
            </div>
            <!-- /SECTION -->

            <!-- SECTION -->
            <div class="section">
                <!-- container -->
                <div class="container">
                    <!-- row -->
                    <div class="row">

                        <!-- section title -->
                        <div class="col-md-12">
                            <div class="section-title">
                                <h3 class="title">New Products</h3>
                                <div class="section-nav">
                                    <ul class="section-tab-nav tab-nav">
                                        <li ><a style="cursor: pointer" onclick="load('1')">Laptops</a></li>
                                        <li><a style="cursor: pointer" onclick="load('2')">Smartphones</a></li>
                                        <li><a style="cursor: pointer" onclick="load('3')">Cameras</a></li>
                                        <li><a style="cursor: pointer" onclick="load('4')">Accessories</a></li>
                                    </ul>

                                </div>
                            </div>
                        </div>
                        <!-- /section title -->



                        <!-- Products tab & slick -->

                        <div   class="col-md-12">
                            <div class="row">


                                <div class="products-tabs">
                                    <!-- tab -->
                                    <div id="content1"  class="tab-pane active">
                                        <div  class="products-slick" data-nav="#slick-nav-1">

                                            <!-- product -->   
                                        <%
                                        ArrayList<Product> listNew = (ArrayList<Product>) request.getAttribute("listNew");

                                        if (listNew != null) {
                                            for (Product o : listNew) {
                                        %>         

                                        <div  class="product ">
                                            <div class="product-img">
                                                <img src="<%=o.getImage()%>" alt="">
                                                <div class="product-label">
                                                    <span class="sale">-30%</span>
                                                    <span class="new">NEW</span>
                                                </div>
                                            </div>
                                            <div class="product-body listProduct-body">

                                                <h3 class="product-name"><a href="detail?pid=<%=o.getId()%>"><%=o.getName()%></a></h3>
                                                <h4 class="product-price">$<%=o.getPrice()%><del class="product-old-price">$990.00</del></h4>
                                                <div class="product-rating" style="display: ruby">
                                                    <p class="product-category"><%=o.getTitle()%></p>
                                                </div>
                                                <div class="product-btns">
                                                    <button class="add-to-wishlist"><i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span></button>
                                                    <a href="cart?cid=<%=o.getId()%>" style="margin: 0 15px" class="add-to-compare"><i class="fa fa-shopping-cart"></i><span class="tooltipp"></span></a>
                                                    <button class="quick-view"><i class="fa fa-eye"></i><span class="tooltipp">quick view</span></button>
                                                </div>
                                            </div>
                                            <div class="add-to-cart">
                                                <button class="add-to-cart-btn"  onclick="redirectToPage('order?pid=<%=o.getId()%>')"><i class="fa fa-shopping-bag"></i>Mua Ngay</button>
                                            </div>
                                        </div>

                                        <!-- /product -->



                                        <%
                                                     }
                                                 }
                                        %>




                                    </div>
                                    <div id="slick-nav-1" class="products-slick-nav"></div>
                                </div>
                                <!-- /tab -->
                            </div>
                        </div>
                    </div>
                    <!-- Products tab & slick -->
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /SECTION -->





        <!-- HOT DEAL SECTION -->
        <div id="hot-deal" class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="hot-deal">
                            <ul class="hot-deal-countdown">
                                <li>
                                    <div>
                                        <h3>02</h3>
                                        <span>Days</span>
                                    </div>
                                </li>
                                <li>
                                    <div>
                                        <h3>10</h3>
                                        <span>Hours</span>
                                    </div>
                                </li>
                                <li>
                                    <div>
                                        <h3>34</h3>
                                        <span>Mins</span>
                                    </div>
                                </li>
                                <li>
                                    <div>
                                        <h3>60</h3>
                                        <span>Secs</span>
                                    </div>
                                </li>
                            </ul>
                            <h2 class="text-uppercase">hot deal this week</h2>
                            <p>New Collection Up to 50% OFF</p>
                            <a class="primary-btn cta-btn" href="#">Shop now</a>
                        </div>
                    </div>
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /HOT DEAL SECTION -->




        <!-- SECTION -->
        <div class="section">
            <!-- container -->
            <div class="c">

                <!-- row -->
                <div class="row">
                    <div class="container text-center">
                        <!-- section title -->
                        <div class="col-md-12">
                            <div class="section-title">
                                <h2 class="title">All Products</h2>
                                <br><!-- comment -->
                                <p class="blink-text">Laptops, Smartphones, Cameras, Accessories</p>


                            </div>
                        </div>
                    </div>
                    <!-- /section title -->

                    <!-- Products tab & slick -->
                    <div class="listProduct">
                        <div id="content" class="rr">

                            <!-- product -->
                            <%
                                    ArrayList<Product> ListAll = (ArrayList<Product>) request.getAttribute("ListAll");

                                    if (ListAll != null) {
                                        for (Product o : ListAll) {
                            %>  
                            <div class="amountt product col-sm-3">
                                <div class="product-img">
                                    <img src="<%=o.getImage()%>" alt="">
                                    <div class="product-label">
                                        <span class="sale">-30%</span>
                                        <span class="new">NEW</span>
                                    </div>
                                </div>
                                <div class="product-body listProduct-body new">

                                    <h3 class="product-name"><a href="detail?pid=<%=o.getId()%>"><%=o.getName()%></a></h3>
                                    <h4 class="product-price">$<%=o.getPrice()%><del class="product-old-price">$990.00</del></h4>
                                    <div class="product-rating" style=" display: ruby;">
                                        <p class="product-category"><%=o.getTitle()%></p>
                                    </div>
                                    <div class="product-btns">
                                        <button class="add-to-wishlist"><i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span></button>
                                        <a href="cart?cid=<%=o.getId()%>" style="margin: 0 15px" class="add-to-compare"><i class="fa fa-shopping-cart"></i><span class="tooltipp"></span></a>
                                        <button class="quick-view"><i class="fa fa-eye"></i><span class="tooltipp">quick view</span></button>
                                    </div>
                                </div>
                                <div class="add-to-cart">
                                    <button class="add-to-cart-btn"  onclick="redirectToPage('order?pid=<%=o.getId()%>')"><i class="fa fa-shopping-bag"></i>Mua Ngay</button>
                                </div>
                            </div>

                            <!-- /product -->


                            <%
                                         }
                                     }
                            %>


                        </div>
                        <button onclick="loadMore()" class="load-more">Load more</button>
                        <!-- /row -->
                    </div>
                    <!-- /container -->

                    <!-- /SECTION -->




                    <!-- /SECTION -->

                    <!-- NEWSLETTER -->
                    <div id="newsletter" class="section">
                        <!-- container -->
                        <div class="container">
                            <!-- row -->
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="newsletter">
                                        <p>Sign Up for the <strong>NEWSLETTER</strong></p>
                                        <form>
                                            <input class="input" type="email" placeholder="Enter Your Email">
                                            <button class="newsletter-btn"><i class="fa fa-envelope"></i> Subscribe</button>
                                        </form>
                                        <ul class="newsletter-follow">
                                            <li>
                                                <a href="#"><i class="fa fa-facebook"></i></a>
                                            </li>
                                            <li>
                                                <a href="#"><i class="fa fa-twitter"></i></a>
                                            </li>
                                            <li>
                                                <a href="#"><i class="fa fa-instagram"></i></a>
                                            </li>
                                            <li>
                                                <a href="#"><i class="fa fa-pinterest"></i></a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <!-- /row -->
                        </div>
                        <!-- /container -->
                    </div>
                </div>
            </div>
        </div>

        <!-- /NEWSLETTER -->
        <jsp:include page="footer.jsp"></jsp:include>


            <!-- jQuery Plugins -->
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
            <script src="js/jquery.min.js"></script>
            <script src="js/bootstrap.min.js"></script>
            <script src="js/slick.min.js"></script>
            <script src="js/nouislider.min.js"></script>
            <script src="js/jquery.zoom.min.js"></script>
            <script src="js/main.js"></script>

        <%
            String addedToCart = request.getParameter("addedToCart");
            if ("true".equals(addedToCart)) {
        %>
        <script>
                            alert("Sản phẩm đã được thêm vào giỏ hàng thành công!");
        </script>
        <%
            }
        %>

        <script>
            function redirectToPage(url) {
                window.location.href = url;
            }



            function load(cateid) {
                $.ajax({
                    url: "/personalProject/NewServlet",
                    type: "get",
                    data: {
                        cid: cateid
                    },
                    success: function (re) {
                        document.getElementById("content1").innerHTML = re;
                        // Thực hiện CSS cho các phần tử sau khi load
                        adjustLayout();
                    }
                });
            }

            function adjustLayout() {
                // Thực hiện CSS cho các phần tử sau khi load
                var productDivs = document.querySelectorAll('.product');
                productDivs.forEach(function (productDiv) {
                    productDiv.style.display = 'inline-block'; // hoặc thay đổi theo yêu cầu của bạn
                });
            }

            function loadMore() {
                var a = document.getElementsByClassName("amountt").length;
                $.ajax({
                    url: "/personalProject/load",
                    type: "get",
                    data: {
                        exits: a
                    },
                    success: function (data) {
                        var row = document.getElementById("content");
                        row.innerHTML += data;
                    }
                });
            }

        </script>
    </body>
</html>
