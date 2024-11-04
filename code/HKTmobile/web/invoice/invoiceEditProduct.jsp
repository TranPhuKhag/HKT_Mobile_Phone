<%-- 
    Document   : invoiceEditProduct
    Created on : Jul 7, 2024, 10:28:12 PM
    Author     : Administrator
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        ProductName : 
        <c:forEach items="${product}" var="product">
            ${product.productID}
            ${product.groupID}
            <c:forEach items="${product.productGroup}" var="productGroup">
                <p>${productGroup.productName}</p>
            </c:forEach>
                
        </c:forEach>
                
                    
    </body>
</html>
