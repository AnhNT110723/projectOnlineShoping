<%-- 
    Document   : store
    Created on : Feb 20, 2024, 12:40:31 AM
    Author     : Anh hung
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

        <title>Store</title>

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
        <!--Start of Fchat.vn--><script type="text/javascript" src="https://cdn.fchat.vn/assets/embed/webchat.js?id=65eefd87d712f32d1375b79a" async="async"></script><!--End of Fchat.vn-->
        <style>
            .filter-button {
                background-color: red;
                color: #fff;
                border: 2px solid black;
                padding: 5px 78px;
                cursor: pointer;
                border: 3px solid black;
                border-radius: 15px; 
                margin-top: 10px;
                transition: background-color 0.3s, color 0.3s, border-color 0.3s; /* Animation khi hover */
            }

            .filter-button:hover {
                background-color: transparent;
                color: red; 
                border-color: red; /* Màu của border khi hover */
                
            }

        </style>
    </head>
    <body>
        <!-- HEADER -->
        <jsp:include page="menu.jsp"></jsp:include>
            <!-- /HEADER -->




            <!-- SECTION -->
            <div class="section">
                <!-- container -->
                <div class="container">
                    <!-- row -->
                    <div class="row">
                        <!-- ASIDE -->
                        <div id="aside" class="col-md-3">
                            <!-- aside Widget -->

                            <!-- aside Widget -->
                            <form action="store" method="get">
                                <div class="aside">
                                    <input type="hidden" value="${cid}" name="cid">
                                    <h3 class="aside-title">Price</h3>
                                    <div class="price-filter">
                                        <div id="price-slider"></div>
                                        <div class="input-number price-min">
                                            <input id="price-min" type="number" name="from" value="${from}">
                                            <span class="qty-up">+</span>
                                            <span class="qty-down">-</span>
                                        </div>
                                        <span>-</span>
                                        <div class="input-number price-max">
                                            <input id="price-max" type="number" name="to" value="${to}">
                                            <span class="qty-up">+</span>
                                            <span class="qty-down">-</span>
                                        </div>
                                    </div>
                                    
                                    <input type="submit" value="Filter product" class="filter-button">
                                </div>
                            </form>
                            <!-- /aside Widget -->

                            <!-- aside Widget -->
                            <div class="aside">
                                <h3 class="aside-title">Brand</h3>
                                <div class="checkbox-filter">
                                <c:forEach items="${listb}" var="o">
                                    <div class="input-checkbox">
                                        <input type="checkbox" id="brand-1">
                                        <label for="brand-1">
                                            <span></span>
                                            ${o.getBname()}
                                            <small>(578)</small>
                                        </label>
                                    </div> 
                                </c:forEach>
                            </div>
                        </div>
                        <!-- /aside Widget -->


                        <!-- aside Widget -->
                        <div class="aside">
                            <h3 class="aside-title">Top selling</h3>
                            <div class="product-widget">
                                <div class="product-img">
                                    <img src="./img/product01.png" alt="">
                                </div>
                                <div class="product-body">
                                    <p class="product-category">Category</p>
                                    <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                    <h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
                                </div>
                            </div>

                            <div class="product-widget">
                                <div class="product-img">
                                    <img src="./img/product02.png" alt="">
                                </div>
                                <div class="product-body">
                                    <p class="product-category">Category</p>
                                    <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                    <h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
                                </div>
                            </div>

                            <div class="product-widget">
                                <div class="product-img">
                                    <img src="./img/product03.png" alt="">
                                </div>
                                <div class="product-body">
                                    <p class="product-category">Category</p>
                                    <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                    <h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
                                </div>
                            </div>
                        </div>
                        <!-- /aside Widget -->
                    </div>
                    <!-- /ASIDE -->

                    <!-- STORE -->
                    <div id="store" class="col-md-9">
                        <!-- store top filter -->
                        <div class="store-filter clearfix">
                            <div class="store-sort">
                                <label>
                                    Sort By:
                                    <select class="input-select">
                                        <option value="0">PRICE DECREASE</option>
                                        <option value="1">PRICE INCREASE</option>
                                    </select>
                                </label>

                                <label>
                                    Show:
                                    <select class="input-select">
                                        <option value="0">12</option>
                                    </select>
                                </label>
                            </div>
                            <!-- store bottom filter -->

                            <ul class="store-pagination">
                                <c:forEach begin="1" end="${endP}" var="i">
                                    <li class="${tag == i ? "active" : ""}"><a href="store?index=${i}&cid=${cid}&txt=${text}&from=${from}&to=${to}">${i}</a></li>
                                    </c:forEach>
                                    <c:if test="${tag < endP}">
                                    <li><a href="store?index=${tag+1}&cid=${cid}&txt=${text}&from=${from}&to=${to}"><i class="fa fa-angle-right"></i></a></li>
                                        </c:if>
                            </ul>

                        </div>
                        <!-- /store top filter -->


                        <!-- Products tab & slick -->
                        <div class="listProduct">
                            <div class="rr">

                                <!-- product -->
                                <%
                                        ArrayList<Product> ListAll = (ArrayList<Product>) request.getAttribute("ListP");

                                        if (ListAll != null) {
                                            for (Product o : ListAll) {
                                %>  
                                <div style="width: 30%"  class="product col-sm-3">
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
                                        <button class="add-to-cart-btn"><i class="fa fa-shopping-bag"></i><a href="order?pid=<%=o.getId()%>" class="text-white">Mua Ngay</a></button>
                                    </div>
                                </div>

                                <!-- /product -->


                                <%
                                             }
                                         }
                                %>

                            </div>
                            <!-- /row -->
                        </div>
                        <!-- /container -->

                        <!-- /SECTION -->


                        <!-- store bottom filter -->
                        <div class="store-filter clearfix">

                            <ul class="store-pagination">
                                <c:forEach begin="1" end="${endP}" var="i">
                                    <li class="${tag == i ? "active" : ""}"><a href="store?index=${i}&cid=${cid}&txt=${text}">${i}</a></li>
                                    </c:forEach>
                                    <c:if test="${tag < endP}">
                                    <li><a href="store?index=${tag+1}&cid=${cid}&txt=${text}"><i class="fa fa-angle-right"></i></a></li>
                                        </c:if>
                            </ul>
                        </div>
                        <!-- /store bottom filter -->
                    </div>
                    <!-- /STORE -->
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
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
        <!-- /NEWSLETTER -->

        <!-- FOOTER -->
        <jsp:include page="footer.jsp"></jsp:include>

        <!-- /FOOTER -->

        <!-- jQuery Plugins -->
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/slick.min.js"></script>
        <script src="js/nouislider.min.js"></script>
        <script src="js/jquery.zoom.min.js"></script>
        <script src="js/main.js"></script>

    </body>
</html>
