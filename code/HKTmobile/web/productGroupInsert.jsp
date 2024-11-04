<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>Product Group</title>

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
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    </head>
    <body>
        <!-- HEADER -->
        <jsp:include page="header.jsp"/>
        <jsp:include page="navigation.jsp"/>





        <!-- SECTION -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row --><!-- row -->
                <form action="./ProductGroup" method="POST"class="form-actions">
                    <div class="row">
                        <div class="col-md-12">
                            <h1>
                                <label for="productName" class="form-label">Product Name: </label>
                                <input type="text" id="productName" name="productName"  class="form-input" required>
                            </h1>
                        </div>
                        <div class="col-md-6">

                            <label for="brandName" class="form-label">Brand:</label>
                            <select id="brandName" name="brandID" class="form-select">
                                <c:forEach var="brand" items="${brandlist}">
                                    <option value="${brand.brandID}" ${product.brandName == brand.brandName ? 'selected' : ''}>${brand.brandName}</option>
                                </c:forEach>                      
                            </select>
                            <label for="description" class="form-label">Description:</label>
                            <textarea id="description" name="description" class="form-textarea" required></textarea>


                            <label for="screen" class="form-label">Screen:</label>
                            <input type="text" id="screen" name="screen" class="form-input" required>

                            <label for="os" class="form-label">OS:</label>
                            <input type="text" id="os" name="os"  class="form-input" required>

                            <label for="afterCam" class="form-label">Rear Camera:</label>
                            <input type="text" id="afterCam" name="afterCam" class="form-input" required>

                            <label for="frontCam" class="form-label">Front Camera:</label>
                            <input type="text" id="frontCam" name="frontCam"  class="form-input" required>

                            <label for="chip" class="form-label">Chip:</label>
                            <input type="text" id="chip" name="chip"  class="form-input" required>

                            <label for="sim" class="form-label">SIM:</label>
                            <input type="text" id="sim" name="sim"  class="form-input" required>

                            <label for="pin" class="form-label">Pin:</label>
                            <input type="text" id="pin" name="pin"  class="form-input" required>
                        </div>
                        <div class="col-md-6 product-detail">
                            
                            <label for="img" class="form-label">Image URL:</label>
                            <textarea id="img" name="img" class="form-textarea"></textarea>
                            <input name="groupID" type="hidden" value="${product.groupID}">
                            <input name="action" type="submit" value="Add">
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
