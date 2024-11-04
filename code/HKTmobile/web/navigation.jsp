<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- NAVIGATION -->
<nav id="navigation">
    <!-- container -->
    <div class="container">
        <!-- responsive-nav -->
        <div id="responsive-nav">
            <!-- NAV -->
            <ul class="main-nav nav navbar-nav">
                <li ><a href="Homepage">Home</a></li>
                <li><a href="Store">Store</a></li>
                <li><a href="./Store?BrandName=Samsung">Samsung</a></li>
                <li><a href="./Store?BrandName=Apple">Apple</a></li>
                <c:set var="user" value="${usersession}"></c:set>
                <c:if test="${user.role==1}"> 
                <li><a href="userController">User Management</a></li>
                 <li><a href="invoiceController">Invoice Management</a></li>
                <li><a href="./Admin">ProductManagement</a></li>
                <li><a href="./Brand">BrandManagement</a></li>

                </c:if> 
                 <c:if test="${usersession!=null}"> 
                <li><a href="Order?action=orderList&userId=${sessionScope.usersession.userID}">Order List</a></li>
                </c:if> 


                

            </ul>
            <!-- /NAV -->
        </div>
        <!-- /responsive-nav -->
    </div>
    <!-- /container -->
</nav>
<!-- /NAVIGATION -->