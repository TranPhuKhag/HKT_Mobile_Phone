<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Edit Password</title>

    <!-- Google font -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

    <!-- Bootstrap -->
    <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>

    <!-- Custom stylesheet -->
    <link type="text/css" rel="stylesheet" href="css/style.css"/>

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
<body>		        <jsp:include page="header.jsp"/>
        <jsp:include page="navigation.jsp"/>
    
    <div class="section">
        <div class="container">
            <div class="row">
                <div class="col-md-12 user-details-section">
                    <form class="user-details-form" action="AccountController" method="POST">
                        <table class="user-details-table">
                            <tr>
                                <td>Password :</td>
                                <td><input name="password" value="${object.password}"></td>
                            </tr>
                            <tr>
                                <td colspan="2" style="text-align: center;">
                                    <input type="hidden" name="id" value="${requestScope.object.userID}">
                                    <input type="hidden" name="action" value="${nextaction}">
                                    <input type="submit" value="Save">
                                </td>
                            </tr>
                        </table>
                    </form>
                    <a class="user-details-link" href="Homepage">Home Page</a>
                </div>
            </div>
        </div>
    </div>
<jsp:include page="footer.jsp"/>
    <!-- jQuery Plugins -->
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>
