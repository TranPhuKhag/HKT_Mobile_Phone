    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!-- HEADER -->
<header>
    <link type="text/css" rel="stylesheet" href="css/style.css"/>
    
    <!-- TOP HEADER -->
    <div id="top-header">
        <div class="container">
            <div class="header-contact">
                <ul class="header-links pull-left ">
                    <li><a href="#"><i class="fa fa-phone"></i> +012-34-56-78</a></li>
                    <li><a href="#"><i class="fa fa-envelope-o"></i> HKTmobile@email.com</a></li>
                    <li><a href="#"><i class="fa fa-map-marker"></i> FPT University</a></li>
                </ul>
            </div>

            <div class="header-links pull-right" style=" margin-top: 7px;">
                <c:if test="${sessionScope.usersession == null}">
                    <div class="header__action">
                        <ul >
                            <li ><a  href="./register.jsp">Register</a></li>
                            <li ><a  href="./login.jsp" >Login</a></li>
                        </ul>
                    </div>



                </c:if>

                <c:if test="${sessionScope.usersession != null}">                     
                    
                        <ul>

                            <li><div class="user__auth-container">
                                <p class="user__auth">Hello, ${sessionScope.usersession.fullname}<i class='bx bxs-chevron-down-circle'></i></p>
                                <ul class="header__menu__dropdown">
                                    <li><a href="AccountController?action=details&id=${sessionScope.usersession.userID}">My Account</a></li>
                                    <li><a href="login?action=logout">Log Out</a></li>
                                </ul>
                                 </div>  
                            </li>

                        </ul>

                    

                </c:if></li>
            </div>
        </div>
    </div>
    <!-- /TOP HEADER -->

    <!-- MAIN HEADER -->
    <div id="header">
        <!-- container -->
        <div class="container">
            <!-- row -->
            <div class="row">
                <!-- LOGO -->
                <div class="col-md-3">
                    <div class="header-logo">
                        <a href="./Homepage" class="logo">
                            <img src="./img/logo.png" alt="">
                        </a>
                    </div>
                </div>
                <!-- /LOGO -->

                <!-- SEARCH BAR -->
                <div class="col-md-6">
                    <div class="header-search" >
                     
                      <form action="${usersession.role==1?'Admin':'Store'}" method="POST"style="display: flex;">

                            <i class="input-select fa fa-search" style="
                               width: 100px; 
                               margin-bottom: 10px; 
                               text-align: center; 
                               display: flex; 
                               align-items: center; 
                               justify-content: 
                               center;
                               background-color: #D10024;
                               color: #FFF;
                               font-weight: 700;
                               border: none;"></i>

                            <input class="input" type="text" name="keyword" placeholder="Search here">
                            <input class="search-btn" type="submit" name="action" value="Search">
                        </form>
                        
                        
                        
                        
                        
                        
                    </div>
                </div>
                <!-- /SEARCH BAR -->

                <!-- ACCOUNT -->
                <div class="col-md-3 clearfix">
                    <div class="header-ctn">
 

                        <!-- Cart -->
                        <div class="dropdown">
                            
                            <c:set var="size" value="${sessionScope.size}"/>
                                            <c:set var="user" value="${usersession}"></c:set>

                            <a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
                            <c:if test="${user!=null}"> 
                                
                                 <a href="cartList.jsp">
                                         <i class="fa fa-shopping-cart" > </i>
                                     <span>Your Cart</span>
                                     <div class="qty">${size}</div>                        
                                 </a>
                                 </c:if>                
                            </a>                  
                            <div class="cart-dropdown">
                                <div class="cart-list">
                                    <div class="product-widget">
                                        <div class="product-img">
                                            <img src="./img/product01.png" alt="">
                                        </div>
                                        <div class="product-body">
                                            <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                            <h4 class="product-price"><span class="qty">1x</span>$980.00</h4>
                                        </div>
                                        <button class="delete"><i class="fa fa-close"></i></button>
                                    </div>

                                    <div class="product-widget">
                                        <div class="product-img">
                                            <img src="./img/product02.png" alt="">
                                        </div>
                                        <div class="product-body">
                                            <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                            <h4 class="product-price"><span class="qty">3x</span>$980.00</h4>
                                        </div>
                                        <button class="delete"><i class="fa fa-close"></i></button>
                                    </div>
                                </div>
                                <div class="cart-summary">
                                    <small>3 Item(s) selected</small>
                                    <h5>SUBTOTAL: $2940.00</h5>
                                </div>
                                <div class="cart-btns">
                                    <a href="#">View Cart</a>
                                    <a href="#">Checkout  <i class="fa fa-arrow-circle-right"></i></a>
                                </div>
                            </div>
                        </div>
                        <!-- /Cart -->

                        <!-- Menu Toogle -->
                        <div class="menu-toggle">
                            <a href="#">
                                <i class="fa fa-bars"></i>
                                <span>Menu</span>
                            </a>
                        </div>
                        <!-- /Menu Toogle -->
                    </div>
                </div>
                <!-- /ACCOUNT -->
            </div>
            <!-- row -->
        </div>
        <!-- container -->
    </div>
    <!-- /MAIN HEADER -->
</header>
<!-- /HEADER -->