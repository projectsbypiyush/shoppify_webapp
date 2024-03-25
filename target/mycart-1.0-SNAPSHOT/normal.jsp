

<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="com.learn.mycart.dao.*"%>
<%@page import="com.learn.mycart.entities.*"%>
<%@page import="com.learn.mycart.helper.Helper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="components/navbar.jsp" %>
        <%@include file="components/common_css_js.jsp" %>
        <link rel="stylesheet" href="css/style.css">
        <title>Normal</title>

        <script>

            function add_to_cart(pid, pname, price, qty) {

                let cart = localStorage.getItem("cart");
                if (cart == null) {
                    //no cart
                    let products = [];
                    let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: price};
                    products.push(product);
                    localStorage.setItem("cart", JSON.stringify(products));
                    console.log("Product first time added");
                } else {

                    //cart already present
                    let pcart = JSON.parse(cart);

                    let oldProduct = pcart.find((item) => item.productId == pid);
                    let itemQty = null;
                    if (oldProduct)
                    {
                        //product already added..increase qty
                        oldProduct.productQuantity = oldProduct.productQuantity + 1;
                        pcart.map((item) => {

                            if (item.productId == oldProduct.productId)
                            {
                                item.productQuantity = oldProduct.productQuantity;
                            }
                            itemQty = item.productQuantity;
                        });
                        if (itemQty > qty)
                            alert("Sorry only " + qty + " quantity available for now");

                        else {
                            localStorage.setItem("cart", JSON.stringify(pcart));
                            console.log("Product quantity increased");
                        }

                    } else
                    {
                        //add new product to cart
                        let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: price};
                        pcart.push(product);
                        localStorage.setItem("cart", JSON.stringify(pcart));
                        console.log("Product added successfully.");
                    }


                }
                updateCart();
            }

            function updateCart() {

                let cartString = localStorage.getItem("cart");
                let cart = JSON.parse(cartString);

                if (cart == null || cart.length == 0)
                {
                    console.log("Cart is empty!!");
                    $(".cart-items").html("(0)");
                    $(".cart-body").html("<h6>Start shopping fast...your cart is empty!!</h6>");
                    $(".checkout-btn").attr('disabled', true);
                } else
                {
                    console.log(cart);
                    $(".cart-items").html(`( ${cart.length} )`);
                    let table = `
            <table class='table'>
                <thead class='thead-light'>
                    <tr>
                        <th>Item Name</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Total Price</th>
                        <th>Action</th>
                    </tr>
        
                </thead>
            

        `;
                    let totalprice = 0;
                    cart.map((item) => {

                        table += `
                <tr>
                    <td>${item.productName}</td>
                    <td>&#8377;${item.productPrice}</td>
                    <td>${item.productQuantity}</td>
                    <td>&#8377;${item.productPrice * item.productQuantity}</td>
                    <td><button onclick="removeItem(${item.productId})" class='btn btn-danger btn-sm'>Remove</button>
                </tr>
            `;
                        totalprice += item.productPrice * item.productQuantity;
                    });

                    table = table + `
        <tr>
            <td colspan='5' class="font-weight-bold text-right" style="font-size:20px">Grand total: <span class="text-success">&#8377;${totalprice}</span></td>
        </tr>      
        </table>`;
                    $(".cart-body").html(table);
                    $(".checkout-btn").attr('disabled', false);
                }

            }

            function removeItem(pid) {

                let cart = JSON.parse(localStorage.getItem("cart"));

                let newcart = cart.filter((item) => item.productId != pid);

                localStorage.setItem("cart", JSON.stringify(newcart));

                updateCart();

            }

            function goToCheckout() {
                window.location = "checkout.jsp";
            }

            $(document).ready(function () {
                updateCart();
            });
        </script>


    </head>
    <body>
        <div class="row mt-3 mx-2">
            <%
                CategoryDao cDao = new CategoryDao(FactoryProvider.getFactory());
                List<Category> cList = cDao.getCategories();

                ProductDao pDao = new ProductDao(FactoryProvider.getFactory());
                List<Product> pList = null;

                String cid = request.getParameter("category");
                if (cid == null) {
                    pList = pDao.getAllProducts();
                } else if (cid.trim().equals("all")) {
                    pList = pDao.getAllProducts();
                } else {
                    int id = Integer.parseInt(cid);
                    pList = pDao.getAllProductsById(id);
                }

            %>   
            <div class="col-md-2">
                <div id="list-example" class="list-group">
                    <a href="index.jsp?category=all" class="list-group-item list-group-item-action active" aria-current="true">
                        Categories
                    </a>
                    <%                    for (Category cat : cList) {

                    %>
                    <a href="index.jsp?category=<%= cat.getCategoryId()%>" class="list-group-item list-group-item-action"><%= cat.getCategoryTitle()%></a>
                    <%
                        }
                    %>
                </div>
            </div>

            <div class="col-md-10">
                <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel" style="width: 100%; height: 300px; margin-bottom: 30px; object-fit: cover">
                    <ol class="carousel-indicators">
                        <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                        <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                        <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                    </ol>
                    <div class="carousel-inner" style="margin-bottom: 30px;" >
                        <div class="carousel-item active">
                            <img src="https://images.samsung.com/is/image/samsung/assets/sg/support/mobile-devices/what-are-the-new-design-features-on-samsung-galaxy-s10-series/new-design-features-banner1.jpg?$ORIGIN_JPG$" class="d-block w-100" alt="..." style="width: 100%; height: 300px; margin-bottom: 30px; object-fit: cover">
                        </div>
                        <div class="carousel-item">
                            <img src="https://81company.rs/wp-content/uploads/2022/12/5.05_LG_2022_Banner_Desktop_1600x600_Eng.jpg" class="d-block w-100" alt="..." style="width: 100%; height: 300px; margin-bottom: 30px; object-fit: cover">
                        </div>
                        <div class="carousel-item">
                            <img src="https://marketplace.canva.com/EAFWt8Wq208/1/0/1600w/canva-grey-minimalist-special-offer-banner-landscape-tVz4E4KVLgk.jpg" class="d-block w-100" alt="..." style="width: 100%; height: 300px; margin-bottom: 30px; object-fit: cover">
                        </div>
                    </div>

                </div>
                <div class="card-columns">
                    <%                    for (Product p : pList) {
                    %>

                    <div class="card product-card">

                        <div class="container text-center" >
                            <img src="img/products/<%= p.getpPic()%>" style="max-height: 250px; width: 100%; width: auto"/>
                        </div>
                        <div class="card-body">
                            <div class="card-title">
                                <h5><%= p.getpName()%></h5>
                            </div>

                            <div class="card-text">
                                <p>
                                    <%= Helper.getFewWords(p.getpDesc())%>
                                </p>
                            </div>
                        </div>
                        <div class="card-footer">
                            <button type="button" class="btn btn-info" onclick="add_to_cart(<%= p.getpId()%>, '<%= p.getpName()%>', <%= p.getpPrice()%>, <%= p.getpQty()%>)"> Add to Cart </button> 
                            <a href="checkout.jsp" class="btn btn-outline-dark" onclick="add_to_cart(<%= p.getpId()%>, '<%= p.getpName()%>', <%= p.getpPrice()%>, <%= p.getpQty()%>)">Buy Now</a>
                            <h5>&#8377;<%= p.getDiscountedPrice()%></h5> <span class="text-secondary disount-label" style="font-size: 15px; font-style: italic"> Flat <%= p.getpDiscount()%>% off on &#8377;<%= p.getpPrice()%> </span> 

                        </div> 

                    </div>

                    <%
                        }
                        if (pList.size() == 0)
                            out.print("No items in this category.");
                    %>
                </div>
            </div>

        </div>
        <%@include file="components/common_modals.jsp" %>


    </body>
</html>
