<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="com.learn.mycart.entities.User"%>
<%@page import="com.learn.mycart.entities.Category"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    User user = (User) session.getAttribute("current-user");
    if (user == null) {
        session.setAttribute("message", "Sorry you are not logged in. Login first to proceed to checkout.");
        response.sendRedirect("login.jsp");
        return;
    } else {
        if (user.getUserType().equals("normal")) {
            session.setAttribute("message", "Access denied for normal users");
            response.sendRedirect("login.jsp");
            return;
        }
    }

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="components/common_css_js.jsp" %>
        <title>Admin Panel</title>
        
        
        <script>  
            function fun(){  
              var element = document.getElementById("productForm");
              element.reset();
            }  
            
            function fun(){  
              var element2 = document.getElementById("catForm");
              element2.reset();
            }
        </script>

    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <div class="container admin">

            <div class="cotainer-fluid mt-3">
                <%@include file="components/message.jsp" %>
            </div>

            <div class="row mt-3">
                <div class="col-md-4">

                    <!--first box-->
                    <div class = "card" style="border: 2px solid black;">                      
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px" class="img-fluid rounded-circle" src="img/group.png" alt="users_img">
                                <h4>3235</h4>                   
                                <h4  class="text-muted">Users</h4>
                                <a class="btn btn-warning" style="border: 1px solid black;">View Users</a>
                            </div>
                        </div>

                    </div>
                </div>

                <div class="col-md-4">
                    <!--second box-->
                    <div class = "card" style="border: 2px solid black;">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px" class="img-fluid rounded-circle" src="img/list.png" alt="category_img">
                                <h4>625</h4>
                                <h4 class="text-muted">Categories</h4>
                                <a class="btn btn-warning" href="view_categories.jsp?" style="border: 1px solid black;">View Categories</a>
                                
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <!--third box-->
                    <div class = "card" style="border: 2px solid black;">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px" class="img-fluid rounded-circle" src="img/delivery-box.png" alt="product_img">
                                <h4>8965</h4>
                                <h4 class="text-muted">Products</h4>
                                <a class="btn btn-warning" href="view_prod.jsp" style="border: 1px solid black;">View Products</a>
                            </div>
                        </div>
                    </div>   
                </div>
            </div>

            <div class="row mt-3">

                <!--2nd row 1st box-->
                <div class = "col-md-6">
                    <div class = "card" style="border: 2px solid black;" >
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px" class="img-fluid rounded-circle" src="img/add.png" alt="product_img">                                
                                <p>Add a new category in the list!!</p>
                                <a class="btn btn-warning" style="border: 1px solid black;" data-toggle="modal" data-target="#add-category-modal">Add Category</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!--2nd row 2nd box-->
                <div class= "col-md-6">
                    <div class = "card" style="border: 2px solid black;">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px" class="img-fluid rounded-circle" src="img/add-cart.png" alt="product_img">
                                <p>Add a new product in the list!!</p>
                                <a class="btn btn-warning" style="border: 1px solid black;" data-toggle="modal" data-target="#add-product-modal">Add Product</a>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>


        <!--add category modal start-->


        <!-- Modal -->
        <div class="modal fade" id="add-category-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header btn-primary">
                        <h5 class="modal-title" id="exampleModalLabel">Fill category details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body ">

                        <form name="catForm" action="ProductOperationServlet" method="post">

                            <input type="hidden" name="operation" value="addCategory">

                            <div class="form group">
                                <input class="form-control" type="text" name="catName" placeholder="Enter category title"/>
                            </div>

                            <div class="form-group mt-3">
                                <input type="textarea" class="form-control" style="height: 150px;" name="catDetails" placeholder="Enter category details"/>
                            </div>


                            <div class="container text-center">
                                <button type="submit" class="btn btn-primary">Add category</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>

                        </form>

                    </div>

                </div>
            </div>
        </div>

        <!--end of add category modal-->

        <!--*********************************************************-->

        <!--add product modal start-->

        <!-- Modal -->
        <div class="modal fade" id="add-product-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header btn-primary">
                        <h5 class="modal-title" id="exampleModalLabel">Fill product details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body ">

                        <form action="ProductOperationServlet" name="productForm" enctype="multipart/form-data" method="post">

                            <input type="hidden" name="operation" value="addProduct">

                            <div class="form group">
                                <input class="form-control" type="text" name="pName" placeholder="Enter product name"/>
                            </div>

                            <div class="form-group mt-3">
                                <input type="text" class="form-control" style="height: 150px;" name="pDetails" placeholder="Enter product details"/>
                            </div>

                            <div class="form-group mt-3">
                                <input type="number" class="form-control" name="pPrice" placeholder="Enter product price"/>
                            </div>

                            <div class="form-group mt-3">
                                <input type="number" class="form-control" name="pDiscount" placeholder="Enter product discount"/>
                            </div>

                            <div class="form-group mt-3">
                                <input type="number" class="form-control" name="pQty" placeholder="Enter product quantity"/>
                            </div>

                            <% 
                                CategoryDao cDao = new CategoryDao(FactoryProvider.getFactory());
                                List<Category> list = cDao.getCategories();                                
                            %>
                            
                            
                            <div class="form-group mt-3">
                                <select class="form-control" name="pCategory">
                                    <%for(Category c:list){ %>
                                    
                                    <option value="<%= c.getCategoryId() %>"><%= c.getCategoryTitle() %></option>
                                    
                                    <%}%>
                                </select>
                            </div>
                            
                            <div class="form-group mt-3">
                                <label name="labelChooseFile">Upload product image</label><br>
                                <input type="file" class="form-control" name="pImg"/>
                            </div>

                            <div class="container text-center">
                                <button type="submit" class="btn btn-primary">Add product</button>
                                <button type="button" class="btn btn-secondary" onclick="fun()" data-dismiss="modal">Close</button>
                            </div>

                        </form>

                    </div>

                </div>
            </div>
        </div>
                                    <%@include file="components/common_modals.jsp" %>
        <!--end of add product modal-->

    </body>
</html>
