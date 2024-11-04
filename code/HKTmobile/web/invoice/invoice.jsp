<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html lang="en">
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <head>
        
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>Invoice Management Page</title>

        <!-- Google font -->
        <link  rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

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

    </head>
    <body></body>
        <jsp:include page="/header.jsp"/>
        <jsp:include page="/navigation.jsp"/>
        <div class="container">

         <h1 class="text-center">Invoice Management</h1>
               <c:set var="no" value="${0}"></c:set>

            <table border="1" class="table table-striped">
                <thead>
                    <tr  >
                        <th>OrderID</th>
                        <th>Full Name </th>
                        <th>Number Order</th>
                        <th>Status</th>
                        <th>Date</th>
                        <th>Detail</th>
                        <th>Detele</th>
                        
                    </tr>
                </thead>
                <form action="invoiceController">
                <c:forEach items="${list}" var="invoice" >
                    <tbody>
                        <tr style="text-align: center" class="paging-item">
                            <td> ${invoice.orderID}</td>
                            
                            <td>  <c:forEach items="${invoice.userDTO}" var="user">
                                    ${user.fullname} 
                                </c:forEach> </td>
                            <td>${invoice.amount}</td>
                            <td> <c:forEach items="${invoice.statusDTO}" var="status">
                                    ${status.status}
                                </c:forEach></td>
                            <td>${invoice.date}</td>
                            <td>
                                <form action="invoiceController">
                                <input type="hidden" name="id" value="${invoice.orderID}">
                                <input type="hidden" name="action" value="detail">
                                <button type="submit" class="fa-solid fa-info btn-light"> </button>
                                </form>
                                
                            </td>
                            <td>
                                <form action="invoiceController">
                                <input type="hidden" name="id" value="${invoice.orderID}">
                                <input type="hidden" name="action" value="delete">
                                        <button type="submit"  class="fa-regular fa-trash-can btn btn-danger submit" class="btn btn-danger" style="text-align:  center"></button>
                                </form>
                                
                            </td>
                        </tr>

                    </tbody>
                                            <c:set var="no" value="${no+1}"></c:set>

                </c:forEach>
                            </form>

            </table>
                               <p style="color: red"> Number order  : ${no}</p>

                                 <div class="center-content">                    
                            <ul class="reviews-pagination table-pagination pagination"></ul>
                        </div>
         </div>
            <jsp:include page="/footer.jsp"/>
                <script src="js/paginationtable.js"></script>
</body>
</html>
