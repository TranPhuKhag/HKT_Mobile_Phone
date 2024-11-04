<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>Homepage</title>

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
        <link type="text/css" rel="stylesheet" href="css/main.css"/>
        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->

    </head> 
    <body>
        <jsp:include page="header.jsp"/>
        <jsp:include page="navigation.jsp"/>
        <!-- SECTION -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <!-- shop -->
                    <div class="col-md-6 col-xs-6">
                        <div class="shop">
                            <div class="shop-img">
                                <img src="./img/shop01.png" alt="">
                            </div>
                            <div class="shop-body">
                                <h3>SAMSUNG<br>Collection</h3>
                                <a href="./Store?BrandName=Samsung" class="cta-btn">Shop now <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                    </div>
                    <!-- /shop -->

                    <!-- shop -->
                    <div class="col-md-6 col-xs-6">
                        <div class="shop">
                            <div class="shop-img">
                                <img src="./img/shop01.png" alt="">
                            </div>
                            <div class="shop-body">
                                <h3>APPLE<br>Collection</h3>
                                <a href="./Store?BrandName=Apple" class="cta-btn">Shop now <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                    </div>
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
                

                    <!-- section title -->

                    <!-- /section title -->
                    <c:if test="${!empty newProduct}">
                        <div class="section">
                            <!-- container -->
                            <div class="container">
                                <!-- row -->
                                <div class="row">
                                    <!-- product -->                    
                                    <div class="col-md-12">
                                        <div class="section-title">
                                            <h3 class="title">New Products</h3>
                                        </div>
                                    </div>
                                    <c:forEach var="relate" items="${newProduct}"> 
                                        <div class="col-md-3 col-xs-6">
                                            <div class="product">
                                                <div class="product-img">
                                                    <img src="${relate.img}" alt="product img">
                                                    <c:if test="${relate.discount!=0}">
                                                        <div class="product-label">
                                                            <span class="sale" style="font-size: 15px;">${relate.discount}%</span>
                                                        </div>
                                                    </c:if>
                                                </div>
                                                <div class="product-body">
                                                    <!-- SẢN PHẨM CỦA REALTED PRODUCT MỤC ĐẦU TIÊN  -->
                                                    <p class="product-category">${relate.brandName}</p>
                                                    <h3 class="product-name"><a href="./Product?id=${relate.products[0].productID}">${relate.productName}</a></h3>
                                                        <c:choose>
                                                            <c:when test="${relate.discount!=0}">
                                                            <h4 class="product-price">$${relate.products[0].newPrice} <del class="product-old-price">$${relate.products[0].price}</del></h4>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <h4 class="product-price">$${relate.products[0].price}</h4>
                                                        </c:otherwise>
                                                    </c:choose>                                    
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <!-- /row -->
                            </div>
                            <!-- /container -->
                        </div>
                    </c:if>
                

                <!-- /section title -->
                <c:if test="${!empty discount}">
                    <div class="section">
                        <!-- container -->
                        <div class="container">
                            <!-- row -->
                            <div class="row">
                                <!-- product -->                
                                <div class="col-md-12">
                                    <div class="section-title">
                                        <h3 class="title">Discount</h3>
                                    </div>
                                </div>
                                <c:forEach var="relate" items="${discount}"> 
                                    <div class="col-md-3 col-xs-6">
                                        <div class="product">
                                            <div class="product-img">
                                                <img src="${relate.img}" alt="product img">
                                                <c:if test="${relate.discount!=0}">
                                                    <div class="product-label">
                                                        <span class="sale" style="font-size: 15px;">${relate.discount}%</span>
                                                    </div>
                                                </c:if>
                                            </div>
                                            <div class="product-body">
                                                <!-- SẢN PHẨM CỦA REALTED PRODUCT MỤC ĐẦU TIÊN  -->
                                                <p class="product-category">${relate.brandName}</p>
                                                <h3 class="product-name"><a href="./Product?id=${relate.products[0].productID}">${relate.productName}</a></h3>
                                                    <c:choose>
                                                        <c:when test="${relate.discount!=0}">
                                                        <h4 class="product-price">$${relate.products[0].newPrice} <del class="product-old-price">$${relate.products[0].price}</del></h4>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <h4 class="product-price">$${relate.products[0].price}</h4>
                                                    </c:otherwise>
                                                </c:choose>                                    
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <!-- /row -->
                        </div>
                        <!-- /container -->
                    </div>
                </c:if>
            </div>
        </div>
        <!-- /row -->

    </div>
    <!-- /container -->
</div>
<!-- /SECTION -->





<jsp:include page="footer.jsp"/>

<!-- jQuery Plugins -->
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/slick.min.js"></script>
<script src="js/nouislider.min.js"></script>
<script src="js/jquery.zoom.min.js"></script>
<script src="js/main.js"></script>

</body>
</html>
