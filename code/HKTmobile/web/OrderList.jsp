<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>Order List</title>

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
        <jsp:include page="header.jsp"/>
        <jsp:include page="navigation.jsp"/>




        <!-- SECTION -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <div class="col-md-12">
                        <table border="1" class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th>Amount </th>
                                    <th>Date</th>
                                    <th>Address</th>
                                    <th>Status </th>
                                    <th>Detail</th>
                                    <th>Delete</th>
                                </tr>
                            </thead>
                            <form action="Order">
                                <c:forEach items="${orderList}" var="odl" >
                                    <tbody>
                                        <tr class="paging-item">
                                            <td> ${odl.orderID}</td>
                                            <td> ${odl.amount}</td>
                                            <td> ${odl.date}</td>
                                            <td> ${odl.address}</td>
                                            <td> 
                                            <c:forEach var="statusDTO" items="${odl.statusDTO}">
                                            ${statusDTO.status}   
                                            </c:forEach></td >
                                            <td>
                                                <form action="Order">
                                                    <input type="hidden" name="orderID" value="${odl.orderID}">
                                                    <input type="hidden" name="action" value="orderDetailList">
                                                    <button type="submit" class="btn btn-dark" >Detail</button>
                                                </form>
                                            </td>
                                            <td>
                                                <form action="Order">
                                                    <input type="hidden" name="orderID" value="${odl.orderID}">
                                                    <input type="hidden" name="userID" value="${sessionScope.usersession.userID}">
                                                    <input type="hidden" name="action" value="deleteOrder">                                            
                                                    <button type="submit" class="btn btn-dark"
                                                            <c:if test="${odl.statusID != 1}">
                                                                disabled
                                                            </c:if>>
                                                        Delete    
                                                    </button>                      
                                                </form>     
                                            </td>

                                        </tr>
                                    </tbody>
                                </c:forEach>
                            </form>
                        </table>
                        <a style="color: red"href="Homepage">Back Home Page</a>

                        <div class="center-content">                    
                            <ul class="reviews-pagination table-pagination pagination"></ul>
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

    </body>
</html>
