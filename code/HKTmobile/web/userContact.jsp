<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>Contact Us</title>

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

        <!-- Custom stylesheet -->
        <link type="text/css" rel="stylesheet" href="css/style.css"/>

        <style>
            /* General form styling */
            .custom-form {
                background: #f9f9f9;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
                font-family: 'Montserrat', sans-serif;
                margin-top: 20px;
            }

            /* Input field styling */
            .custom-form input[type="text"],
            .custom-form input[type="hidden"],
            .custom-form input[type="submit"] {
                width: 100%;
                padding: 10px;
                margin: 10px 0;
                border: 1px solid #ddd;
                border-radius: 5px;
            }

            /* Submit button styling */
            .custom-form input[type="submit"] {
                background-color: #D10024;
                color: white;
                border: none;
                cursor: pointer;
                font-size: 16px;
            }

            /* Submit button hover effect */
            .custom-form input[type="submit"]:hover {
                background-color: #D10024;
            }

            /* Table styling */
            .custom-form table {
                width: 100%;
                margin-top: 10px;
            }
        </style>

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->

    </head>
    <body>
        <!-- HEADER -->
        <jsp:include page="header.jsp"/>
        <jsp:include page="navigation.jsp"/>

        <!-- SECTION -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <div class="col-md-12">                        
                        <form class="custom-form" action="ContactController" method="POST">
                            <input type="hidden" name="action" value="view">
                            <input type="hidden" name="userID" value="${usersession.userID}">
                            <table>
                                <input type="submit" value="View">
                            </table>
                        </form>
                        <form class="custom-form" action="ContactController" method="POST">
                            <input type="text" name="message" placeholder="Enter your message">
                            <input type="hidden" name="action" value="contact">
                            <input type="hidden" name="userID" value="${usersession.userID}">
                            <table>
                                <input type="submit" value="Send">
                            </table>
                        </form>


                    </div>
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /SECTION -->

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
