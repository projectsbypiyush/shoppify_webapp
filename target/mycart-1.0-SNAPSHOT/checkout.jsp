<%

    User user = (User) session.getAttribute("current-user");
    if (user == null) {
        session.setAttribute("message", "Sorry you are not logged in. Login first to proceed to checkout.");
        response.sendRedirect("login.jsp");
        return;
    }

%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checkout</title>
        <%@include file="components/common_css_js.jsp" %> 
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <div class="container">
            <div class="row mt-5">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header text-center" style="background-color: #FFD43B;">
                            <h3>You Order List</h3>
                        </div>
                        <div class="card-body">
                            <div class="cart-body">

                            </div>
                        </div>
                    </div>
                </div>


                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header text-center"  style="background-color: #FFD43B;">
                            <h3>Delivery Details</h3>
                        </div>

                        <div class="card-body" >
                            <form>
                                <div class="form-group">
                                    <label for="exampleInputPassword1">Deliver to</label>
                                    <input type="text" class="form-control" id="exampleInputPassword1" value="<%=user.getUserName() %>" required="true">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Email address</label>
                                    <input type="email" class="form-control" id="exampleInputEmail1" value="<%=user.getUserEmail()%>" aria-describedby="emailHelp" required="true">
                                    
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputPassword1">Mobile No</label>
                                    <input type="text" class="form-control" id="exampleInputPassword1" value="<%=user.getUserPhone()%>" required="true">
                                </div>
                                <div class="form-group">
                                    <label for="address">Address</label>
                                    <textarea name="address"  class="form-control" style="height: 80px;" required="true"><%=user.getUserAddress() %></textarea>
                                </div>

                                <div class="text-center">
                                    <a type="submit" href="confirm.jsp" class="btn btn-outline-dark btn-lg">Place Order</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
