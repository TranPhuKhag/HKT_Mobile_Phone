<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html lang="en">
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <style>

        </style>
    </head>
    <body>
        <jsp:include page="/header.jsp"/>
        <jsp:include page="/navigation.jsp"/>
        <h1 style="text-align: center">Order List</h1>
        <form action="Order">

            <table border="1" class="table-striped table">
                <thead>
                    <tr>
                        <th>Mã Hoá Đơn </th>
                        <th>Tên Khách Hàng </th>
                        <th>Date</th>
                        <th>Email</th>
                        <th>Status</th>
                        <th>Address</th>
                        <th>Phone</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${orderDetailList}" var="invoice">
                        <c:forEach items="${invoice.userDTO}" var="user">
                            <c:forEach items="${invoice.statusDTO}" var="status">
                                <tr>
                                    <td>${invoice.orderID}</td>
                                    <td>${user.fullname}</td>
                                    <td>${invoice.date}</td>
                                    <td>${user.email}</td>
                                    <td>${status.status}</td>
                                    <td>${invoice.address}</td>
                                    <td>${user.phone}</td>
                                </tr>
                            </c:forEach>
                        </c:forEach>
                    </c:forEach>
                </tbody>
            </table>
            <br>
            <hr>

            <table border="1" class="table">
                <thead>
                    <tr>
                        <th>ProductID </th>
                        <th>ProductName</th>
                        <th>RAM</th>
                        <th>Color</th>
                        <th>Storage</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Discount</th>
                        <th>Total price </th>
                    </tr>
                </thead>

                <c:forEach items="${requestScope.orderDetailList}" var="invoice" >
                    <c:choose>
                        <c:when test="${not empty invoice.orderdetailDTO}">
                            <c:forEach items="${invoice.orderdetailDTO}" var="orderDetail">
                                <c:forEach items="${orderDetail.product}" var="product">
                                    <c:forEach items="${product.productGroup}" var="productGroup">
                                        <tr>
                                            <c:set var="sum" value="${orderDetail.quantity}"></c:set>
                                            <c:set var="total" value="${orderDetail.quantity*product.newPrice}"></c:set>
                                            <c:set var="tong" value="${total+tong}"></c:set>
                                            <c:set var="soluong" value="${sum+soluong}"></c:set>
                                            <td>${product.productID}</td>
                                            <td>${product.productName}</td>
                                            <td>${product.ram}</td>
                                            <td>${product.color}</td>
                                            <td>${product.storage}</td>
                                            <td>${orderDetail.quantity}</td>
                                            <td>${product.newPrice}</td>
                                            <td>${productGroup.discount}</td>
                                            <td>${total}</td>                   
                                        </tr>
                                    </c:forEach>
                                </c:forEach>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="6">No order details available.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                                <table border="1" class="table-striped table bill">
                                    <thead>
                                        <tr>
                                            <th>Number of Product</th>
                                            <th> Total </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>${soluong}</td>
                                            <td>${tong}</td>
                                        </tr>
                                    </tbody>
                                </table>

            </table>

            

        </form>
        <jsp:include page="/footer.jsp"/>
    </body>
</html>