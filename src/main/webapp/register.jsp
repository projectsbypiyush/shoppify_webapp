<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New User</title>
        <%@include file="components/common_css_js.jsp" %> 
        <script>  
            function fun(){  
              var element = document.getElementById("registerForm");
              element.reset();
            }   
        </script>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        
        <div class="cotainer-fluid">
            
            <div class="row mt-5">
                <div class="col-md-4 offset-md-4">
                    <div class="card">
                        <%@include file="components/message.jsp" %>
                        
                        <div class="card-header custom-bg text-white text-center" style="background-color: #536DFE">
                            <h3>Register with Us</h3>
                        </div>
                        
                        <div class="card-body px-5">
                            
                            <form action="RegisterServlet" id="registerForm" method="POST"> 

                                <div class="form-group">
                                  <label for="name">User Name</label>
                                  <input name="name" type="text" class="form-control" id="name" aria-describedby="emailHelp" placeholder="Enter name" required="true">
                                </div>

                                <div class="form-group">
                                  <label for="email">Email</label>
                                  <input name="email" type="email" class="form-control" id="email" aria-describedby="emailHelp" placeholder="Enter email" required="true">
                                </div>

                                <div class="form-group">
                                  <label for="password">Password</label>
                                  <input name="password" type="password" class="form-control" id="password" aria-describedby="emailHelp" placeholder="Enter password" required="true">
                                </div>

                                <div class="form-group">
                                  <label for="phone">Phone</label>
                                  <input name="phone" type="number" class="form-control" id="Phone" aria-describedby="emailHelp" placeholder="Enter phone" required="true">
                                </div>

                                <div class="form-group">
                                  <label for="address">Address</label>
                                  <textarea name="address" class="form-control" style="height: 120px;" placeholder="Enter your address" required="true"></textarea>
                                </div>

                                <div class="container text-center" >
                                    <button class="btn btn-outline-light custom-bg" style="background-color: #536DFE">Register</button>
                                    <button class="btn btn-warning custom-bg"  onClick = "fun()">Reset</button>
                                </div> 
                            </form>         
                        </div>
                    </div>
                </div>   
            </div>
        </div>
  </body>
</html>
