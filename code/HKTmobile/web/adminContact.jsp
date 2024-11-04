<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>Brand Management</title>

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

        <!-- Custom CSS -->
        <style>
            .custom-table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
                font-size: 18px;
                text-align: left;
            }

            .custom-table th, .custom-table td {
                border: 1px solid #ddd;
                padding: 12px;
            }

            .custom-table th {
                background-color: #D10024;
                color: white;
            }

            .custom-table tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            .custom-table tr:hover {
                background-color: #ddd;
            }

            .custom-container {
                padding: 20px;
                background-color: #f9f9f9;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .custom-container form {
                margin-bottom: 20px;
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
            <div class="container custom-container">
                <!-- row -->
                <div class="row">
                    <div class="col-md-12">
                        <form>
                            <table class="custom-table">
                                <thead>
                                    <tr>
                                        <th>ContactID</th>
                                        <th>Date</th>
                                        <th>UserID</th>
                                        <th>Message</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${contactDto}" var="contact">
                                        <tr>
                                            <td>${contact.contactID}</td>
                                            <td>${contact.date}</td>
                                            <td><a href="userController?action=detail&userId=${contact.userID}">${contact.userID}</a></td>
                                            <td>${contact.message}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
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
