<%-- 
    Document   : detail
    Created on : Feb 10, 2024, 12:59:53 AM
    Author     : Anh hung
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.Product"%>
<%@page import = "model.Category"%>
<%@page import = "java.util.ArrayList"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>Electro - HTML Ecommerce Template</title>

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
    </head>
    <body>
        <jsp:include page="menu.jsp"></jsp:include>

            <!-- BREADCRUMB -->
            <div id="bread  crumb" class="section">
                <!-- container -->
                <div class="container">
                    <!-- row -->
                    <!--                    <div class="row">
                                            <div class="col-md-12">
                                                <ul class="breadcrumb-tree">
                                                    <li><a href="#">Home</a></li>
                                                    <li><a href="#">All Categories</a></li>
                                                    <li><a href="#">Accessories</a></li>
                                                    <li><a href="#">Headphones</a></li>
                                                    <li class="active">Product name goes here</li>
                                                </ul>
                                            </div>
                                        </div>-->
                    <!-- /row -->
                </div>
                <!-- /container -->
            </div>
            <!-- /BREADCRUMB -->

            <!-- SECTION -->
            <div class="section">
                <!-- container -->
                <div class="container">
                    <!-- row -->
                    <div class="row">
                        <!-- Product main img -->
                        <div class="col-md-5 col-md-push-2">
                            <div id="product-main-img">
                                <div class="product-preview">
                                    <img src="${detail.image}" alt="">
                            </div>

                            <div class="product-preview">
                                <img src="${detail.image2}" alt="">
                            </div>

                            <div class="product-preview">
                                <img src="${detail.image3}" alt="">
                            </div>

                            <div class="product-preview">
                                <img src="${detail.image4}" alt="">
                            </div>
                        </div>
                    </div>
                    <!-- /Product main img -->

                    <!-- Product thumb imgs -->
                    <div class="col-md-2  col-md-pull-5">
                        <div id="product-imgs">
                            <div class="product-preview">
                                <img src="${detail.image}" alt="">
                            </div>

                            <div class="product-preview">
                                <img src="${detail.image2}" alt="">
                            </div>

                            <div class="product-preview">
                                <img src="${detail.image3}" alt="">
                            </div>

                            <div class="product-preview">
                                <img src="${detail.image4}" alt="">
                            </div>
                        </div>
                    </div>
                    <!-- /Product thumb imgs -->

                    <!-- Product details -->
                    <div class="col-md-5">
                        <div class="product-details">
                            <h2 class="product-name">${detail.name}</h2>
                            <div>
                                <div class="product-rating">
                                    <c:forEach var="i" begin="1" end="${avg}">
                                        <i class="fa fa-star"></i>
                                    </c:forEach>
                                    <c:forEach var="i" begin="${avg + 1}" end="5">
                                        <i class="fa fa-star-o"></i>
                                    </c:forEach>
                                </div>
                                <a class="review-link" href="#">10 Review(s) | Add your review</a>
                            </div>


                            <div>
                                <h3 class="product-price">$${detail.price}<del class="product-old-price">$990.00</del></h3>
                                <span class="product-available">In Stock</span>
                            </div>
                            <p>${detail.title}.</p>

                            <!<!-- đã xóa -->

                            <div class="add-to-cart">
                                <div class="qty-label">
                                    Qty
                                    <div class="input-number">
                                        <input type="number" name="num">
                                        <span class="qty-up">+</span>
                                        <span class="qty-down">-</span>
                                    </div>
                                </div>
                                <button class="add-to-cart-btn" onclick="redirectToPage('order?pid=${detail.getId()}')"><i  class="fa fa-shopping-bag"></i> BUY NOW</button>

                            </div>

                            <ul class="product-btns">
                                <li><a href="#"><i class="fa fa-heart-o"></i> add to wishlist</a></li>
                                <li><a href="cart?cid=${detail.getId()}" style="margin: 0 15px" class="add-to-compare"><i class="fa fa-shopping-cart"></i> <span class="tooltipp"></span> add to cart</a></li>
                            </ul>

                            <ul class="product-links">
                                <li>Category:</li>
                                <li><a href="#">Headphones</a></li>
                                <li><a href="#">Accessories</a></li>
                            </ul>

                            <ul class="product-links">
                                <li>Share:</li>
                                <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                                <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                                <li><a href="#"><i class="fa fa-google-plus"></i></a></li>
                                <li><a href="#"><i class="fa fa-envelope"></i></a></li>
                            </ul>

                        </div>
                    </div>
                    <!-- /Product details -->

                    <!-- Product tab -->
                    <div class="col-md-12">
                        <div id="product-tab">
                            <!-- product tab nav -->
                            <ul class="tab-nav">
                                <li class="active"><a data-toggle="tab" href="#tab1">Description</a></li>
                                <li><a data-toggle="tab" href="#tab2">Details</a></li>
                                <li><a data-toggle="tab" href="#tab3">Reviews (3)</a></li>
                            </ul>
                            <!-- /product tab nav -->

                            <!-- product tab content -->
                            <div class="tab-content">
                                <!-- tab1  -->
                                <div id="tab1" class="tab-pane fade in active">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <p>${detail.description}.</p>
                                        </div>
                                    </div>
                                </div>
                                <!-- /tab1  -->

                                <!-- tab2  -->
                                <div id="tab2" class="tab-pane fade in">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="product-summary-item-title">Thông số sản phẩm
                                                <ul class="product-summary-item-ul d-flex flex-wrap mb-0" id="js-tskt-item">

                                                    <li>CPU: Intel® Core™ i5-1335U</li>
                                                    <li>RAM: 16GB LPDDR5 6400MHz (Hàn liền không nâng cấp được)</li>
                                                    <li>Ổ cứng: 512GB SSD PCIe NVMe (Nâng cấp thay thế,tối đa 1TB)</li>
                                                    <li>VGA: Intel® UHD Graphics</li>
                                                    <li>Màn hình: 14" WUXGA (1920 x 1200) IPS 60Hz Acer ComfyView™</li>
                                                    <li>Màu: Bạc</li>
                                                    <li>Chất liệu: Nhựa</li>
                                                    <li>OS: Windows 11</li>
                                                </ul>
                                            </div>
                                            <p>${detail.title}.</p>
                                        </div>
                                    </div>
                                </div>
                                <!-- /tab2  -->

                                <!-- tab3  -->
                                <div id="tab3" class="tab-pane fade in">
                                    <div class="row">
                                        <!-- Rating -->
                                        <div class="col-md-3">
                                            <div id="rating">
                                                <div class="rating-avg">
                                                    <span>${avg}</span>
                                                    <div class="rating-stars">
                                                        <c:forEach var="i" begin="1" end="${avg}">
                                                            <i class="fa fa-star"></i>
                                                        </c:forEach>
                                                        <c:forEach var="i" begin="${avg + 1}" end="5">
                                                            <i class="fa fa-star-o"></i>
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                                <ul class="rating">
                                                    <c:forEach var="star" begin="1" end="5">
                                                        <li>
                                                            <div class="rating-stars">
                                                                <c:forEach var="i" begin="1" end="${star}">
                                                                    <i class="fa fa-star"></i>
                                                                </c:forEach>
                                                                <c:forEach var="i" begin="${star+1}" end="5">
                                                                    <i class="fa fa-star-o"></i>
                                                                </c:forEach>
                                                            </div> 
                                                            <c:forEach var="o" items="${listStars}">
                                                                <c:if test="${o.getId() == star}">
                                                                    <div class="rating-progress">
                                                                        <div style="width: ${o.getSum() * 10}%;"></div>
                                                                    </div>
                                                                    <span class="sum">${o.getSum()}</span>
                                                                </c:if>
                                                            </c:forEach>
                                                        </li>
                                                    </c:forEach>

                                                </ul>
                                            </div>
                                        </div>

                                        <!-- Reviews -->

                                        <div class="col-md-6">
                                            <div id="reviews">
                                                <ul class="reviews">
                                                    <c:forEach items="${ListReview}" var="o">
                                                        <li>
                                                            <div class="review-heading">
                                                                <h5 class="name">${o.getUsername()}</h5>
                                                                <p class="date">${o.getDate()}</p>
                                                                <div class="review-rating">
                                                                    <c:forEach var="i" begin="1" end="${o.getRating()}">
                                                                        <i class="fa fa-star"></i>
                                                                    </c:forEach>
                                                                    <c:forEach var="i" begin="${o.getRating() + 1}" end="5">
                                                                        <i class="fa fa-star-o"></i>
                                                                    </c:forEach>
                                                                </div>
                                                            </div>
                                                            <div class="review-body">
                                                                <p>${o.getReview_text()}</p>
                                                            </div>
                                                        </li>
                                                    </c:forEach>
                                                </ul>
                                                <!--                                                <ul class="reviews-pagination">
                                                                                                    <li class="active">1</li>
                                                                                                    <li><a href="#">2</a></li>
                                                                                                    <li><a href="#">3</a></li>
                                                                                                    <li><a href="#">4</a></li>
                                                                                                    <li><a href="#"><i class="fa fa-angle-right"></i></a></li>
                                                                                                </ul>-->
                                            </div>
                                        </div>

                                        <!-- /Reviews -->

                                        <!-- Review Form -->
                                        <div class="col-md-3">
                                            <div id="review-form">
                                                <form class="review-form" action="detail" method="post">
                                                    <c:if test="${sessionScope.acc == null}">
                                                        <p >You must login to Admin account to submit review</p>
                                                        <p><a href="login" style="color: #db4566;">Login</a>here</p>
                                                    </c:if>
                                                    <!--                                                    <input class="input" type="text" placeholder="Your Name" name="name" required>
                                                                                                        <input class="input" type="email" placeholder="Your Email" name="email" required>-->
                                                    <textarea class="input" placeholder="Your Review" name="review" required></textarea>
                                                    <div class="input-rating">
                                                        <span>Your Rating: </span>
                                                        <div class="stars">
                                                            <input id="star5" name="rating" value="5" type="radio" ><label for="star5"></label>
                                                            <input id="star4" name="rating" value="4" type="radio" ><label for="star4"></label>
                                                            <input id="star3" name="rating" value="3" type="radio" ><label for="star3"></label>
                                                            <input id="star2" name="rating" value="2" type="radio" ><label for="star2"></label>
                                                            <input id="star1" name="rating" value="1" type="radio" ><label for="star1"></label>
                                                        </div>
                                                    </div>
                                                    <input type="hidden" name="pid" value="${detail.getId()}">
                                                    <button type="submit" class="primary-btn">Submit</button>
                                                </form>
                                            </div>
                                        </div>
                                        <!-- /Review Form -->
                                    </div>
                                </div>
                                <!-- /tab3  -->
                            </div>
                            <!-- /product tab content  -->
                        </div>
                    </div>
                    <!-- /product tab -->
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /SECTION -->



        <!-- Section -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">

                    <div class="col-md-12">
                        <div class="section-title text-center">
                            <h3 class="title">Related Products</h3>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="row">
                            <div class="products-tabs">
                                <!-- tab -->
                                <div id="tab1" class="tab-pane active">
                                    <div class="products-slick" data-nav="#slick-nav-1">
                                        <!-- product -->
                                        <div class="product">
                                            <div class="product-img">
                                                <img src="./img/product01.png" alt="">
                                                <div class="product-label">
                                                    <span class="sale">-30%</span>
                                                    <span class="new">NEW</span>
                                                </div>
                                            </div>
                                            <div class="product-body">
                                                <p class="product-category">Category</p>
                                                <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                                <h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
                                                <div class="product-rating">
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                </div>
                                                <div class="product-btns">
                                                    <button class="add-to-wishlist"><i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span></button>
                                                    <button class="add-to-compare"><i class="fa fa-exchange"></i><span class="tooltipp">add to compare</span></button>
                                                    <button class="quick-view"><i class="fa fa-eye"></i><span class="tooltipp">quick view</span></button>
                                                </div>
                                            </div>
                                            <div class="add-to-cart">
                                                <button class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> add to cart</button>
                                            </div>
                                        </div>
                                        <!-- /product -->

                                        <!-- product -->
                                        <div class="product">
                                            <div class="product-img">
                                                <img src="./img/product02.png" alt="">
                                                <div class="product-label">
                                                    <span class="new">NEW</span>
                                                </div>
                                            </div>
                                            <div class="product-body">
                                                <p class="product-category">Category</p>
                                                <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                                <h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
                                                <div class="product-rating">
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star-o"></i>
                                                </div>
                                                <div class="product-btns">
                                                    <button class="add-to-wishlist"><i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span></button>
                                                    <button class="add-to-compare"><i class="fa fa-exchange"></i><span class="tooltipp">add to compare</span></button>
                                                    <button class="quick-view"><i class="fa fa-eye"></i><span class="tooltipp">quick view</span></button>
                                                </div>
                                            </div>
                                            <div class="add-to-cart">
                                                <button class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> add to cart</button>
                                            </div>
                                        </div>
                                        <!-- /product -->

                                        <!-- product -->
                                        <div class="product">
                                            <div class="product-img">
                                                <img src="./img/product03.png" alt="">
                                                <div class="product-label">
                                                    <span class="sale">-30%</span>
                                                </div>
                                            </div>
                                            <div class="product-body">
                                                <p class="product-category">Category</p>
                                                <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                                <h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
                                                <div class="product-rating">
                                                </div>
                                                <div class="product-btns">
                                                    <button class="add-to-wishlist"><i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span></button>
                                                    <button class="add-to-compare"><i class="fa fa-exchange"></i><span class="tooltipp">add to compare</span></button>
                                                    <button class="quick-view"><i class="fa fa-eye"></i><span class="tooltipp">quick view</span></button>
                                                </div>
                                            </div>
                                            <div class="add-to-cart">
                                                <button class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> add to cart</button>
                                            </div>
                                        </div>
                                        <!-- /product -->

                                        <!-- product -->
                                        <div class="product">
                                            <div class="product-img">
                                                <img src="./img/product04.png" alt="">
                                            </div>
                                            <div class="product-body">
                                                <p class="product-category">Category</p>
                                                <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                                <h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
                                                <div class="product-rating">
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                </div>
                                                <div class="product-btns">
                                                    <button class="add-to-wishlist"><i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span></button>
                                                    <button class="add-to-compare"><i class="fa fa-exchange"></i><span class="tooltipp">add to compare</span></button>
                                                    <button class="quick-view"><i class="fa fa-eye"></i><span class="tooltipp">quick view</span></button>
                                                </div>
                                            </div>
                                            <div class="add-to-cart">
                                                <button class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> add to cart</button>
                                            </div>
                                        </div>
                                        <!-- /product -->

                                        <!-- product -->
                                        <div class="product">
                                            <div class="product-img">
                                                <img src="./img/product05.png" alt="">
                                            </div>
                                            <div class="product-body">
                                                <p class="product-category">Category</p>
                                                <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                                <h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
                                                <div class="product-rating">
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                </div>
                                                <div class="product-btns">
                                                    <button class="add-to-wishlist"><i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span></button>
                                                    <button class="add-to-compare"><i class="fa fa-exchange"></i><span class="tooltipp">add to compare</span></button>
                                                    <button class="quick-view"><i class="fa fa-eye"></i><span class="tooltipp">quick view</span></button>
                                                </div>
                                            </div>
                                            <div class="add-to-cart">
                                                <button class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> add to cart</button>
                                            </div>
                                        </div>
                                        <!-- /product -->
                                    </div>
                                    <div id="slick-nav-1" class="products-slick-nav"></div>
                                </div>
                                <!-- /tab -->
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /Section -->

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
        <script>
                                    function redirectToPage(url) {
                                        window.location.href = url;
                                    }
        </script>

    </body>
</html>

