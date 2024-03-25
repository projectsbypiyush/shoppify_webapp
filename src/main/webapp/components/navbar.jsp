<%@page import="com.learn.mycart.entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    User user1 = (User) session.getAttribute("current-user");
%>


<nav class="navbar navbar-expand-lg navbar-dark custom-bg"style="background-color: #536DFE">
    <div class="container">
        <a class="navbar-brand" href="index.jsp"><i class="fa-brands fa-shopify fa-xl" style="color: #FFD43B;"></i></i>   Shoppify</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="index.jsp"><i class="fa-solid fa-house-user"></i> Home <span class="sr-only">(current)</span></a>
                </li>
                
               
<!--                <li class="nav-item active">
                    <a class="nav-link" href="admin.jsp">Admin</a>
                </li>-->
            </ul>


            <ul class="navbar-nav ml-auto">
                
                
                
                <% if (user1 == null) {
                %>
                <li class="nav-item active">
                    <a class="nav-link" href="#" data-toggle="modal" data-target="#cartModal"> <i class="fa-solid fa-cart-shopping" style="color: #FFD43B;"></i> <span class="ml-0 cart-items">(0)</span> </a>
                </li>
                
                <li class="nav-item active">
                    <a class="nav-link" href="login.jsp"><i class="fa-solid fa-arrow-right-from-bracket"></i> Login</a>
                </li>

                <li class="nav-item active">
                    <a class="nav-link" href="register.jsp"><i class="fa-solid fa-user-plus"></i> Register</a>
                </li>
                

                <% } else  {

                %> 
                <li class="nav-item active">
                    <a class="nav-link" href="<%= user1.getUserType().equals("admin")?"admin.jsp" : "normal.jsp" %>"> <i class="fa-solid fa-user"></i> <%= user1.getUserName()%></a>
                </li>

                <li class="nav-item active">
                    <a class="nav-link" href="LogoutServlet"><i class="fa-solid fa-arrow-right-from-bracket"></i> Logout</a>
                </li>
                
                <li class="nav-item active">
                    <a class="nav-link" href="#" data-toggle="modal" data-target="#cartModal"> <i class="fa-solid fa-cart-shopping" style="color: #FFD43B;"></i> <span class="ml-0 cart-items">(0)</span> </a>
                </li>
                <% }%>   
            </ul>
            
        </div>
    </div>  
</nav>