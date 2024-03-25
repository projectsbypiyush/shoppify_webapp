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
