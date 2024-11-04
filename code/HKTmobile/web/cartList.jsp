<!DOCTYPE html>
<html lang="en">
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>Shopping Cart</title>
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
        <link type="text/css" rel="stylesheet" href="css/cart.css"/>


        <style>
        
        </style>
    </head>
    <body>
   <jsp:include page="/header.jsp"/>
        <jsp:include page="/navigation.jsp"/>

<div class="container">
        <h1 style="text-align: center">User Managerment</h1>





        <div class="">




            <div class=" col-md-8">

                <table border="1" class="table">
                    <thead>
                        <tr class="head">
                            <th>NO</th>
                            <th>Hinh Anh</th>
                            <th>ProductID</th>
                            <th>ProductName</th>
                            <th>Ram</th>
                            <th>Stotage</th>
                            <th>Color</th>
                            <th>Quantity</th>
                            <th>Price</th>
                            <th>Money</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <c:set var="t" value="0"/>
                    <c:set var="cart" value="${sessionScope.cart}"/>

                    <c:set var="soluong" value="0"/>
                    <c:set var="tong" value="0"/>
                    <c:forEach var="i" items="${cart.items}">

                        <tbody>
                            <tr style="text-align: center">
                                <c:set var="t" value="${t+1}"/>

                                <td style="font-size: 2rem; ">${t}</td>
                                <td>
                                    <img class="product-img" src="${i.product.productImg[0].getImg()}"></img>
                                </td>



                                <td style="font-size: 1.5rem; ">${i.product.productID}</td>
                                <td>${i.product.productName}</td>
                                <td>${i.product.ram}</td>
                                <td>${i.product.storage}</td>
                                <td>${i.product.color}</td>

                                <td style="display: flex">
                                    <form action="process" method="get">
                                        <input type="hidden" name="action" value="quantity"/>
                                        <input type="hidden" name="num" value="-1"/>
                                        <input type="hidden" name="id" value="${i.product.productID}"/>
                                        <button type="submit"  class="btn btn-light button_quantity">-</button>
                                    </form>
                                    ${i.quantity}
                                    <form action="process" method="get">
                                        <input type="hidden" name="action" value="quantity"/>
                                        <input type="hidden" name="num" value="1"/>
                                        <input type="hidden" name="id" value="${i.product.productID}"/>
                                        <button type="submit" class="btn btn-light button_quantity">+</button>
                                    </form>


                                </td>
                                <td>${i.product.newPrice}</td>
                                <td>${i.quantity*i.product.newPrice}</td>
                                <td style="text-align: center">
                                    <form action="process" method="post">
                                        <input type="hidden" name="action" value="delete"/>
                                        <input type="hidden" name="id" value="${i.product.productID}"/>
                                        <button type="submit" class="close">X</button>
                                    </form>
                                </td>
                            </tr>
                        </tbody>
                        <c:set var="soluong" value="${soluong+i.quantity}"/>
                        <c:set var="tong" value="${tong+(i.quantity*i.product.newPrice)}"/>


                    </c:forEach>

                </table>

            </div>


            <div class="col-md-4" >
                <div class="container">
                <table border="1" class="table">
                    <thead>
                        <tr>
                            <th>Number product</th>
                            <th> Total </th>
                        </tr>
                    </thead>
                    <tbody class="table-active">
                        <tr>
                            <td>${soluong}</td>
                            <td>${tong}</td>
                        </tr>
                    </tbody>
                </table>
                <form action="process" method="get">
                    <input type="hidden" name="cart" value=""/>
                    
                    
                    
                    <div class="row" style="font-size: 2rem">
                         <div class="col-md-6" style="display:flex">
                             <div> <label> Item :  </label></div>
                   
                             <div><p >    ${t}</p>    <input type="hidden" name="amount" value="${t}" required class="form-control"></input></div>
                </div>
            </div>
                
                    <div class="row" style="font-size: 2rem" width="100%">
                <div class="col-md-6">
                    <label>Address :</label>
                    <input type="text" name="address" value="" required class="form-control add" placeholder="HCM city Quan 9 " required=""/>
                </div>
            </div>
                    
                    
                    
                    
                    
                    <br> <input type="hidden" name="action" value="check"/>  
                    <button type="submit" class="btn btn-danger">Checkout</button>
                </form>
                <br>
                <br>
                <br>
                <br>
                <div style="text-align: center">
                <button type="submit" class="btn btn-danger" style="color: #fff"><a  class="btn-link" href="./Store">back</a></button>
</div>
            </div>
            </div>





        </div>
        <p style="color: red">${message}</p>
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
