<cfparam name="PkProductId" default="" />
<cfparam name="productName" default="" />
<cfparam name="productPrice" default="" />
<cfparam name="productQty" default="" />
<cfparam name="isDeleted" default="0" />
<cfquery name="getAllCartProductQry">
    SELECT C.PkCartId, C.FkCustomerId, C.FkProductId, C.quantity, C.price, P.PkProductId, P.productName, P.productPrice, P.productQty, P.productDescription
    FROM cart C
    LEFT JOIN product P ON C.FkProductId = P.PkProductId
    WHERE C.FkCustomerId = <cfqueryparam value = "#session.customer.isLoggedIn#" cfsqltype = "cf_sql_integer">
</cfquery>
<cfoutput>
    <style>
        .form-control{
            border-radius: 0 !important;
        }
    </style>
    <cfset imagePath = "http://127.0.0.1:50847/assets/productImage/">
    <!-- Cart Container-->
    <section class="container mt5">
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
    </section>
    <!-- / Cart Container-->

    <script>
        $(document).ready( function () { 
            $('.removeCartProduct').on('click', function () {
                var pId = $(this).attr('data-productId');
                var name = $(this).attr('data-name');
                Swal.fire({
                    title: 'Are you sure?',
                    text: 'You want to delete this product ' + '"' +  name + '"',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: 'rgb(239 88 32)',
                    // customClass: {
                    //     confirmButton: 'btn btn-orange m-2',
                    // },
                    confirmButtonText: 'Yes, delete it!'
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({  
                            url: './ajaxAddToCart.cfm?removeCartProduct=' + pId, 
                            type: 'GET',
                            async: false,
                            success: function(result) {
                                if (result.success) {
                                    dangerToast("Your product is successfully deleted!");
                                    $('##rowProduct-'+pId).remove();
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
                });
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
        });
    </script>
</cfoutput>