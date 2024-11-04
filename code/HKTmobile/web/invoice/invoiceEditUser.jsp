<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html lang="en">
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <head>
        
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>Invoice Edit User Page</title>

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

        
    </head>
    <body>
          <jsp:include page="/header.jsp"/>
        <jsp:include page="/navigation.jsp"/>
        <div class="container">
       
         <div class="row">
                    <div class="col-md-6">
                        <h4>OrderID : <b>${order.orderID}</b></h4>
                        <h4>UserID : <b>${user.userID}</b></h4>
                    </div>
                </div>
        
        
        <hr>
        <form action="invoiceController">
            <div class="row">
                <div class="col-md-6">
                    <label>Full Name:</label>
                    <input type="text" name="fullname" value="${user.fullname}" class="form-control">
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <label> Email          :</label>
                    <input type="email" name="email" value="${user.email}" class="form-control">
                </div>
            </div><div class="row">
                <div class="col-md-6">
                    <label>Phone          : </label>
                   <input type="number" name="phone" value="${user.phone}" class="form-control">
                </div>
            </div><div class="row">
                <div class="col-md-6">
                    <label>Date           :</label>
                    <input type="datetime" name="date" value="${order.date}" class="form-control">
                </div>
            </div><div class="row">
                <div class="col-md-6">
                    <label> Address        :</label>
                    <input type="text" name="address" value="${order.address}" class="form-control">
                </div>
            </div>
           
            <label for="status_option">Status : </label>
            
            <select id="status_option" name="statusID" class="form-select"> 
                <option value="1" selected="">Not confirmed</option>
                <option value="2">Confirmed</option>
                <option value="3">Cancelled</option>
            </select>
            <br>

            <input type="hidden" name="action" value="updateUser">
            <input type="hidden" name="userID" value="${user.userID}">
            <input type="hidden" name="orderID" value="${order.orderID}">

            <button type="submit" class="btn btn-dark">SAVE</button>

        </form>
</div>

   <jsp:include page="/footer.jsp"/>
    </body>
</html>
