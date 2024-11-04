<!DOCTYPE html>
<html lang="en">
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>User Edit</title>

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
        <link type="text/css" rel="stylesheet" href="css/brand.css"/>
        <style>

        </style>

    </head>
    <body>
        <jsp:include page="/header.jsp"/>
        <jsp:include page="/navigation.jsp"/>
        <div class="container">
            <h1 class="text-center">User Edit</h1>
            <form action="userController">


                <div class="row">
                    <div class="col-md-6">
                        <label></label>
                        <input type="hidden" name="userID" value="${user.userID}" class="form-control">
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <label>FullName :</label>
                        <input type="text" name="fullname" value="${user.fullname}" required class="form-control">
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <label>Email :</label>
                        <input type="email" name="email" value="${user.email}" required class="form-control">
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <label>UserName :</label>
                        <input type="text" name="username" value="${user.username}" required class="form-control">
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <label>Passwword :</label>
                        <input type="password" name="password" value="${user.password}" required class="form-control">
                    </div>
                </div>

                <div class="row">
<div class="col-md-6">
                        <label>Phone :</label>
                        <input type="number" name="phone" value="${user.phone}" required class="form-control">
                    </div>
                </div>


                <div class="row">
                    <div class="col-md-6">

                        <label for="status_option">Role :</label>
                        <select id="status_option" name="role" class="form-select"> 
                            <option value="0" ${user.role==0? 'selected':''}>User</option>
                            <option value="1" ${user.role==1? 'selected':''}>Admin</option>
                        </select>      
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <label for="status_option">Status : </label>
                        <select id="status_option" name="status" class="form-select"> 
                            <option value="0" ${user.status==0? 'selected':''}>Enable</option>
                            <option value="1" ${user.status==1? 'selected':''}>Disable</option>
                        </select>               
                    </div>
                </div>
        </div>
        <div class="row center-content">
            <input type="hidden" name="action" value="${nextaction}">

            <button style="width: 20rem" type="submit" class="btn btn-secondary  red-button col-md-12">Save</button>

        </div>
    </form>

    <form action="userController">
        <div class="row center-content">
                <input type="hidden" name="action" value="list"> 
        <button style="width: 20rem"  type="submit" class="btn btn-secondary red-button">BACK</button>


        </div>
    
    </form>






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