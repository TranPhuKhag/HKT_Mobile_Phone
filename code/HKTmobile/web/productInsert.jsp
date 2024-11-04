<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
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
        <!-- HEADER -->
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
        <jsp:include page="header.jsp"/>
        <jsp:include page="navigation.jsp"/>
        <!-- SECTION -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row --><!-- row -->
                
                <form action="./Admin" method="GET" class="form-actions" accept-charset="UTF-8">
                    <div class="row">
                        <div class="col-md-12">
                            <h1 class="product-name">${group.productName}</h1>
                                                    <c:if test="${!empty error}">
                            <h3 style="color: red"> ${error} </h3>
                        </c:if>
                        </div>                            

                        <div class="col-md-6">
                            <div style="font-size:20px;">                                                                 
                                <label for="RAM-select" style="font-size:20px;" class="form-label">RAM:</label>
                                <select name="Ram" id="RAM-select">

                                    <option value="4" >4GB</option>   
                                    <option value="6" >6GB</option>   
                                    <option value="8" >8GB</option>     
                                    <option value="12">12GB</option>   
                                </select>
                            </div>
                            <div style="font-size:20px;">                                                                 
                                <label for="Storage-select" style="font-size:20px;" class="form-label">Storage:</label>
                                <select name="Storage" id="Storage-select" >

                                    <option value="64" >64GB</option>   
                                    <option value="128" >128GB</option>   
                                    <option value="256" >256GB</option>     
                                    <option value="512" >512GB</option>   
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6 product-detail">
                            <label for="color" class="form-label">Color: </label>
                            <input type="text" id="color" name="color"  class="form-input">

                            <label for="price" class="form-label">Price: </label>
                            <input type="number" id="price" name="price"  class="form-input">
                        </div>
                        <div class="col-md-12 product-detail">

                            <div class="row">
                                <c:forEach begin="1" end="6" step="1">
                                    <div class="col-md-4 product-edit">
                                        <label for="img" class="form-label">Image URL:</label>
                                        <textarea id="img" name="img[]" class="form-textarea">${imgItem.img}</textarea>
                                    </div>
                                </c:forEach></div>
                        </div>

                        <div class="col-md-12 product-detail">
                            
                            <input name="groupID" type="hidden" value="${group.groupID}">
                            <input name="action" type="submit" value="Insert">
                            
                        </div>

                    </div>
                </form>


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
