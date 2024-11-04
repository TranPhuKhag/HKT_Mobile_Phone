<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html lang="en">
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>Invoice Detail Page</title>
        <link  rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

        <!-- Google font -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" rel="stylesheet">

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
        <h1 style="text-align: center">Invoice Detail</h1>
        <form action="invoiceController">

            <table border="1" class="table-striped table">
                <thead>
                    <tr>
                        <th>OrderID </th>
                        <th>FullName </th>
                        <th>Date</th>
                        <th>Email</th>
                        <th>Status</th>
                        <th>Address</th>
                        <th>Phone</th>
                        <th>Update</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${list}" var="invoice">
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
                                    <td><form action="invoiceController" >
                                            <input type="hidden" name="userID" value="${user.userID}">
                                            <input type="hidden" name="fullname" value="${user.fullname}">
                                            <input type="hidden" name="email" value="${user.email}">
                                            <input type="hidden" name="phone" value="${user.phone}">

                                            <input type="hidden" name="orderID" value="${invoice.orderID}">
                                            <input type="hidden" name="date" value="${invoice.date}" >
                                            <input type="hidden" name="address" value="${invoice.address}">
                                            <input type="hidden" name="statusID" value="${status.statusID}">
                                            <input type="hidden" name="action" value="editUser">
                                            <button type="submit" class="fa-regular fa-pen-to-square btn btn-dark submit"></button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:forEach>
                    </c:forEach>
                </tbody>
            </table>
            <br>

            <table border="1" class="table">
                <thead>
                    <tr>
                        <th>ProductID</th>
                        <th>ProductName</th>
                        <th>RAM</th>
                        <th>Color</th>
                        <th>Storage</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Discount</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <c:set var="amount" value="0"></c:set>
                <c:set var="soluong" value="0"></c:set>
                <c:forEach items="${requestScope.list}" var="invoice" >
                    <c:choose>
                        <c:when test="${not empty invoice.orderdetailDTO}">
                            <c:forEach items="${invoice.orderdetailDTO}" var="orderDetail">
                                <c:forEach items="${orderDetail.product}" var="product">
                                    <c:forEach items="${product.productGroup}" var="productGroup">
                                        <tr>
                                            <c:set var="amount" value="${amount+orderDetail.quantity}"></c:set>

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
                                            <td>${product.discount}</td>
                                            <td>
                                                <form action="invoiceController">
                                                    <input type="hidden" name="action" value="deleteProduct">
                                                    <input type="hidden" name="id" value="${invoice.orderID}">
                                                    <input type="hidden" name="productID" value="${product.productID}">
                                                    <c:set var="productIDdelete" value="${product.productID}"></c:set>
                                                    <c:if test="${productIDdelete==product.productID}">
                                                        <input type="hidden" name="amounts" value="${amount}">
                                                        <input type="hidden" name="totalprices" value="${tong}">
                                                        <input type="hidden" name="totalID" value="${product.newPrice*orderDetail.quantity}">


                                                    </c:if> 
                                                    <button type="submit"  class="fa-regular fa-trash-can btn btn-danger submit"></button>
                                                </form>
                                            </td>
                                            <%--    <td>
                                                <form action="invoiceController">
                                                     <input type="hidden" name="action" value="editProduct">
                                                    <input type="hidden" name="id" value="${invoice.orderID}">
                                                    <input type="hidden" name="productID" value="${product.productID}">
                                                    <input type="hidden" name="groupID" value="${product.groupID}">
                                                    
                                                    <button type="submit" class="btn btn-dark">Update</button>
                                                </form>
</td> --%>

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
                            <th>Number Of Product </th>
                            <th>Total Price </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>${soluong}</td>
                    <form action="invoiceController">
                        <td>${tong}</td>
                    </form>

                    </tr>
                    </tbody>
                </table>

            </table>


        </form>
        <jsp:include page="/footer.jsp"/>
    </body>
</html>
