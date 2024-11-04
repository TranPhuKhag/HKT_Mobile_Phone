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
    .text-center {
        text-align: center;
    }
    .mt-3 {
        margin-top: 1rem;
    }
</style>
    </head>
    <body>
        <jsp:include page="/header.jsp"/>
        <jsp:include page="/navigation.jsp"/>
        <div class="container">
            <h1 class="text-center">User Edit</h1>
            <form action="userController" >


                <div class="row">
                    <div class="col-md-6">
                        <label>UserId :</label>
                        <input type="hidden" name="userID" value="${user.userID}" class="form-control">${user.userID}
                    </div>
                    <div class="col-md-6">
                        <label>FullName :</label>
                        <input type="hidden" name="fullname" value="${user.fullname}" required class="form-control">${user.fullname}
                    </div>
                    <div class="col-md-6">
                        <label>Email :</label>
                        <input type="hidden" name="email" value="${user.email}" required class="form-control">${user.email}
                    </div>
                    <div class="col-md-6">
                        <label>UserName :</label>
                        <input type="hidden" name="username" value="${user.username}" required class="form-control">${user.username}
                    </div>
                    <div class="col-md-6">
                        <label>Passwword :</label>
                        <input type="hidden" name="password" value="${user.password}" required class="form-control">${user.password}
                    </div>
                    <div class="col-md-6">
                        <label>Phone :</label>
                        <input type="hidden" name="phone" value="${user.phone}" required class="form-control">${user.phone}
                    </div>
                    <div class="col-md-6">

                        <label for="status_option">Role :</label>
                        <select id="status_option" name="role" class="form-select"> 
                            <option value="0" ${user.role==0? 'selected':''}>User</option>
                            <option value="1" ${user.role==1? 'selected':''}>Admin</option>
                        </select>      
                    </div>
                    <div class="col-md-6">
                        <label for="status_option">Status : </label>
                        <select id="status_option" name="status" class="form-select"> 
                            <option value="0" ${user.status==0? 'selected':''}>Enable</option>
                            <option value="1" ${user.status==1? 'selected':''}>Disable</option>
                        </select>               
                    </div>
                </div>

    <div class="text-center mt-3">
<input type="hidden" name="action" value="${nextaction}">
        <button type="submit" class="red-button">Save</button>
    </div>
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
