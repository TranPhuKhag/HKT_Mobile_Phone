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
                <!-- row -->
                <div class="row">
                    <div class="col-md-6"> 
                        <h1>
                            ${product.productName}
                        </h1></div>
                    <form action="./ProductGroup" method="POST" class="col-md-6 form-actions">
                        <label for="discount" class="form-label">Discount:</label>
                        <input type="number" id="discount" name="discount" value="${product.discount}">
                        <input type="hidden" name="groupID" value="${product.groupID}">
                        <input type="submit"  name="action" value="Set Discount">
                    </form>

                    <div class="col-md-6 ">
                        <p>Brand: ${product.brandName}</p>
                        <p>Description:</p>
                        <p>${product.description}</p>
                        <p>Screen: ${detail.screen}</p>
                        <p>OS: ${detail.os}</p>
                        <p>Rear Camera: ${detail.afterCam}</p>
                        <p>Front Camera: ${detail.frontCam}</p>
                        <p>Chip: ${detail.chip}</p>
                        <p>SIM: ${detail.sim}</p>
                        <p>Pin: ${detail.pin}</p>                    
                        <div>
                            <form method="POST" class="form-actions" >
                                <input name="groupID" type="hidden" value="${product.groupID}">
                                <input name="action" type="submit" value="Delete">
                                <input name="action" type="submit" value="Edit">                         
                            </form>
                        </div>
                    </div>
                    <div class="col-md-6 product-detail">                                               
                        <img src="${product.img}">
                        <p>Image URL</p>
                        <p>${product.img}</p>
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
