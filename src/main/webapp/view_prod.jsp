<%-- 
    Document   : view_prod
    Created on : 16-Feb-2024, 10:28:38 AM
    Author     : wankh
--%>

<%@page import="com.learn.mycart.dao.ProductDao"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="com.learn.mycart.entities.Category"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>products</title>
        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>
        <%
            CategoryDao dao = new CategoryDao(FactoryProvider.getFactory());
            List<Category> list = dao.getCategories();
            ProductDao pDao = new ProductDao(FactoryProvider.getFactory());

        %>

    <body>
        <%@include file="components/navbar.jsp" %>
        <div class="cotainer-fluid mt-3 text-center">
            <%@include file="components/message.jsp" %>
            <h3 class="fw-bolder display-6">List of Category-Products</h3>
        </div>
        <div class="container mt-3" >
            <table class="table table-hover table-bordered">
                <thead class="table-info">
                    <tr>
                        <th scope="col">Category Id</th>
                        <th scope="col">Category Name</th>
                        <th scope="col">No of Products</th>
                    </tr>
                </thead>
                <tbody>
                    <%                        for (Category l : list) {
                    %>
                    <tr>
                        <td><%= l.getCategoryId()%></td>
                        <td><%= l.getCategoryTitle()%></td>
                        <td><%= pDao.numOfProd(l.getCategoryId())%></td>
                    </tr>
                    <% }
                    %>


                </tbody>
            </table>
        </div>
    </body>
</html>
