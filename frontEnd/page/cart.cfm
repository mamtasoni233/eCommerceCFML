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
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th class="d-none d-sm-table-cell"></th>
                                    <th class="ps-sm-3">Details</th>
                                    <th>Quantities</th>
                                    <th></th>
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
                                            <td class="d-none d-sm-table-cell">
                                                <picture class="d-block bg-light f-w-20">
                                                    <img class="img-fluid" src="#imagePath##getProductImage.image#" alt="">
                                                </picture>
                                            </td>
                                        <!-- image -->
                                        <!-- Details -->
                                            <td>
                                                <div class="ps-sm-3">
                                                    <h6 class="mb-2 fw-bolder">
                                                        #getAllCartProductQry.productName#
                                                    </h6>
                                                </div>
                                            </td>
                                        <!-- Details -->
                                        <!-- Qty -->
                                            <td>
                                                <!--- <div class="d-flex pe-3">
                                                    <div class="quantity">
                                                        <button class="btn btn-sm btn-dark minus-btn" data-pId ="#getAllCartProductQry.FkProductId#" data-pQty ="#getAllCartProductQry.productQty#" type="button" name="button">
                                                            <i class="fa fa-minus"></i>
                                                        </button>
                                                        <input type="text" class="productQuantity" name="quantity" data-pId ="#getAllCartProductQry.FkProductId#" data-pQty ="#getAllCartProductQry.productQty#" value="#getAllCartProductQry.quantity#" id="productQuantity-#getAllCartProductQry.FkProductId#">
                                                        <button class="btn btn-sm btn-dark plus-btn" id ="plus-btn-#getAllCartProductQry.FkProductId#" onClick="addCartProduct(#getAllCartProductQry.FkProductId#)" data-pQty ="#getAllCartProductQry.productQty#"  type="button" name="button">
                                                            <i class="fa fa-plus"></i>
                                                        </button>
                                                    </div> --->
                                                    <div class="ps-2">
                                                        <p class="fw-bolder mt-3 m-sm-0">#getAllCartProductQry.quantity#  </p>
                                                    </div>
                                                <!--- </div> --->
                                            </td>
                                        <!-- /Qty -->
                                        <!-- Actions -->
                                            <td>
                                                <div class="d-flex justify-content-between align-items-center h-100">
                                                    <p class="fw-bolder m-sm-0"><i class="fa fa-rupee"></i> <span class="perProductPrice">#priceTotal#</span></p>
                                                    <button class="btn btn-sm btn-outline-none bg-light border-0 removeCartProduct" id="removeCartProduct-#getAllCartProductQry.FkProductId#" data-productId ="#getAllCartProductQry.FkProductId#" data-name="#getAllCartProductQry.productName#">
                                                        <i class="fw-bold ri-close-line"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        <!-- /Actions -->
                                    </tr>
                                </cfloop>
                            </tbody>
                        </table>
                    </div>
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
                        <button class="btn btn-link p-0 mt-2 text-white fw-bolder text-decoration-none" type="button"
                            data-bs-toggle="collapse" data-bs-target="##collapseExample" aria-expanded="false"
                            aria-controls="collapseExample">
                            Have a coupon code?
                        </button>
                        <div class="collapse" id="collapseExample">
                            <div class="card card-body bg-transparent p-0">
                                <div class="input-group mb-0 mt-2">
                                    <input type="text" class="form-control border-0" placeholder="Enter coupon code">
                                    <button class="btn btn-white text-dark mx-2 border rounded-3 btn-sm border-0 d-flex justify-content-center align-items-center">
                                        <i class="ri-checkbox-circle-line ri-lg"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
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
            /*  var productId = $('.productQuantity').attr('data-pId');
            var productQty = $('.productQuantity').attr('data-pQty');
            console.log(productId);
            console.log(productQty);
            console.log('##productQuantity-'+productId); */
            // $('##productQuantity-'+productId).on('keyup', function() {
            //     if ( $(this).val() > productQty ) {
            //         warnToast("Not allowed to add this product");
            //         $(this).val(productQty);
            //         $('.plus-btn').addClass('disabled');
            //         $('.minus-btn').removeClass('disabled');
            //     }
                
            // });
            /* $('.minus-btn').on('click', function(e) {
                e.preventDefault();
                var $input = $(this).closest('div').find('input');
                var value = parseInt($input.val());
                $('.plus-btn').removeClass('disabled');
                if ( value > 1) {
                    value = value - 1;
                    $(this).removeClass('disabled');
                    (value === 1) &&  $(this).addClass('disabled');
                }
                $input.val(value);
            }); */
            
            /* $('.plus-btn').on('click', function(e) {
                e.preventDefault();
                var $input = $(this).closest('div').find('input');
                var value = parseInt($input.val());
                $('.minus-btn').removeClass('disabled');
                if (value <= productQty) {
                    value = value + 1;
                    $(this).removeClass('disabled');
                    (value === productQty) &&  $(this).addClass('disabled');
                } else {
                    value = productQty;
                    $(this).addClass('disabled');
                }
                $input.val(value);

            }); */
            // console.log($('##cartAllProductContainer').length );
            $('.removeCartProduct').on('click', function () {
                var pId = $(this).attr('data-productId');
                var name = $(this).attr('data-name');
                Swal.fire({
                    title: 'Are you sure?',
                    text: 'You want to delete this product ' + '"' +  name + '"',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '##dc3545',
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
        });
        /* function addCartProduct(id) {
            var productQty = $('##plus-btn-'+id).attr('data-pQty');
            var $input = $('##plus-btn-'+id).closest('div').find('input');
            var value = parseInt($input.val());
            $('.minus-btn').removeClass('disabled');
            if (value <= productQty) {
                value = value + 1;
                $('##plus-btn-'+id).removeClass('disabled');
                (value === productQty) &&  $('##plus-btn-'+id).addClass('disabled');
            } else {
                value = productQty;
                $('##plus-btn-'+id).addClass('disabled');
            }
            $input.val(value);
        }  */
    </script>
</cfoutput>