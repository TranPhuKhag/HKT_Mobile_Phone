
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Product list</title>

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
        <link type="text/css" rel="stylesheet" href="css/main.css"/>
        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
        <script>
            var PminO = "${Pmin != null && !Pmin.equals('') ? Pmin : '1'}";
            var PmaxO = "${Pmax != null && !Pmax.equals('') ? Pmax : '2000'}";
            var CurrentPageO = "${currentPage != null && !currentPage.equals('') ? currentPage : '1'}";
            var TotalPagesO = "${totalPages != null && !totalPages.equals('') ? totalPages : '1'}";
            var TotalProductsO = "${totalProducts != null && !totalProducts.equals('') ? totalProducts : '1'}";
            var PageSizeO = "${PageSize != null && !PageSize.equals('') ? PageSize : '9'}";
        </script>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

    </head>
    <body>
        <!-- HEADER -->
        <jsp:include page="header.jsp" flush="true"/> 
        <jsp:include page="navigation.jsp" flush="true"/>

        <!-- SECTION -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <!-- ASIDE -->
                    <form method="POST" id="myForm">
                        <div id="aside" class="col-md-3">


                            <!-- aside Widget -->
                            <div class="aside">
                                <h3 class="aside-title">Brand</h3>
                                <c:set var="total" value="0" />
                                <c:forEach var="Brand" items="${Brandlist}">
                                    <c:set var="total" value="${total + Brand.number}" />
                                </c:forEach>
                                <div class="checkbox-filter"> 
                                    <div class="input-checkbox" style="margin: 10px; font-size: 20px;">
                                        <input type="radio" name="BrandName" value="All" checked onclick="submitFormToSearch()"/>
                                        All
                                        <small>(${total})</small>
                                    </div>
                                    <c:forEach var="Brand" items="${Brandlist}">
                                        <div class="input-checkbox" style="margin: 10px; font-size: 20px;">
                                            <input type="radio" name="BrandName" value="${Brand.brandName}" ${BrandName != null && BrandName.equals(Brand.brandName) ? 'checked' : ''} onclick="submitFormToSearch()"/>

                                            ${Brand.brandName}
                                            <small>(${Brand.number})</small>
                                        </div>
                                    </c:forEach>
                                </div>
                                <h3 class="aside-title">Details</h3>
                                <div style="font-size:20px;">                                                                 
                                    <label for="RAM-select" style="font-size:20px;">RAM:</label>
                                    <select name="Ram" id="RAM-select" onchange="submitFormToSearch()">
                                        <option value="">--</option>
                                        <option value="4" ${Ram != null && Ram.equals("4") ? 'selected' : ''}>4GB</option>   
                                        <option value="6" ${Ram != null && Ram.equals("6") ? 'selected' : ''}>6GB</option>   
                                        <option value="8" ${Ram != null && Ram.equals("8") ? 'selected' : ''}>8GB</option>     
                                        <option value="12" ${Ram != null && Ram.equals("12") ? 'selected' : ''}>12GB</option>   
                                    </select>
                                </div>
                                <div style="font-size:20px;">                                                                 
                                    <label for="Storage-select" style="font-size:20px;">Storage:</label>
                                    <select name="Storage" id="Storage-select" onchange="submitFormToSearch()">
                                        <option value="">--</option>
                                        <option value="64" ${Storage != null && Storage.equals("64") ? 'selected' : ''}>64GB</option>   
                                        <option value="128" ${Storage != null && Storage.equals("128") ? 'selected' : ''}>128GB</option>   
                                        <option value="256" ${Storage != null && Storage.equals("256") ? 'selected' : ''}>256GB</option>     
                                        <option value="512" ${Storage != null && Storage.equals("512") ? 'selected' : ''}>512GB</option>   
                                    </select>
                                </div>

                            </div>
                            <!-- /aside Widget -->

                            <!-- aside Widget -->
                            <div class="aside">
                                <h3>Price</h3>
                                <div class="price-filter">
                                    <div id="price-slider"></div>
                                    <div class="input-number price-min" >
                                        <input id="price-min" type="number" name="pricemin" >
                                        <span class="qty-up">+</span>
                                        <span class="qty-down">-</span>
                                    </div>
                                    <span>-</span>
                                    <div class="input-number price-max">
                                        <input id="price-max" type="number" name="pricemax" >
                                        <span class="qty-up">+</span>
                                        <span class="qty-down">-</span>
                                    </div>
                                </div>

                            </div>     
                            <div>
                                <h3>Name</h3>
                                <input type="text" name="keyword" value="${keyword}" placeholder="Search name" style="width: 262px; height: 40px;" >
                            </div>
                            <div>
                                <input name="action" type="hidden" value="Search">
                                <button class="custom-button" style="width: 82px;height: 42px;" onclick="submitFormToSearch()"> Search</button>
                            </div>
                            <!-- /aside Widget -->
                        </div>
                        <!-- /ASIDE -->

                        <!-- STORE -->
                        <div id="store" class="col-md-9">
                            <!-- store top filter -->
                            <div class="store-filter clearfix">
                                <div class="store-sort">
                                    <label>
                                        Sort By:
                                        <select name="sortBy" class="input-select">
                                            <option value="">----</option>
                                            <option value="Price" ${SortBy != null && SortBy.equals("Price") ? 'selected' : ''}>Price</option>
                                            <option value="Discount" ${SortBy != null && SortBy.equals("Discount") ? 'selected' : ''}>Discount</option>
                                            <option value="BrandID" ${SortBy != null && SortBy.equals("BrandID") ? 'selected' : ''}>Brand</option>
                                        </select>
                                    </label>
                                    <label>
                                        Sort Type:
                                        <select name="SortType" class="input-select"onchange="submitFormToSearch()">
                                            <option value="">----</option>
                                            <option value="ASC" ${SortType != null && SortType.equals("ASC") ? 'selected' : ''}>ASC</option>
                                            <option value="DESC" ${SortType != null && SortType.equals("DESC") ? 'selected' : ''}>DESC</option>
                                        </select>
                                    </label><label>
                                        <c:choose>
                                            <c:when test="${empty Grouplist}">
                                                <h3>Not Found</h3>
                                            </c:when>
                                            <c:otherwise>

                                                <h3>Has found ${totalProducts} products</h3>

                                            </c:otherwise>
                                        </c:choose></label>
                                </div>
                                <ul class="store-grid">
                                    <li class="active"><i class="fa fa-th"></i></li>
                                </ul>
                            </div>
                            <!-- /store top filter -->

                            <!-- store products -->
                            <div class="row">
                                <!-- product -->

                                <c:if test="${!empty Grouplist}">


                                    <c:forEach var="productGroup" items="${Grouplist}">
                                        <c:if test="${!empty productGroup.products}">
                                            <div class="col-md-4 col-xs-6">
                                                <div class="product product-store">
                                                    <div class="product-img store-img">
                                                        <img src="${productGroup.img}" alt="product img">
                                                        <c:if test="${productGroup.discount!=0}">
                                                            <div class="product-label">
                                                                <span class="sale" style="font-size: 15px;">${productGroup.discount}%</span>
                                                            </div>
                                                        </c:if>
                                                    </div>
                                                    <div class="product-body store-body">
                                                        <p class="product-category">${productGroup.brandName}</p>
                                                        <h3 class="product-name" style="height: 50px;"><a href="./Product?id=${productGroup.products[0].productID}">${productGroup.productName}</a></h3>
                                                            <c:choose>
                                                                <c:when test="${productGroup.discount!=0}">
                                                                <h4 class="product-price">$${productGroup.products[0].newPrice} <del class="product-old-price">$${productGroup.products[0].price}</del></h4>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <h4 class="product-price">$${productGroup.products[0].price}</h4>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>

                                    </c:forEach>
                                </c:if>
                                <!-- /product -->
                            </div>
                            <!-- /store products -->

                            <!-- store bottom filter -->
                            <c:choose>
                                <c:when test="${!empty Grouplist}">
                                    <div class="page-btn">
                                        <button style="width: 80px;" class="page-button" type="button" id="prevButton" onclick="goToPreviousPage()">Previous</button>
                                        <div id="pageButtons"></div>
                                        <button style="width: 80px;" class="page-button" type="button" id="nextButton" onclick="goToNextPage()">Next</button>
                                    </div>
                                </c:when>
                            </c:choose>

                            <!-- /store bottom filter -->
                        </div>
                        <!-- /STORE -->
                    </form>
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /SECTION -->

        <jsp:include page="footer.jsp" flush="true"/>

        <!-- jQuery Plugins -->
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/slick.min.js"></script>
        <script src="js/nouislider.min.js"></script>
        <script src="js/jquery.zoom.min.js"></script>
        <script src="js/main.js"></script>
        <script src="js/pagination.js"></script>

        <script type="text/javascript">
                                            function buy(id) {
                                                document.f.action = "buy?id=" + id;
                                                document.f.submit();
                                            }
        </script>

    </body>
</html>
