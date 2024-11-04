<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>Product</title>

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

    </head>

    <body>
        <jsp:include page="header.jsp"/>
        <jsp:include page="navigation.jsp"/>

        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <!-- Product main img -->
                    <div class="col-md-5 col-md-push-2">
                        <div id="product-main-img">
                            <c:if test="${!empty product.productImg}">
                                <c:forEach var="imgItem" items="${product.productImg}">
                                    <div class="product-preview">
                                        <img src="${imgItem.img}" alt="">
                                    </div>
                                </c:forEach>
                            </c:if>            
                        </div>
                    </div>
                    <!-- /Product main img -->

                    <!-- Product thumb imgs -->
                    <div class="col-md-2  col-md-pull-5">
                        <div id="product-imgs">
                            <c:if test="${!empty product.productImg}">
                                <c:forEach var="imgItem" items="${product.productImg}">                            
                                    <div class="product-preview">
                                        <img src="${imgItem.img}" alt="">
                                    </div>
                                </c:forEach>
                            </c:if>    


                        </div>
                    </div>
                    <!-- /Product thumb imgs -->

                    <!-- Product details -->
                    <div class="col-md-5">
                        <div class="product-details ">
                            <!-- TAB1 -->
                            <h2 class="product-name">${product.productName}</h2>
                            <div>
                                <c:choose>
                                    <c:when test="${product.rate!=0}">
                                        <div class="product-rating">
                                            <c:forEach begin="1" end="${product.rate}">
                                                <i class="fa fa-star"></i>
                                            </c:forEach>
                                            <c:forEach begin="${product.rate}" end="4">
                                                <i class="fa fa-star-o"></i>
                                            </c:forEach>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <p>No review</p>
                                    </c:otherwise>
                                </c:choose>

                            </div>

                            <div>                            
                                <c:choose>
                                    <c:when test="${group.discount!=0}">
                                        <h3 class="product-price">$${product.newPrice} <del class="product-old-price">$${product.price}</del></h3>
                                    </c:when>
                                    <c:otherwise>
                                        <h3 class="product-price">$${product.price}</h3>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="product-options">
                                <label>
                                    Ram&Storage
                                </label>
                                <c:forEach var="products" items="${productList}">
                                    <a class="product-option ${products.ram==product.ram&&products.storage==product.storage?'selected':""}" href="./Admin?action=Product&&id=${products.productID}">${products.ram}GB/${products.storage}GB</a>
                                </c:forEach>

                                <label>
                                    Color
                                    <c:forEach var="products" items="${productcolor}">
                                        <a class="product-option ${products.color==product.color?'selected':""}" href="./Admin?action=Product&&id=${products.productID}">${products.color}</a>
                                    </c:forEach>
                                </label>
                            </div>

                            <ul class="product-links">
                                <li>Brand</li>
                                <li><a href="#">${group.brandName}</a></li>
                            </ul>


                        </div>
                        <form action="./Admin" class="form-action" >
                            <input type="hidden" name="id" value="${product.productID}">
                            <input type="hidden" name="groupID" value="${product.groupID}">
                            <input type="submit" name="action" value="Create" style="background-color: #D10024; color: white; border: none; padding: 10px; margin: 5px 0; cursor: pointer; font-size: 16px; border-radius: 5px;">
                            <input type="submit" name="action" value="Edit" style="background-color: #D10024; color: white; border: none; padding: 10px; margin: 5px 0; cursor: pointer; font-size: 16px; border-radius: 5px;">
                            <input type="submit" name="action" value="Delete" style="background-color: #D10024; color: white; border: none; padding: 10px; margin: 5px 0; cursor: pointer; font-size: 16px; border-radius: 5px;">
                        </form>
                        <form action="./Admin" method="POST">
                            <input type="hidden" name="id" value="${product.productID}">
                            <textarea id="img" name="img" class="form-textarea" required></textarea>
                            <input type="submit" name="action" value="Add Img" style="background-color: #D10024; color: white; border: none; padding: 10px; margin: 5px 0; cursor: pointer; font-size: 16px; border-radius: 5px;">
                        </form>
                    </div>
                    <!-- /Product details -->

                    <!-- Product tab -->
                    <div class="col-md-12">
                        <div id="product-tab">
                            <!-- product tab nav -->
                            <ul class="tab-nav">
                                <li class="active"><a data-toggle="tab" href="#tab1">Description</a></li>
                                <li><a data-toggle="tab" href="#tab2">Details</a></li>
                                <li><a data-toggle="tab" href="#tab3">Reviews (${feedbackList.size()})</a></li>
                            </ul>
                            <!-- /product tab nav -->

                            <!-- product tab content -->
                            <div class="tab-content">
                                <!-- tab1  trang dau tien  -->
                                <div id="tab1" class="tab-pane fade in active">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <p>${group.description}
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <!-- /tab1  -->

                                <!-- tab2  -->
                                <div id="tab2" class="tab-pane fade in">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <p>Screen: ${detail.screen}</p>
                                            <p>OS: ${detail.os}</p>
                                            <p>Rear camera: ${detail.afterCam}</p>
                                            <p>Front camera: ${detail.frontCam}</p>
                                            <p>Chip: ${detail.chip}</p>
                                            <p>Ram: ${product.ram} GB</p>
                                            <p>Storage:  ${product.storage} GB</p>
                                            <p>SIM: ${detail.sim}</p>
                                            <p>Pin: ${detail.pin}</p>
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
                                                    <span>${product.rate}</span>
                                                    <div class="rating-stars">
                                                        <c:forEach begin="1" end="${product.rate}">
                                                            <i class="fa fa-star"></i>
                                                        </c:forEach>
                                                        <c:forEach begin="${product.rate}" end="4">
                                                            <i class="fa fa-star-o"></i>
                                                        </c:forEach>

                                                    </div>
                                                </div>
                                                <ul class="rating">
                                                    <li>
                                                        <div class="rating-stars">
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                        </div>
                                                        <div class="rating-progress">
                                                            <div style="width: ${rateList[4]/feedbackList.size()*100}%;"></div>
                                                        </div>
                                                        <span class="sum">${rateList[4]}</span>

                                                    </li>
                                                    <li>
                                                        <div class="rating-stars">
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star-o"></i>
                                                        </div>
                                                        <div class="rating-progress">
                                                            <div style="width: ${rateList[3]/feedbackList.size()*100}%;"></div>
                                                        </div>
                                                        <span class="sum">${rateList[3]}</span>
                                                    </li>
                                                    <li>
                                                        <div class="rating-stars">
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star-o"></i>
                                                            <i class="fa fa-star-o"></i>
                                                        </div>
                                                        <div class="rating-progress">
                                                            <div style="width: ${rateList[2]/feedbackList.size()*100}%;"></div>
                                                        </div>
                                                        <span class="sum">${rateList[2]}</span>
                                                    </li>
                                                    <li>
                                                        <div class="rating-stars">
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star-o"></i>
                                                            <i class="fa fa-star-o"></i>
                                                            <i class="fa fa-star-o"></i>
                                                        </div>
                                                        <div class="rating-progress">
                                                            <div style="width: ${rateList[1]/feedbackList.size()*100}%;"></div>
                                                        </div>
                                                        <span class="sum">${rateList[1]}</span>
                                                    </li>
                                                    <li>
                                                        <div class="rating-stars">
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star-o"></i>
                                                            <i class="fa fa-star-o"></i>
                                                            <i class="fa fa-star-o"></i>
                                                            <i class="fa fa-star-o"></i>
                                                        </div>
                                                        <div class="rating-progress">
                                                            <div style="width: ${rateList[0]/feedbackList.size()*100}%;"></div>
                                                        </div>
                                                        <span class="sum">${rateList[0]}</span>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        <!-- /Rating -->

                                        <!-- Reviews -->
                                        <div class="col-md-6">
                                            <div id="reviews">
                                                <ul class="reviews">
                                                    <c:choose>
                                                        <c:when test="${!empty feedbackList}">
                                                            <c:forEach var="feedbacks" items="${feedbackList}">
                                                                <li class="feedback-item">
                                                                    <div class="review-heading">
                                                                        <h5 class="name">${feedbacks.userName}</h5>
                                                                        <p class="Date">${feedbacks.date}</p>
                                                                        <div class="review-rating">
                                                                            <c:forEach begin="1" end="${feedbacks.rate}">
                                                                                <i class="fa fa-star"></i>
                                                                            </c:forEach>
                                                                            <c:forEach begin="${feedbacks.rate+1}" end="5">
                                                                                <i class="fa fa-star-o empty"></i>
                                                                            </c:forEach>

                                                                        </div>
                                                                    </div>
                                                                    <div class="review-body ">
                                                                        <p>${feedbacks.message}</p>
                                                                    </div>
                                                                </li>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <p>no reviewer</p>
                                                        </c:otherwise>
                                                    </c:choose>



                                                </ul>
                                                <ul class="reviews-pagination">

                                                </ul>
                                            </div>
                                        </div>
                                        <!-- /Reviews -->

                                        <!-- Review Form -->
                                        <div class="col-md-3">
                                            <div id="review-form">
                                                ${sessionScope.usersession.fullname}
                                                <form action="./Feedback" method="GET" class="review-form" id="ratingForm" onsubmit="validateForm()">
                                                    <textarea class="input" name="message" placeholder="Your Review" required></textarea>
                                                    <div class="input-rating">
                                                        <span>Your Rating: </span>
                                                        <div class="stars" >
                                                            <input id="star5" name="rating" value="5" type="radio" required><label for="star5"></label>
                                                            <input id="star4" name="rating" value="4" type="radio" required><label for="star4"></label>
                                                            <input id="star3" name="rating" value="3" type="radio" required><label for="star3"></label>
                                                            <input id="star2" name="rating" value="2" type="radio" required><label for="star2"></label>
                                                            <input id="star1" name="rating" value="1" type="radio" required><label for="star1"></label>
                                                        </div>
                                                    </div>
                                                    <input name="action" type="hidden" value="insert">
                                                    <input  name="id" type="hidden" value="${product.productID}">
                                                    <input type="submit" value="Submit" class="primary-btn">
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




        <jsp:include page="footer.jsp"/>
        <!-- jQuery Plugins -->
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/slick.min.js"></script>
        <script src="js/nouislider.min.js"></script>
        <script src="js/jquery.zoom.min.js"></script>
        <script src="js/main.js"></script>
        <script src="js/product.js"></script>
        <script src="js/paginationfull.js"></script>
    </body>
</html>
