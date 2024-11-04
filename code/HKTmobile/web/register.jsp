<%-- 
    Document   : register
    Created on : Jun 10, 2024, 11:00:43 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>Register Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

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
        <link rel="stylesheet" href="css/main.css"/>
        <!-- TOP HEADER -->
    <div id="top-header">
        <div class="container">
            <div class="header-contact">
                <ul class="header-links pull-left ">
                    <li><a href="#"><i class="fa fa-phone"></i> +012-34-56-78</a></li>
                    <li><a href="#"><i class="fa fa-envelope-o"></i> email@email.com</a></li>
                    <li><a href="#"><i class="fa fa-map-marker"></i> FPT University</a></li>
                </ul>
            </div>

            <div class="header-links pull-right" style=" margin-top: 7px;">
                <c:if test="${sessionScope.usersession == null}">
                    <div class="header__action">
                        <ul >
                            <li ><a  href="userController">User Managerment</a></li>
                            <li ><a  href="./register.jsp">Register</a></li>
                            <li ><a  href="./login.jsp" >Login</a></li>
                        </ul>
                    </div>
                </c:if>

                </li>
            </div>
        </div>
    </div>
    <style>
    body{
   background: url("img/phone.jpg")no-repeat center center fixed;
    background-size: cover;
}
        .form-signini {
            width: 100%;
            max-width: 330px;
            padding: 15px;
            margin: auto;
        }

        .form-signini .checkbox {
            font-weight: 400;
        }

        .form-signini .form-floating:focus-within {
            z-index: 2;
        }
        .form-signini input[type="email"] {
            margin-bottom: -1px;
            border-bottom-right-radius: 0;
            border-bottom-left-radius: 0;
        }

        .form-signini input[type="password"] {
            margin-bottom: 10px;
            border-top-left-radius: 0;
            border-top-right-radius: 0;
        }

        bodyi{
            background-size: cover;
        }
        .imgHKT{
            border-radius: 40%;
            width: 9%;
            height: 0%;
        }
        .bd-placeholder-img {
            font-size: 1.125rem;
            text-anchor: middle;
            -webkit-user-select: none;
            -moz-user-select: none;
            user-select: none;
        }

        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        } 
        .h1{
            font-size: 3rem;
            margin-top: 0;
        }
        .h2{
            font-size: 2rem;
        }
        .login{
            width: 100%;
            height: 31px;
        }
        .menu{
            padding-top: 30px;
            padding-bottom: 30px ;

        }
        .form-floating{
            padding-bottom: 10px;
        }
    </style>
</head>
<body style="text-align: center">


    <div class="container menu" >


        <img class="imgHKT"  src="img/logo2.png" alt="" width="72" height="57">
        <h1 class="h3 mb-3 fw-normal h1" style="color:red"  >Register</h1>


        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) {%>
        <h3 style="color: red"> <%= error%> </h3>
        <% }%>

        <div class="form-signini">

            <form action="./registerController" name="" method="POST" >



                <div class="form-floating">
                    <input type="text" class="form-control" id="fullname" name="fullname" placeholder="Full Name"required>
                    <label for="fullname">Full Name</label>
                </div>

                <div class="form-floating">
                    <input type="email" class="form-control" id="email" name="email" placeholder="Email"required>
                    <label for="email">Email</label>
                </div>

                <div class="form-floating">

                    <input type="text" class="form-control" id="phone" name="phone" placeholder="Phone Number"required>
                    <label for="phone">Phone</label>
                </div>

                <div class="form-floating">

                    <input type="text" class="form-control" id="username" name="username" placeholder="User name"required>
                    <label for="username">Username</label>
                </div>
                <div class="form-floating">

                    <input type="text" class="form-control" id="password" name="password" placeholder="Password"required>
                    <label for="password">Password</label>
                </div>

                <div class="form-floating">

                    <input type="text" class="form-control" id="reconfirm" name="reconfirm" placeholder="Reconfirm Password"required>
                    <label for="reconfirm">Reconfirm Password</label>
                </div>




                <input  class="btn btn-dark login" value="register" type="submit"> 
            </form>
         <p class="h2" style="color:#fff">If You Have An Account<br><a style="color: red" href='login.jsp'>Click Here to Login</a></p>



            <!-- /row -->
        </div>
        <!-- /container -->
    </div>
    <!-- /SECTION -->

</body>
</html>
