<!DOCTYPE html>
<html lang="en">
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>Admin Page</title>
<link  rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
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
        <style>
           
        </style>

    </head>
    <body>
        <jsp:include page="/header.jsp"/>
        <jsp:include page="/navigation.jsp"/>

        <h1 style="text-align: center">User Management</h1>
        <div class="container">
            <form action="userController">
                <input type="hidden" name="action" value="create">
                <button type="submit"  class="btn btn-danger">+ ADD</button>
                
            </form>
            <c:set var="no" value="${0}"></c:set>
            <div class="bd-example ">
                <table border="1" class="table">
                <thead>
                    <tr>
                        <th>UserID</th>
                        <th>Fullname</th>
                        <th>Email</th>
                        
                        <th>Username</th>
                        <th>Password</th>
                        <th>Phone</th>
                        <th>role</th>
                        <th>status</th>
                        <th>DELETE</th>
                        <th>EDIT</th>
                        <th>Detail</th>
                    </tr>
                </thead>
                <form action="userController" >

                    <c:forEach items="${list}" var="user">
                        <tbody>
                            <tr style="text-align: center" class="paging-item">
                                <td style="text-align: center">${user.userID}</td>
                                <td>${user.fullname}</td>
                                <td>${user.email}</td>
                                <td>${user.username}</td>
                                <td>${user.password}</td>
                                <td>${user.phone}</td>
                                <td>${user.role eq "1" ? 'Admin' : 'User'}</td>
                                <td>${user.status eq "1" ? 'Disable' : 'Enable'}</td>
                                <td style="text-align: center">    <form action="userController">
                                        <input type="hidden" name="action" value="delete" >
                                        <input type="hidden" name="userID" value="${user.userID}">
                                        <button type="submit"  class="fa-regular fa-trash-can btn btn-danger submit" class="btn btn-danger" style="text-align:  center"${user.userID==usersession.userID?'disabled':''}></button>
                                    </form></td>
                                <td>
                                    <form action="userController">
                                        <input type="hidden" name="action" value="edit">
                                        <input type="hidden" name="userID" value="${user.userID}">
                                        
                                        <button type="submit" class="fa-regular fa-pen-to-square btn btn-dark" ${user.userID==usersession.userID?'disabled':''}></button>
                                    </form>
                                </td>
                                <td>
                                    <form action="userController">
                                        <input type="hidden" name="action" value="detail">
                                        <input type="hidden" name="userId" value="${user.userID}">
                                        <button  type="submit" class="fa-solid fa-info btn-light"></button>
                               
                                    </form>
                                </td>
                            </tr>

                        </tbody>

                        <c:set var="no" value="${no+1}"></c:set>
                    </c:forEach>    
                        
                </form>
                
            </table>
                <p style="color: red"> Number User  : ${no}</p>
                                    <div class="center-content">                    
                            <ul class="reviews-pagination table-pagination pagination"></ul>
                        </div>
</div>
            
            <p>${message}</p>

        </div>


 <%@include file="/footer.jsp" %>

        <!-- jQuery Plugins -->
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/slick.min.js"></script>
        <script src="js/nouislider.min.js"></script>
        <script src="js/jquery.zoom.min.js"></script>
        <script src="js/main.js"></script>
        <script src="js/paginationtable.js"></script>

    </body>
</html>
