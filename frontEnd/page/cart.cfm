<cfparam name="PkProductId" default="" />
<cfparam name="productName" default="" />
<cfparam name="productPrice" default="" />
<cfparam name="productQty" default="" />
<cfparam name="isDeleted" default="0" />
<cfset customerId = session.customer.isLoggedIn>
<cfquery name="getAllCartProductQry">
    SELECT C.PkCartId, C.FkCustomerId, C.FkProductId, C.quantity, C.price, P.PkProductId, P.productName, P.productPrice, P.productQty, P.productDescription
    FROM cart C
    LEFT JOIN product P ON C.FkProductId = P.PkProductId
    WHERE C.FkCustomerId = <cfqueryparam value = "#session.customer.isLoggedIn#" cfsqltype = "cf_sql_integer">
    ORDER BY C.PkCartId DESC
</cfquery>
<cfset productId = getAllCartProductQry.FkProductId>
<cfset productQty = getAllCartProductQry.productQty>
<cfset productPrice = getAllCartProductQry.productPrice>
<cfoutput>
    <style>
        .form-control{
            border-radius: 0 !important;
        }
        .quantity input {
            -webkit-appearance: none;
            border: none;
            text-align: center;
            width: 32px;
            font-size: 16px;
            color: ##0a0a0a;
            font-weight: 900;
        }
    </style>
    <cfset imagePath = "http://127.0.0.1:50847/assets/productImage/">
    <!-- Cart Container-->
    <!---  <section class="container mt5">
        <cfif getAllCartProductQry.recordCount EQ 0>
            <h1 class="mb-6 mt-3 display-5 fw-bold text-center">Your Cart Is Empty</h1>
        <cfelse>
            <h1 class="mb-6 mt-3 display-5 fw-bold text-center cartHeading">Your Cart</h1>
            <div class="row g-4 g-md-8" id="cartAllProductContainer">
                <!-- Cart Items -->
                <div class="col-12 col-lg-6 col-xl-7">
                    <table class="table-responsive table table-bordered table-hover align-middle shadow-lg" id="productTable">
                        <thead>
                            <tr>
                                <th class="d-none d-sm-table-cell"></th>
                                <th class="ps-3">Details</th>
                                <th class="ps-3">Quantities</th>
                                <th class="ps-3">Price</th>
                                <th class="ps-3">
                                    <a class="btn btn-sm removeCartProduct " id="removeAllCartValue" data-bs-toggle="tooltip" title="Remove All">
                                        <i class="fa fa-trash mt-0 pt-0"></i>
                                    </a>
                                    <!--- <button class="btn-outline-none bg-light border-0 removeCartProduct text-uppercase" id="removeAllCartValue">
                                        <!--- Remove All --->
                                        <i class="fa fa-trash"></i>
                                    </button> --->
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <cfset productSubTotal = 0>
                            <cfloop query="getAllCartProductQry">
                                <cfset priceTotal = getAllCartProductQry.quantity * getAllCartProductQry.price>
                                <cfset productSubTotal +=  priceTotal >
                                <cfquery name="getProductImage">
                                    SELECT image, isDefault
                                    FROM product_image 
                                    WHERE FkProductId = <cfqueryparam value="#getAllCartProductQry.FkProductId#" cfsqltype = "cf_sql_integer">
                                </cfquery>
                                <tr id="rowProduct-#getAllCartProductQry.FkProductId#" class="rowProductclass">
                                    <!-- image -->
                                        <td class="d-none d-sm-table-cell ps-3">
                                            <picture class="d-block bg-light f-w-20">
                                                <img class="img-fluid" src="#imagePath##getProductImage.image#" alt="">
                                            </picture>
                                        </td>
                                    <!-- image -->
                                    <!-- Details -->
                                        <td class="ps-3">
                                            <a style="cursor:pointer;" class="text-decoration-none" href="index.cfm?pg=product&id=#getAllCartProductQry.FkProductId#" data-bs-toggle="tooltip" title="View">
                                                #getAllCartProductQry.productName#
                                            </a>
                                        </td>
                                    <!-- Details -->
                                    <!-- Qty -->
                                        <td class="ps-3">
                                            #getAllCartProductQry.quantity# 
                                        </td>
                                    <!-- /Qty -->
                                    <!-- Price -->
                                        <td class="ps-3">
                                            <i class="fa fa-rupee"></i> 
                                            <span class="perProductPrice">#priceTotal#</span>
                                        </td>
                                    <!-- /Price -->
                                    <!-- Actions -->
                                        <td class="ps-3">
                                            <a class="btn btn-sm btn-danger btn-outline-none removeCartProduct" id="removeCartProduct-#getAllCartProductQry.FkProductId#" data-productId ="#getAllCartProductQry.FkProductId#" data-name="#getAllCartProductQry.productName#" data-bs-toggle="tooltip" title="Remove">
                                                <i class="fa fa-remove"></i>
                                            </a>
                                        </td>
                                    <!-- /Actions -->
                                </tr>
                            </cfloop>
                        </tbody>
                    </table>
                </div>
                <!-- /Cart Items -->
                <!-- Cart Summary -->
                <div class="col-12 col-lg-6 col-xl-5">
                    <div class="bg-dark p-4 p-md-5 text-white">
                        <h3 class="fs-3 fw-bold m-0 text-center">Order Summary</h3>
                        <div class="py-3 border-bottom-white-opacity">
                            <div class="d-flex justify-content-between align-items-center mb-2 flex-column flex-sm-row">
                                <p class="m-0 fw-bolder fs-6">Subtotal</p>
                                <p class="m-0 fs-6 fw-bolder"><i class="fa fa-rupee"></i> <span class="priceSubtotal">#productSubTotal#</span></p>
                            </div>
                            <div class="d-flex justify-content-between align-items-center flex-column flex-sm-row mt-3 m-sm-0">
                                <p class="m-0 fw-bolder fs-6">Shipping</p>
                                <span class="text-white opacity-75 small">Will be set at checkout</span>
                            </div>
                        </div>
                        <div class="py-3 border-bottom-white-opacity">
                            <div class="d-flex justify-content-between align-items-center flex-column flex-sm-row">
                                <div>
                                    <p class="m-0 fs-5 fw-bold">Grand Total</p>
                                    <!--- <span class="text-white opacity-75 small">Inc $45.89 sales tax</span> --->
                                </div>
                                <p class="mt-3 m-sm-0 fs-5 fw-bold"><i class="fa fa-rupee"></i> <span class="priceSubtotal">#productSubTotal#</span></p>
                            </div>
                        </div>
                        <!-- Coupon Code-->
                        <!--- <button class="btn btn-link p-0 mt-2 text-white fw-bolder text-decoration-none" type="button"
                            data-bs-toggle="collapse" data-bs-target="##collapseExample" aria-expanded="false"
                            aria-controls="collapseExample">
                            Have a coupon code?
                        </button>
                        <div class="collapse" id="collapseExample">
                            <div class="card card-body bg-transparent p-0">
                                <div class="input-group mb-0 mt-2">
                                    <input type="text" class="form-control border-0" placeholder="Enter coupon code">
                                    <button class="btn btn-white text-dark px-3 btn-sm border-0 d-flex justify-content-center align-items-center">
                                        <i class="ri-checkbox-circle-line ri-lg"></i></button>
                                </div>
                            </div>
                        </div> --->
                        <!-- / Coupon Code-->
                    
                        <!-- Checkout Button-->
                        <a href="index.cfm?pg=checkOut" class="btn btn-orange w-100 text-center mt-3"
                            role="button">
                            <i class="ri-secure-payment-line align-bottom"></i> 
                            Proceed to checkout
                        </a>
                        <!-- Checkout Button-->
                    </div>
                    
                    <!-- Payment Icons-->
                    <ul class="list-unstyled d-flex justify-content-center mt-3">
                        <li class="mx-1 border d-flex align-items-center p-2"><i class="pi pi-mastercard"></i></li>
                        <li class="mx-1 border d-flex align-items-center p-2"><i class="pi pi-american-express"></i></li>
                        <li class="mx-1 border d-flex align-items-center p-2"><i class="pi pi-visa"></i></li>
                    </ul>
                    <!-- / Payment Icons-->            
                </div>
                <!-- /Cart Summary -->
            </div>
        </cfif>
    </section> --->
    <!-- / Cart Container-->

    <section class="container mt-5">
        <!--- <cfdump  var="#session#"> --->
        <cfif getAllCartProductQry.recordCount EQ 0>
            <h1 class="mb-6 mt-3 display-5 fw-bold text-center">Your Cart Is Empty</h1>
        <cfelse>
            <h1 class="mb-6 mt-3 display-5 fw-bold cartHeading">Your Cart</h1>
            <div class="row" id="cartAllProductContainer">
                <!-- Cart Items -->
                <div class="col-12">
                    <div class="table-responsive shadow-lg rounded-3">
                        <table class="table table-borderless table-hover align-middle " id="productTable">
                            <thead class="">
                                <tr>
                                    <th class="ps-3">Product</th>
                                    <th class="ps-3">Quantities</th>
                                    <th class="ps-3">
                                        <a class="btn btn-sm removeCartProduct" id="removeAllCartValue" data-bs-toggle="tooltip" title="Remove All">
                                            <i class="fa fa-trash me-2"></i>
                                        </a>
                                    </th>
                                    <th class="ps-3">Total</th>
                                </tr>
                            </thead>
                            <tbody class="">
                                <cfset productSubTotal = 0>
                                <cfloop query="getAllCartProductQry">
                                <!---   <cfset priceTotal = getAllCartProductQry.quantity * getAllCartProductQry.price> --->
                                    <cfset productSubTotal +=  getAllCartProductQry.price >
                                    <cfquery name="getProductImage">
                                        SELECT image, isDefault
                                        FROM product_image 
                                        WHERE FkProductId = <cfqueryparam value="#getAllCartProductQry.FkProductId#" cfsqltype = "cf_sql_integer">
                                    </cfquery>
                                    <tr id="rowProduct-#getAllCartProductQry.FkProductId#" class="rowProductclass">
                                        <!-- image -->
                                            <td class="d-flex ps-3">
                                                <picture class="d-block bg-light f-w-20">
                                                    <img class="img-thumbnail" src="#imagePath##getProductImage.image#" alt="" width="80" height="80">
                                                </picture>
                                                <a style="cursor:pointer;" class="text-decoration-none ps-4" href="index.cfm?pg=product&id=#getAllCartProductQry.FkProductId#" data-bs-toggle="tooltip" title="View">
                                                    #getAllCartProductQry.productName#
                                                    <p class="text-muted small"><i class="fa fa-rupee"></i> #getAllCartProductQry.productPrice#</p>
                                                </a>
                                            </td>
                                        <!-- Details -->
                                        <!-- Qty -->
                                            <td class="ps-3">
                                                <!--- #getAllCartProductQry.quantity#  --->
                                                <div class="quantity">
                                                    <button class="btn btn-sm btn-dark minus-btn" type="button" name="button"  data-pId="#getAllCartProductQry.FkProductId#" data-prodPrice="#getAllCartProductQry.productPrice#" data-prodQty="#getAllCartProductQry.productQty#" id="minusBtn-#getAllCartProductQry.FkProductId#">
                                                        <i class="fa fa-minus"></i>
                                                    </button>

                                                    <input type="text" name="quantity" class="productQuantity" data-id="#getAllCartProductQry.FkProductId#" value="#getAllCartProductQry.quantity#" data-price="#getAllCartProductQry.productPrice#" id="productQuantity-#getAllCartProductQry.FkProductId#" data-prodQty="#getAllCartProductQry.productQty#">

                                                    <button class="btn btn-sm btn-dark plus-btn" type="button" name="button" id="plusBtn-#getAllCartProductQry.FkProductId#" data-pId="#getAllCartProductQry.FkProductId#" data-prodPrice="#getAllCartProductQry.productPrice#" data-prodQty="#getAllCartProductQry.productQty#">
                                                        <i class="fa fa-plus"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        <!-- /Qty -->
                                        <!-- Actions -->
                                            <td class="ps-4">
                                                <a class="text-decoration-none removeCartProduct" id="removeCartProduct-#getAllCartProductQry.FkProductId#" data-productId="#getAllCartProductQry.FkProductId#" data-name="#getAllCartProductQry.productName#" data-bs-toggle="tooltip" title="Remove">
                                                    <i class="fa fa-trash"></i>
                                                </a>
                                            </td>
                                        <!-- /Actions -->
                                        <!-- Total Price -->
                                            <td class="ps-3 priceRow" id="priceRow-#getAllCartProductQry.FkProductId#" data-productId="#getAllCartProductQry.FkProductId#">
                                                <i class="fa fa-rupee"></i> 
                                                <span class="perProductPrice" id="perProductTotalPrice-#getAllCartProductQry.FkProductId#">#getAllCartProductQry.price#</span>
                                            </td>
                                        <!-- /Total Price -->
                                        
                                    </tr>
                                </cfloop>
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- /Cart Items -->
                <!-- Cart Summary -->
                <div class="col-12 d-flex justify-content-end mt-5">
                    <div class="w-25">
                        <div class="border-bottom-white-opacity">
                            <div class="m-0 p-0 d-flex justify-content-end align-items-center flex-column flex-sm-row">
                                <p class="me-5 fs-5 fw-bold">Sub Total</p>
                                <p class="fs-5 fw-bold me-2"><i class="fa fa-rupee"></i> <span class="priceSubtotal">#productSubTotal#</span></p>
                            </div>
                            <!---  <p class="text-muted m-0 p-0 d-flex justify-content-end">Will be set at checkout</p> --->
                        </div>
                        <!-- Checkout Button-->
                        <a href="index.cfm?pg=checkOut" class="btn btn-orange w-100 text-center mt-2"
                            role="button">
                            <i class="ri-secure-payment-line align-bottom"></i> 
                            Proceed to checkout
                        </a>
                        <!-- Checkout Button-->
                    </div>
                </div>
                <!--- <!-- Payment Icons-->
                <ul class="list-unstyled d-flex justify-content-center mt-3">
                    <li class="mx-1 border d-flex align-items-center p-2"><i class="pi pi-mastercard"></i></li>
                    <li class="mx-1 border d-flex align-items-center p-2"><i class="pi pi-american-express"></i></li>
                    <li class="mx-1 border d-flex align-items-center p-2"><i class="pi pi-visa"></i></li>
                </ul>
                <!-- / Payment Icons-->      --->       
                <!-- /Cart Summary -->
            </div>
        </cfif>
    </section>

    <script>
        /* var #toScript('#productQty#', 'productQty')#
        var #toScript('#productPrice#', 'productPrice')#
        var #toScript('#productId#', 'productId')# */
        var #toScript('#customerId#', 'customerId')#
        $(document).ready( function () { 

            $('.removeCartProduct').on('click', function () {
                var pId = $(this).attr('data-productId');
                var name = $(this).attr('data-name');
                /* Swal.fire({
                    title: 'Are you sure?',
                    text: 'You want to delete this product ' + '"' +  name + '"',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: 'rgb(239 88 32)',
                    confirmButtonText: 'Yes, delete it!'
                }).then((result) => {
                    if (result.isConfirmed) { */
                        setTimeout(function(){
                            showLoader(pId);
                        }, 1000);
                        /* $.ajax({  
                            url: './ajaxAddToCart.cfm?removeCartProduct=' + pId, 
                            type: 'GET',
                            async: false,
                            success: function(result) {
                                if (result.success) {
                                    dangerToast("Your product is successfully deleted!");
                                    showLoader(pId);
                                    setTimeout(function(){
                                        $('##rowProduct-'+pId).remove();
                                    }, 1000);
                                    if($('.rowProductclass').length === 0){
                                        $('.cartHeading').text('Your Cart Is Empty');
                                        $('##cartAllProductContainer').addClass('d-none');
                                    } 
                                    let priceVal=0;
                                    $('.perProductPrice').each(function() {
                                        priceVal += parseFloat($(this).html());
                                    });
                                    $('.priceSubtotal').html(priceVal);
                                    $.ajax({  
                                        url: './ajaxAddToCart.cfm?getCartCountValue=cartCounter', 
                                        type: 'GET',
                                        success: function(result) {
                                            if (result.success) {
                                                $('##offcanvasCartBtn span.cartCounter').removeClass('d-none');
                                                $('##offcanvasCartBtn span.cartCounter').text(result.cartCountValue);
                                            } else{
                                                $('##offcanvasCartBtn span.cartCounter').addClass('d-none');
                                                $('##offcanvasCartBtn span.cartCounter').text('');
                                            }
                                        },
                                    });  
                                }
                            },
                        }); */
                        removeProduct(pId);
                    /*  }
                }); */
            });
            $('##removeAllCartValue').on('click', function () {
                Swal.fire({
                    title: 'Are you sure?',
                    text: 'You want to remove all products',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '##dc3545',
                    confirmButtonText: 'Yes, delete it!'
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({  
                            url: './ajaxAddToCart.cfm?removeAllCartValue=removeAllProductToCart', 
                            type: 'GET',
                            async: false,
                            success: function(result) {
                                if (result.success) {
                                    dangerToast("Your product is successfully deleted!");
                                    $('##productTable').remove();
                                    $('.cartHeading').text('Your Cart Is Empty');
                                        $('##cartAllProductContainer').addClass('d-none');
                                    $.ajax({  
                                        url: './ajaxAddToCart.cfm?getCartCountValue=cartCounter', 
                                        type: 'GET',
                                        success: function(result) {
                                            if (result.success) {
                                                $('##offcanvasCartBtn span.cartCounter').removeClass('d-none');
                                                $('##offcanvasCartBtn span.cartCounter').text(result.cartCountValue);
                                            } else{
                                                $('##offcanvasCartBtn span.cartCounter').addClass('d-none');
                                                $('##offcanvasCartBtn span.cartCounter').text('');
                                            }
                                        },
                                    });  
                                }
                            },
                        });
                    }
                });
            });
            // increment - decrement
            $('.plus-btn').on('click', function(e) {
                // e.preventDefault();
                let $input = $(this).closest('div').find('input');
                let value = parseInt($input.val());
                var productId = $(this).attr('data-pId');
                var price = $(this).attr('data-prodPrice');
                var productQty = $(this).attr('data-prodQty');
                $('##minusBtn-'+productId).removeClass('disabled'); 
                if (value <= productQty) {
                    value = value + 1;
                    $(this).removeClass('disabled');
                    (value === productQty) &&  $(this).addClass('disabled');
                } else {
                    value = productQty;
                    $(this).addClass('disabled');
                }
                /* setTimeout(function(){
                    showLoader(productId);
                }, 800);
                setTimeout(function(){
                    hideLoader(productId);
                }, 500); */
                setTimeout(function(){
                    $input.val(value);
                    addToCart(productId,value,price);
                }, 500);
                
                /*  setTimeout(function(){
                    // hideLoader(productId);
                    // hideLoader(productId);
                }, 500); */
                
            });
            $('.minus-btn').on('click', function(e) {
                // e.preventDefault();
                let $input = $(this).closest('div').find('input');
                let value = parseInt($input.val());
                var productId = $(this).attr('data-pId');
                var price = $(this).attr('data-prodPrice');
                var productQty = $(this).attr('data-prodQty');
                $('##plusBtn-'+productId).removeClass('disabled');
                if ( value > 0) {
                    value = value - 1;
                    $(this).removeClass('disabled');
                    (value === 0) &&  removeProduct(productId); 
                } /* else{
                    removeProduct(productId);
                } */
                $input.val(value);
                addToCart(productId,value,price);
                
            });
            /* var productQty = $('##productQuantity').val();
            $('.productQuantity').on('keyup', function() {
                var productId = $(this).data('id');
                if ( $(this).val() > productQty ) {
                    warnToast("Not allowed to add this product");
                    $(this).val(productQty);
                    $('##plusBtn-'+productId).addClass('disabled');
                    $('##minusBtn-'+productId).removeClass('disabled');
                }
            });
            var productId = $('.productQuantity').data('id');
            $('##minusBtn-'+productId).on('click', function(e) {
                e.preventDefault();
                var $input = $(this).closest('div').find('input');
                var value = parseInt($input.val());
                $('##plusBtn-'+productId).removeClass('disabled');
                if ( value > 1) {
                    value = value - 1;
                    $(this).removeClass('disabled');
                    (value === 1) &&  $(this).addClass('disabled');
                }
                $input.val(value);
                addToCart(productId);
            }); */
            
            /*  $('##plusBtn-'+productId).on('click', function(e) {
                e.preventDefault();
                var $input = $(this).closest('div').find('input');
                var value = parseInt($input.val());
                $('##minusBtn-'+productId).removeClass('disabled');
                if (value <= productQty) {
                    value = value + 1;
                    $(this).removeClass('disabled');
                    (value === productQty) &&  $(this).addClass('disabled');
                } else {
                    value = productQty;
                    $(this).addClass('disabled');
                }
                $input.val(value);
                addToCart(productId);
            }); */
        });
        function showLoader(pId=0) {
            $("##priceRow-"+pId).html('<div class="spinner-border text-secondary" role="status" ><span class="visually-hidden">Loading...</span></div>');
        }
        /* function hideLoader(pId=0) {
            $("##priceRow-"+pId).html();
        } */
        function removeProduct(pId=0) {
            $.ajax({  
                url: './ajaxAddToCart.cfm?removeCartProduct=' + pId, 
                type: 'GET',
                async: false,
                success: function(result) {
                    if (result.success) {
                        dangerToast("Your product is successfully deleted!");
                        showLoader(pId);
                        setTimeout(function(){
                            $('##rowProduct-'+pId).remove();
                        }, 1000);
                        if($('.rowProductclass').length === 0){
                            $('.cartHeading').text('Your Cart Is Empty');
                            $('##cartAllProductContainer').addClass('d-none');
                        } 
                        let priceVal=0;
                        $('.perProductPrice').each(function() {
                            priceVal += parseFloat($(this).html());
                        });
                        $('.priceSubtotal').html(priceVal);
                        $.ajax({  
                            url: './ajaxAddToCart.cfm?getCartCountValue=cartCounter', 
                            type: 'GET',
                            success: function(result) {
                                if (result.success) {
                                    $('##offcanvasCartBtn span.cartCounter').removeClass('d-none');
                                    $('##offcanvasCartBtn span.cartCounter').text(result.cartCountValue);
                                } else{
                                    $('##offcanvasCartBtn span.cartCounter').addClass('d-none');
                                    $('##offcanvasCartBtn span.cartCounter').text('');
                                }
                            },
                        });  
                    }
                },
            });
        }
        function addToCart(productId=0, quantity=0, price=0){
            $.ajax({  
                url: '../ajaxAddToCart.cfm?updateCartProductId='+ productId, 
                data: {'productQty':quantity, 'productPrice':price, 'customerId' : customerId},
                type: 'POST',
                success: function(result) {
                    if (result.success) {
                        /* let priceVal=0; */
                        $('##perProductTotalPrice-'+productId).html(result.totalPrice);
                        let priceVal=0;
                        $('.perProductPrice').each(function() {
                            priceVal += parseFloat($(this).html());
                        });
                        $('.priceSubtotal').html(priceVal);
                        $('.priceSubtotal').html(result.subTotal);
                       /*  successToast("Great!! You were " + quantity + " product added in to cart"); */
                        $.ajax({  
                            url: '../ajaxAddToCart.cfm?getCartCountValue=cartCounter', 
                            type: 'GET',
                            success: function(result) {
                                if (result.success) {
                                    $('##offcanvasCartBtn span.cartCounter').removeClass('d-none');
                                    $('##offcanvasCartBtn > span.cartCounter').text(result.cartCountValue);
                                } else {
                                    $('##offcanvasCartBtn span.cartCounter').addClass('d-none');
                                    $('##offcanvasCartBtn span.cartCounter').text('');
                                }
                            },
                        });  
                    }
                },
            }); 
        }
    </script>
</cfoutput>