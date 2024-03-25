<%-- 
    Document   : login
    Created on : 06-Oct-2023, 6:55:35 PM
    Author     : wankh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login - MyCart</title>
        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>      
        <%@include file="components/navbar.jsp" %>
        <div class="container-fluid">
            <div class="row mt-5">
                <div class="col-md-4 offset-md-4">

                    <div class="card">

                        <div class="card-header custom-bg text-white" style="background-color: #536DFE">
                            <h3>Login here..</h3>
                        </div>

                        <div class="card-body">
                            <%@include file="components/message.jsp" %>
                            <form action="LoginServlet" method="post">
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Email address</label>
                                    <input type="email" name="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
                                    <small id="emailHelp" class="form-text text-muted"></small>
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputPassword1">Password</label>
                                    <input type="password" name="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
                                </div>
                                <a href="register.jsp">If not registered click here.</a>
                                <div class="container text-center">
                                    <button type="submit" class="btn btn-primary custom-bg">Submit</button>
                                </div>
                            </form> 
                        </div>    

                    </div> 

                </div>
            </div>
    </body>
</html>
