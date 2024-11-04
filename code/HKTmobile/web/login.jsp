<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>Login Page</title>
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
        <link type="text/css" rel="stylesheet" href="css/siin.css"/>


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
                        <ul>
                            <li ><a  href="./register.jsp">Register</a></li>
                            <li ><a  href="./login.jsp" >Login</a></li>
                        </ul>
                    </div>



                </c:if>

                <c:if test="${sessionScope.usersession != null}">                     
                    <div class="user__auth-container">
                        <ul>
                            <li><a href="#"><i class="fa fa-list"></i> Your Order</a></li>
                            <li>
                                <p class="user__auth">Hello, ${sessionScope.usersession.fullname}<i class='bx bxs-chevron-down-circle'></i></p>
                                <ul class="header__menu__dropdown">
                                    <li><a href="./profile.jsp">Profile</a></li>
                                    <li><a href="login?action=logout">Log Out</a></li>
                                </ul>
                            </li>

                        </ul>

                    </div>   

                </c:if></li>
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
            background: url("/img/phone.jpg")no-repeat center center fixed;
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

        }
    </style>
</head>
<body style="text-align: center">


    <div class="container menu" >

        <a href="Homepage" >
        <img class="mb-4 imgHKT"  src="img/logo2.png" alt="" width="72" height="57"></a>
        <h1 class="h3 mb-3 fw-normal h1" style="color:red"  > Sign in</h1>
        <div>
            <c:if test="${!empty error}">
                <h3 style="color: red"> ${error} </h3>
            </c:if>

            <div class="form-signini">
                <form action="./login" name="" method="POST" >
                    

                        <div class="form-floating">
                            <input type="text" name="user" value="${username!=null? username:""}" class="form-control" id="user" placeholder="Username" required="">
                            <label for="user">Username</label>
                        </div>
                        <br>
                        <div class="form-floating">
                            <input type="password" name="password" class="form-control" id="password" placeholder="Password" required="">
                            <label for="password">Password</label>
                        </div>



                    <input class="btn btn-dark login"value="Login" type="submit">
                </form>



                            <p class="h2" style="color:#fff">Don't Have Account?<br><a style="color: red" href='register.jsp'>Click Here to Register</a></p>
            </div>



        </div>

    </div>


    <!-- jQuery Plugins -->
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/slick.min.js"></script>
    <script src="js/nouislider.min.js"></script>
    <script src="js/jquery.zoom.min.js"></script>
    <script src="js/main.js"></script>

</body>
</html>
