<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- FOOTER -->
<footer id="footer">
    <!-- top footer -->
    <div class="section">
        <!-- container -->
        <div class="container">
            <!-- row -->
            <div class="row">
                <div class="col-md-3 col-xs-6">
                    <div class="footer">
                        <h3 class="footer-title">About Us</h3>
                        <p>At HKT Mobile, we are dedicated to bringing you the latest and greatest in mobile technology. Established with a vision to provide top-quality smartphones and accessories at competitive prices, we have quickly become a trusted name in the mobile retail industry.</p>
                        <ul class="footer-links">
                    <li><a href="#"><i class="fa fa-phone"></i> +012-34-56-78</a></li>
                    <li><a href="#"><i class="fa fa-envelope-o"></i> email@email.com</a></li>
                    <li><a href="#"><i class="fa fa-map-marker"></i> FPT University</a></li>
                        </ul>
                    </div>
                </div>

                <div class="col-md-3 col-xs-6">
                    <div class="footer">
                        <h3 class="footer-title">Categories</h3>
                        <ul class="footer-links">
                            <li><a href="Homepage">Home</a></li>
                            <li><a href="Store">Store</a></li>
                <li><a href="./Store?BrandName=Samsung">Samsung</a></li>
                <li><a href="./Store?BrandName=Apple">Apple</a></li>
                        </ul>
                    </div>
                </div>

                <div class="clearfix visible-xs"></div>

                <div class="col-md-3 col-xs-6">
                    <div class="footer">
                        <h3 class="footer-title">Information</h3>
                                          <c:set var="user" value="${sessionScope.usersession}"></c:set>

                                  

                        <ul class="footer-links">

                            <li><a href="aboutus.jsp">About Us</a></li>
                      <li><a href="userContact.jsp">Contact Us</a></li>
    <c:if test="${user.role==1}"> 
                            <li><a href="userController">User Managerment</a></li>
                            <li><a href="invoiceController">Invoice Managerment</a></li>
                            <li><a href="Admin">ProductManagement</a></li>
                                            </c:if> 

                        </ul>
                    </div>
                </div>  <c:set var="user" value="${usersession}"></c:set>
             

                <div class="col-md-3 col-xs-6">
                    <div class="footer">
                        <h3 class="footer-title">Service</h3>
                        <ul class="footer-links">

                            <li><a href="AccountController?action=details&id=${usersession.userID}">My Account</a></li>


                            <li><a href="cartList.jsp">View Cart</a></li>

                            <li><a href="ContactController?action=view&userID=${usersession.userID}">View Message</a></li>   
                            
                            <li><a href="Order?action=orderList&userId=${sessionScope.usersession.userID}">Order List</a></li>
                            <c:if test="${user.role==1}"> 
                             <li><a href="Admin?action=contactManagement">Message Management</a></li>
</c:if>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- /row -->
        </div>
        <!-- /container -->
    </div>
    <!-- /top footer -->

    <!-- bottom footer -->
    <div id="bottom-footer" class="section">
        <div class="container">
            <!-- row -->
            <div class="row">
                <div class="col-md-12 text-center">
                    <ul class="footer-payments">
                        <li><a href="#"><i class="fa fa-cc-visa"></i></a></li>
                        <li><a href="#"><i class="fa fa-credit-card"></i></a></li>
                        <li><a href="#"><i class="fa fa-cc-paypal"></i></a></li>
                        <li><a href="#"><i class="fa fa-cc-mastercard"></i></a></li>
                        <li><a href="#"><i class="fa fa-cc-discover"></i></a></li>
                        <li><a href="#"><i class="fa fa-cc-amex"></i></a></li>
                    </ul>
                    <span class="copyright">
                        <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                        Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                        <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                    </span>


                </div>
            </div>
            <!-- /row -->
        </div>
        <!-- /container -->
    </div><script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <!-- /bottom footer -->
</footer>
<!-- /FOOTER -->