<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>Account</title>

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


        <!-- Custom styles for user details -->
        <style>
            .user-details-section {
                background: #f9f9f9;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
                font-family: 'Montserrat', sans-serif;
                margin-top: 20px;
            }

            .user-details-table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }

            .user-details-table td {
                padding: 10px;
                border-bottom: 1px solid #ddd;
            }

            .user-details-table td:first-child {
                font-weight: bold;
                color: #333;
                width: 30%;
            }

            .user-details-table td:last-child {
                color: #666;
            }

            .user-details-form {
                text-align: center;
                margin-bottom: 20px;
            }

            .user-details-form input[type="submit"] {
                background-color: #D10024;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
            }

            .user-details-form input[type="submit"]:hover {
                background-color: #D10024;
            }

            .user-details-link {
                display: block;
                text-align: center;
                margin-top: 20px;
                color: #D10024;
                text-decoration: none;
                font-size: 16px;
            }

            .user-details-link:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <jsp:include page="navigation.jsp"/>
        <div class="section">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 user-details-section">
                        <table class="user-details-table">
                            <tr><td>Full Name :</td><td>${requestScope.object.fullname}</td></tr>
                            <tr><td>Email :</td><td>${requestScope.object.email}</td></tr>
                            <tr><td>Phone :</td><td>${requestScope.object.phone}</td></tr>
                            <tr><td>User Name :</td><td>${requestScope.object.username}</td></tr>
                            <tr><td>Password :</td><td>${requestScope.object.password}</td></tr>
                        </table>

                        <form class="user-details-form" action="AccountController">
                            <input type="hidden" name="id" value="${requestScope.object.userID}">
                            <input type="hidden" name="action" value="editAccount">
                            <input type="submit" value="Edit Account">
                        </form>
                        <form class="user-details-form" action="AccountController">
                            <input type="hidden" name="id" value="${requestScope.object.userID}">
                            <input type="hidden" name="action" value="edit">
                            <input type="submit" value="Edit Password">
                        </form>


                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp"/>

        <!-- jQuery Plugins -->
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/slick.min.js"></script>
        <script src="js/nouislider.min.js"></script>
        <script src="js/jquery.zoom.min.js"></script>
        <script src="js/main.js"></script>
    </body>
</html>
