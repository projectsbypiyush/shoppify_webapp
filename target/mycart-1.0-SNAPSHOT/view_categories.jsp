<%-- 
    Document   : view_categories
    Created on : 02-Nov-2023, 11:24:46 PM
    Author     : wankh
--%>

<%@page import="java.util.*"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="com.learn.mycart.entities.Category"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="components/common_css_js.jsp" %>
        <title>View Categories</title>

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">


        <script>
            $(document).ready(function () {
                $('#update-category-modal').on('show.bs.modal', function (event) {
                    var button = $(event.relatedTarget); // Button that triggered the modal
                    var id = button.data('id'); // Extract info from data-* attributes
                    var modal = $(this);
                    // Update the modal's content dynamically using JavaScript

                    document.getElementById("cId").value = id;


                    //modal.find('.modal-body').text('ID: ' + id);
                });
            });

            $(document).ready(function () {
                $('#delete-category-modal').on('show.bs.modal', function (event) {
                    var button = $(event.relatedTarget); // Button that triggered the modal
                    var id = button.data('id'); // Extract info from data-* attributes
                    var modal = $(this);
                    // Update the modal's content dynamically using JavaScript

                    document.getElementById("catId").value = id;


                    //modal.find('.modal-body').text('ID: ' + id);
                });
            });

        </script>

    </head>

    <%
        CategoryDao dao = new CategoryDao(FactoryProvider.getFactory());
        List<Category> list = dao.getCategories();

    %>

    <body>
        <%@include file="components/navbar.jsp" %>
        <div class="cotainer-fluid mt-3 text-center">
            <%@include file="components/message.jsp" %>
            <h3 class="fw-bolder">Categories</h3>
        </div>
        <div class="container mt-3" >
            <table class="table table-hover table-bordered">
                <thead class="table-info">
                    <tr>
                        <th scope="col">Category Id</th>
                        <th scope="col">Category Name</th>
                        <th scope="col">Category Desc</th>
                        <th scope="col">Update / Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <%                        for (Category l : list) {
                    %>
                    <tr>
                        <td><%= l.getCategoryId()%></td>
                        <td><%= l.getCategoryTitle()%></td>
                        <td><%= l.getCategoryDesc()%></td>
                        
                        <td><button type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#update-category-modal" data-id="<%= l.getCategoryId()%>">Update</button>
                            <button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#delete-category-modal" data-id="<%= l.getCategoryId()%>">Delete</button></td>
                    </tr>
                    <% }
                    %>


                </tbody>
            </table>


            <!-- Update Category Modal -->
            <div class="modal fade" id="update-category-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header btn-primary">
                            <h5 class="modal-title" id="exampleModalLabel">Fill category details</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body ">

                            <form name="catForm" action="ProductOperationServlet" method="post">

                                <input type="hidden" name="operation" value="updateCategory">

                                <div class="form group">
                                    <label>Category ID</label>
                                    <input class="form-control" id="cId" type="number" name="catId"/>
                                </div>

                                <div class="form group">
                                    <label>Category Title</label>
                                    <input class="form-control" id="cName" type="text" name="catName" placeholder="Enter category title"/>
                                </div>

                                <div class="form-group mt-3">
                                    <label>Category Details</label>
                                    <input type="textarea" id="cDetails" class="form-control" style="height: 150px;" name="catDetails" placeholder="Enter category details"/>
                                </div>


                                <div class="container text-center">
                                    <button type="submit" class="btn btn-success">Update category</button>
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                </div>

                            </form>

                        </div>

                    </div>
                </div>
            </div>

            <!--end of update category modal-->


            <!-- Delete Category Modal-->

            <div class="modal" id="delete-category-modal" tabindex="-1" role="dialog">
                <div class="modal-dialog " role="document">
                    <div class="modal-content">
                        <div class="modal-header btn-primary">
                            <h5 class="modal-title">Delete Category?</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form name="catForm" action="ProductOperationServlet" method="post">

                                <input type="hidden" name="operation" value="deleteCategory">

                                <div class="form group">
                                    <label>Category ID</label>
                                    <input class="form-control" id="catId" type="number" name="catId"/>
                                </div>

                                <br>
                                <div class="container text-center">
                                    <button type="submit" class="btn btn-danger">Delete Category</button>
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                </div>
                            </form>
                        </div>

                    </div>
                </div>
            </div>


            <!--End of delete category modal-->

        </div>
    </body>
</html>
