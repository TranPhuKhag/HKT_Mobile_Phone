<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Brand Management</title>
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
        <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>
        <link type="text/css" rel="stylesheet" href="css/slick.css"/>
        <link type="text/css" rel="stylesheet" href="css/slick-theme.css"/>
        <link type="text/css" rel="stylesheet" href="css/nouislider.min.css"/>
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <link type="text/css" rel="stylesheet" href="css/style.css"/>
        <link type="text/css" rel="stylesheet" href="css/brand.css"/>
        <style>
        
        </style>
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
                            <c:if test="${!empty error}">
                <h3 style="color: red"> ${error} </h3>
            </c:if>

                <div class="row">
                    <div class="col-md-12">
                        <table border="1" class="table table-striped">
                            <thead>
                                <tr style="text-align: center;">
                                    <td>BrandID</td>
                                    <td>Brand Name</td>
                                    <td>Product</td>
                                    <td>Delete</td>
                                    <td>Update</td>
                                </tr>
                            </thead>
                            <tbody id="table-body" >
                                <c:forEach var="brand" items="${brandList}">
                                    <tr class="paging-item" style="text-align: center;">
                                <form action='./Brand' method=GET>
                                        <td>${brand.brandID}</td>
                                        <td><input name="name" value="${brand.brandName}" type="text"></td>
                                        <td>${brand.number}</td>                                                                              
                                                <input name="number" value="${brand.number}" type="hidden">
                                                <input name="id" value="${brand.brandID}" type="hidden">
                                                <td><input class="red-button" type=submit name="action" value="Delete"></td>
                                                <td><input class="red-button" type=submit name="action" value="Update"></td>
                                            </form>
                                        
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div class="center-content">                    
                            <ul class="reviews-pagination table-pagination pagination"></ul>
                        </div>
                        <form action='./Brand' method=POST class="center-content">
                            <input name=action type=hidden value="create">
                            <input type="text"  class="form-control"name="name" required>
                            <input class="btn btn-danger" type=submit value=Create >
                        </form>
                    </div>
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
    <script src="js/paginationtable.js"></script>


    </script>
</body>
</html>
