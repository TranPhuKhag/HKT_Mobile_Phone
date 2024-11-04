<!DOCTYPE html>
<html lang="en">
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>User Detail</title>

        <!-- Google font -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

        <!-- Bootstrap -->
        <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>

        <!-- Slick -->
        <link type="text/css" rel="stylesheet" href="css/slick.css"/>
        <link type="text/css" rel="stylesheet" href="css/slick-theme.css"/>

        <!-- nouislider -->
        <link type="text/css" rel="stylesheet" href="css/nouislider.min.css"/>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" rel="stylesheet">

        <!-- Font Awesome Icon -->
        <link rel="stylesheet" href="css/font-awesome.min.css">

        <!-- Custom stlylesheet -->
        <link type="text/css" rel="stylesheet" href="css/style.css"/>
        <style>
               .back{
                margin-left: 75rem;
    padding-bottom: 0rem;
    padding: 5px 2rem;
    border-radius: 1rem;
    margin-bottom: 0px;
        padding-top: 1rem;
            margin-bottom: 22px;
            }
        </style>

    </head>
    <body>
        <jsp:include page="/header.jsp"/>
        <jsp:include page="/navigation.jsp"/>
        <div class="container">
         <h1 class="text-center">User Details</h1>
        
        
        <form action="userController">

            <table class="table table-striped">
                <tr><td>UserID : </td><td>${user.userID}</td></tr>
                <tr><td>Full Name : </td><td>${user.fullname}</td></tr>
                <tr><td>Email : </td><td>${user.email}</td></tr>		 
                <tr><td>Phone: </td><td>${user.phone}</td></tr>		 
                <tr><td>User Name  : </td><td>${user.username}</td></tr>		 
                <tr><td> Password : </td><td>${user.password}</td></tr>		 
                <tr><td>Role : </td><td>${user.role==1?'Admin':'User'}</td></tr>		 
                <tr><td> Status: </td><td>${user.status==1?'Disable':'Enable'}</td></tr>		 
            </table>
 
        </form>
        <form action="userController">
            <input type="hidden" name="action" value="list"> 
            <button type="submit" class="btn btn-dark back"><i class="fa-solid fa-arrow-left"></i></button>
        </form>
            
          </div>


<%@include file="/footer.jsp" %>

        <!-- jQuery Plugins -->
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/slick.min.js"></script>
        <script src="js/nouislider.min.js"></script>
        <script src="js/jquery.zoom.min.js"></script>
        <script src="js/main.js"></script>

    </body>
</html>
