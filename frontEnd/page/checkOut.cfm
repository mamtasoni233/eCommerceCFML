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
</cfquery>
<cfoutput>
    <style>
        .form-control{
            border-radius: 0 !important;
        }
    </style>
    <cfset imagePath = "http://127.0.0.1:50847/assets/productImage/">
    <!-- CheckOut Container-->
    <section class="container mt5">
        <h1 class="mb-3 display-5 fw-bold text-center">Checkout Securely</h1>
        <form class="form" id="addOrderForm" method="POST" action="" enctype="multipart/form-data">
            <div class="row g-md-8 mt-2">
                <!-- Checkout Panel Left -->
                <div class="col-12 col-lg-6 col-xl-7">
                    <!-- Checkout Panel Contact -->
                    <div class="checkout-panel">
                        <h5 class="title-checkout">Contact Information</h5>
                        <div class="row">
                            <!-- Email-->
                            <div class="col-12">
                                <div class="form-group">
                                    <label for="email" class="form-label">Email</label>
                                    <input type="email" name="email" class="form-control" id="email" placeholder="you@example.com">
                                </div>
                                <!-- Mailing List Signup-->
                                <div class="form-group form-check m-0">
                                    <input type="checkbox" class="form-check-input" id="add-mailinglist" checked>
                                    <label class="form-check-label" for="add-mailinglist">Keep me updated with your latest news and offers</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /Checkout Panel Contact -->                    
                    <!-- Checkout Shipping Address -->
                    <div class="checkout-panel">
                        <h5 class="title-checkout">Shipping Address</h5>
                        <div class="row">
                            <!-- First Name-->
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label for="firstName" class="form-label">First name</label>
                                    <input type="text" name="firstName" class="form-control" id="firstName" placeholder="" value="" >
                                </div>
                            </div>
                            <!-- Last Name-->
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label for="lastName" class="form-label">Last name</label>
                                    <input type="text" name="lastName"  class="form-control" id="lastName" placeholder="" value="" >
                                </div>
                            </div>
                            <!-- Mobile Number-->
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label for="mobile" class="form-label">Mobile Number</label>
                                    <input type="number" name="mobile" class="form-control" id="mobile" placeholder="" value="" >
                                </div>
                            </div>
                            <!-- Post Code-->
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="zipCode" class="form-label">Zip/Post Code</label>
                                    <input type="text" name="zipCode" class="form-control" id="zipCode" placeholder="" >
                                </div>
                            </div>
                            <!-- State-->
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label for="state" class="form-label">State</label>
                                    <select class="form-select" id="state" name="state" data-placeholder="Please Select State">
                                        <option value=""></option>
                                        <option value="AP">Andhra Pradesh</option>
                                        <option value="AR">Arunachal Pradesh</option>
                                        <option value="AS">Assam</option>
                                        <option value="BR">Bihar</option>
                                        <option value="CT">Chhattisgarh</option>
                                        <option value="GA">Gujarat</option>
                                        <option value="HR">Haryana</option>
                                        <option value="HP">Himachal Pradesh</option>
                                        <option value="JK">Jammu and Kashmir</option>
                                        <option value="GA">Goa</option>
                                        <option value="JH">Jharkhand</option>
                                        <option value="KA">Karnataka</option>
                                        <option value="KL">Kerala</option>
                                        <option value="MP">Madhya Pradesh</option>
                                        <option value="MH">Maharashtra</option>
                                        <option value="MN">Manipur</option>
                                        <option value="ML">Meghalaya</option>
                                        <option value="MZ">Mizoram</option>
                                        <option value="NL">Nagaland</option>
                                        <option value="OR">Odisha</option>
                                        <option value="PB">Punjab</option>
                                        <option value="RJ">Rajasthan</option>
                                        <option value="SK">Sikkim</option>
                                        <option value="TN">Tamil Nadu</option>
                                        <option value="TG">Telangana</option>
                                        <option value="TR">Tripura</option>
                                        <option value="UT">Uttarakhand</option>
                                        <option value="UP">Uttar Pradesh</option>
                                        <option value="WB">West Bengal</option>
                                        <option value="AN">Andaman and Nicobar Islands</option>
                                        <option value="CH">Chandigarh</option>
                                        <option value="DN">Dadra and Nagar Haveli</option>
                                        <option value="DD">Daman and Diu</option>
                                        <option value="DL">Delhi</option>
                                        <option value="LD">Lakshadweep</option>
                                        <option value="PY">Puducherry</option>
                                    </select>
                                </div>
                            </div>
                            <!-- Address-->
                            <div class="col-12">
                                <div class="form-group">
                                    <label for="address" class="form-label">Address</label>
                                    <input type="text" name="address" class="form-control" id="address" placeholder="123 Some Street Somewhere" >
                                </div>
                            </div>
                        </div>
                        <div class="pt-4 mt-4 border-top d-flex justify-content-between align-items-center">
                            <!-- Shipping Same Checkbox-->
                            <div class="form-group form-check m-0">
                                <input type="checkbox" class="form-check-input" id="same-address" checked>
                                <label class="form-check-label" for="same-address" name="same-address">Use for billing address</label>
                            </div>
                        </div>
                    </div>
                    <!-- /Checkout Shipping Address -->                    
                    <!-- Checkout Billing Address-->
                    <div class="billing-address checkout-panel d-none">
                        <h5 class="title-checkout">Billing Address</h5>
                        <div class="row">
                            <!-- First Name-->
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label for="billingFirstName" class="form-label">First name</label>
                                    <input type="text" name="billingFirstName" class="form-control" id="billingFirstName" placeholder="" value="" >
                                </div>
                            </div>
                            <!-- Last Name-->
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label for="billingLastName" class="form-label">Last name</label>
                                    <input type="text" name="billingLastName"  class="form-control" id="billingLastName" placeholder="" value="" >
                                </div>
                            </div>
                            <!-- Mobile Number-->
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label for="billingMobile" class="form-label">Mobile Number</label>
                                    <input type="number" name="billingMobile" class="form-control" id="billingMobile" placeholder="" value="" >
                                </div>
                            </div>
                            <!-- Post Code-->
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="billingZipCode" class="form-label">Zip/Post Code</label>
                                    <input type="text" name="billingZipCode" class="form-control" id="billingZipCode" placeholder="" >
                                </div>
                            </div>
                            <!-- State-->
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label for="billingState" class="form-label">State</label>
                                    <select class="form-select" id="billingState" name="billingState" data-placeholder="Please Select State">
                                        <option value=""></option>
                                        <option value="AP">Andhra Pradesh</option>
                                        <option value="AR">Arunachal Pradesh</option>
                                        <option value="AS">Assam</option>
                                        <option value="BR">Bihar</option>
                                        <option value="CT">Chhattisgarh</option>
                                        <option value="GA">Gujarat</option>
                                        <option value="HR">Haryana</option>
                                        <option value="HP">Himachal Pradesh</option>
                                        <option value="JK">Jammu and Kashmir</option>
                                        <option value="GA">Goa</option>
                                        <option value="JH">Jharkhand</option>
                                        <option value="KA">Karnataka</option>
                                        <option value="KL">Kerala</option>
                                        <option value="MP">Madhya Pradesh</option>
                                        <option value="MH">Maharashtra</option>
                                        <option value="MN">Manipur</option>
                                        <option value="ML">Meghalaya</option>
                                        <option value="MZ">Mizoram</option>
                                        <option value="NL">Nagaland</option>
                                        <option value="OR">Odisha</option>
                                        <option value="PB">Punjab</option>
                                        <option value="RJ">Rajasthan</option>
                                        <option value="SK">Sikkim</option>
                                        <option value="TN">Tamil Nadu</option>
                                        <option value="TG">Telangana</option>
                                        <option value="TR">Tripura</option>
                                        <option value="UT">Uttarakhand</option>
                                        <option value="UP">Uttar Pradesh</option>
                                        <option value="WB">West Bengal</option>
                                        <option value="AN">Andaman and Nicobar Islands</option>
                                        <option value="CH">Chandigarh</option>
                                        <option value="DN">Dadra and Nagar Haveli</option>
                                        <option value="DD">Daman and Diu</option>
                                        <option value="DL">Delhi</option>
                                        <option value="LD">Lakshadweep</option>
                                        <option value="PY">Puducherry</option>
                                    </select>
                                </div>
                            </div>
                            <!-- Address-->
                            <div class="col-12">
                                <div class="form-group">
                                    <label for="billingAddress" class="form-label">Address</label>
                                    <input type="text" name="billingAddress" class="form-control" id="billingAddress" placeholder="123 Some Street Somewhere" >
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- / Checkout Billing Address-->                    
                    <!-- Checkout Shipping Method-->
                    <div class="checkout-panel">
                        <h5 class="title-checkout">Shipping Method</h5>
                    
                        <!-- Free Shipping Option-->
                        <div class="form-check form-group form-check-custom form-radio-custom mb-3">
                            <input class="form-check-input" type="radio" name="shipping" id="freeShipping" value="free" checked>
                            <label class="form-check-label" for="freeShipping">
                                <span class="d-flex justify-content-between align-items-start w-100">
                                    <span>
                                        <span class="mb-0 fw-bolder d-block">Click & Collect Shipping</span>
                                        <small class="fw-bolder">Collect from our London store</small>
                                    </span>
                                    <span class="small fw-bolder text-uppercase">Free</span>
                                </span>
                            </label>
                        </div>
                    
                        <!-- Nest Day Shipping Option-->
                        <div class="form-check form-group form-check-custom form-radio-custom mb-3">
                            <input class="form-check-input" type="radio" name="shipping" id="nextDay" value="nextDay">
                            <label class="form-check-label" for="nextDay">
                                <span class="d-flex justify-content-between align-items-start">
                                    <span>
                                        <span class="mb-0 fw-bolder d-block">UPS Next Day</span>
                                        <small class="fw-bolder">For all orders placed before 1pm Monday to Thursday</small>
                                    </span>
                                    <span class="small fw-bolder text-uppercase"><i class="fa fa-rupee"></i> 100.00</span>
                                </span>
                            </label>
                        </div>
                    
                        <!-- courier Shipping Option-->
                        <div class="form-check form-group form-check-custom form-radio-custom mb-3">
                            <input class="form-check-input" type="radio" name="shipping" id="courier" value="courier">
                            <label class="form-check-label" for="courier">
                                <span class="d-flex justify-content-between align-items-start">
                                    <span>
                                        <span class="mb-0 fw-bolder d-block">DHL Priority Service</span>
                                        <small class="fw-bolder">24 - 36 hour delivery</small>
                                    </span>
                                    <span class="small fw-bolder text-uppercase"><i class="fa fa-rupee"></i> 50.00</span>
                                </span>
                            </label>
                        </div>
                    </div>
                    <!-- /Checkout Shipping Method -->                    
                    <!-- Checkout Payment Method-->
                    <div class="checkout-panel">
                        <h5 class="title-checkout">Payment Information</h5>
                        <div class="row">
                            <!-- Payment Cod Option-->
                            <div class="col-12">
                                <div class="form-check form-group form-check-custom form-radio-custom mb-3">
                                    <input class="form-check-input" type="radio" name="paymentMethod" id="cod" value="cod" checked>
                                    <label class="form-check-label" for="cod">
                                        <span class="d-flex justify-content-between align-items-start">
                                            <span>
                                            <span class="mb-0 fw-bolder d-block">Cash On Delivery</span>
                                            </span>
                                            <i class="fa fa-rupee"></i>
                                        </span>
                                    </label>
                                </div>
                            </div>
                            <!-- Payment credi card Option-->
                            <div class="col-12">
                                <div class="form-check form-group form-check-custom form-radio-custom mb-3">
                                    <input class="form-check-input" type="radio" name="paymentMethod" id="creditCard" value="creditCard">
                                    <label class="form-check-label" for="creditCard">
                                        <span class="d-flex justify-content-between align-items-start">
                                            <span>
                                                <span class="mb-0 fw-bolder d-block">Credit Card (Stripe)</span>
                                            </span>
                                            <i class="ri-bank-card-line"></i>
                                        </span>
                                    </label>
                                </div>
                            </div>
                            <!-- Payment Option-->
                            <div class="col-12">
                                <div class="form-check form-group form-check-custom form-radio-custom mb-3">
                                    <input class="form-check-input" type="radio" name="paymentMethod" id="upi" value="upi">
                                    <label class="form-check-label" for="upi">
                                        <span class="d-flex justify-content-between align-items-start">
                                            <span>
                                                <span class="mb-0 fw-bolder d-block">UPI</span>
                                            </span>
                                            <i class="fa-brands fa-google-pay fa-xl pt-2"></i>
                                            <!--- <i class="ri-bank-card-line"></i> --->
                                        </span>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <!-- COD Info-->
                        <div class="cod-details bg-light p-4mt-3 fw-bolder">
                            Please click on complete order. You will then be transferred to COD to enter your payment details.
                        </div>
                        <!-- /COD Info-->
                        <!-- Credit Card Payment Details-->
                        <div class="card-details d-none">
                            <div class="row pt-3">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label for="creditCardName" class="form-label">Name on card</label>
                                        <input type="text" class="form-control" name="creditCardName" id="creditCardName" placeholder="" >
                                        <small class="text-muted">Full name as displayed on card</small>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label for="creditCardNumber" class="form-label">Credit card number</label>
                                        <input type="text" class="form-control" name="creditCardNumber" id="creditCardNumber" placeholder="" >
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="cardExpieryDate" class="form-label">Expiration</label>
                                        <input type="date" class="form-control" name="cardExpieryDate" id="cardExpieryDate" placeholder="" >
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <div class="d-flex">
                                            <label for="cvv" class="form-label d-flex w-100 justify-content-between align-items-center">Security Code</label>
                                            <button type="button" class="btn btn-link p-0 fw-bolder fs-xs text-nowrap" data-bs-toggle="tooltip"
                                                data-bs-placement="top" title="A CVV is a number on your credit card or debit card that's in addition to your credit card number and expiration date">
                                                What's this?
                                            </button>
                                        </div>
                                        <input type="text" class="form-control" name="cvv" id="cvv" placeholder="" >
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- / Credit Card Payment Details-->
                        <!-- UPI Info-->
                        <div class="upi-details bg-light p-4 d-none mt-3 fw-bolder">
                            <div class="row pt-3">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label for="UPIID" class="form-label">UPI Number/UPI ID</label>
                                        <input type="text" class="form-control" name="UPIID" id="UPIID" placeholder="" >
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /UPI Info-->
                    </div>
                    <!-- /Checkout Payment Method-->                
                </div>
                <!-- / Checkout Panel Left -->
                <!-- Checkout Panel Summary -->
                <div class="col-12 col-lg-6 col-xl-5">
                    <div class="bg-light p-4 sticky-md-top top-5">
                        <div class="border-bottom pb-3">
                            <!-- Cart Item-->
                            <cfset productSubTotal = 0>
                            <cfloop query="getAllCartProductQry">
                                <cfset priceTotal = getAllCartProductQry.quantity * getAllCartProductQry.price>
                                <cfset productSubTotal +=  priceTotal >
                                <cfquery name="getProductImage">
                                    SELECT image, isDefault
                                    FROM product_image 
                                    WHERE FkProductId = <cfqueryparam value="#getAllCartProductQry.FkProductId#" cfsqltype = "cf_sql_integer">
                                </cfquery>
                                <div class="d-none d-md-flex justify-content-between align-items-start py-2">
                                    <div class="d-flex flex-grow-1 justify-content-start align-items-start">
                                        <div class="position-relative f-w-20 border p-2 me-4">
                                            <span class="checkout-item-qty">#getAllCartProductQry.quantity#</span>
                                            <img src="#imagePath##getProductImage.image#" alt="" class="rounded img-fluid">
                                        </div>
                                        <div>
                                            <p class="mb-1 fs-6 fw-bolder">#getAllCartProductQry.productName#</p>
                                        </div>
                                    </div>
                                    <div class="flex-shrink-0 fw-bolder">
                                        <i class="fa fa-rupee"></i> <span>#priceTotal#</span>
                                    </div>
                                </div>
                            </cfloop>
                            <!-- / Cart Item-->
                        </div>
                        <div class="py-3 border-bottom">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <p class="m-0 fw-bolder fs-6">Subtotal</p>
                                <p class="m-0 fs-6 fw-bolder"><i class="fa fa-rupee"></i> <span>#productSubTotal#</span></p>
                            </div>
                            <div class="d-flex justify-content-between align-items-center ">
                                <p class="m-0 fw-bolder fs-6">Shipping</p>
                                <p class="m-0 fs-6 fw-bolder">$8.95</p>
                            </div>
                        </div>
                        <div class="py-3 border-bottom">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <p class="m-0 fw-bold fs-5">Grand Total</p>
                                </div>
                                <p class="m-0 fs-5 fw-bold"><i class="fa fa-rupee"></i> <span>#productSubTotal#</span></p>
                            </div>
                        </div>
                        <div class="py-3 border-bottom">
                            <div class="input-group mb-0">
                                <input type="text" class="form-control" placeholder="Enter your coupon code">
                                <button class="btn btn-dark btn-sm px-4">Apply</button>
                            </div>
                        </div> 
                        <!-- Accept Terms Checkbox-->
                        <div class="form-group form-check my-4">
                            <input type="checkbox" class="form-check-input" id="accept-terms" checked>
                            <label class="form-check-label fw-bolder" for="accept-terms">I agree to Alpine's <a href="##">terms & conditions</a></label>
                        </div>
                        <button type="submit" class="<!--- btn btn-dark w-100 --->btn btn-dark w-100 fw-bolder d-block text-center transition-all opacity-50-hover" >Complete Order</button>      
                    </div>                
                </div>
                <!-- /Checkout Panel Summary -->
            </div>
        </form>
    </section>
    <!-- / CheckOut Container-->

    <script>
        var #toScript('#customerId#', 'customerId')#
        $(document).ready( function () { 
            $('##state').select2({
                theme: "bootstrap-5",
                width: $( this ).data( 'width' ) ? $( this ).data( 'width' ) : $( this ).hasClass( 'w-100' ) ? '100%' : 'style',
                placeholder: $( this ).data( 'placeholder' ),
                allowClear: true,
            });
            $('##billingState').select2({
                theme: "bootstrap-5",
                width: $( this ).data( 'width' ) ? $( this ).data( 'width' ) : $( this ).hasClass( 'w-100' ) ? '100%' : 'style',
                placeholder: $( this ).data( 'placeholder' ),
                allowClear: true,
            });
            var validator = $("##addOrderForm").validate({
                rules: {
                    email: {
                        required: true
                    },
                    firstName: {
                        required: true
                    },
                    lastName: {
                        required: true
                    },
                    mobile: {
                        required: true,
                        digits:true
                    },
                    zipCode: {
                        required: true,
                        digits:true
                    },
                    state: {
                        required: true
                    },
                    address: {
                        required: true
                    }, 
                    billingFirstName: {
                        required: function(){
                            return checkRequireBill();
                        }
                    },
                    billingLastName: {
                        required: function(){
                            return checkRequireBill();
                        }
                    },
                    billingMobile: {
                        required: function(){
                            return checkRequireBill();
                        }
                    },
                    billingZipCode: {
                        required: function(){
                            return checkRequireBill();
                        }
                    },
                    billingState: {
                        required: function(){
                            return checkRequireBill();
                        }
                    },
                    billingAddress: {
                        required: function(){
                            return checkRequireBill();
                        }
                    },
                    creditCardName: {
                        required: function(){
                            return checkRequireCreditCard();
                        }
                    },
                    creditCardNumber: {
                        required: function(){
                            return checkRequireCreditCard();

                        }
                    },
                    cardExpieryDate: {
                        required: function(){
                            return checkRequireCreditCard();
                        }
                    },
                    cvv: {
                        required: function(){
                            return checkRequireCreditCard();
                        }
                    },
                    UPIID: {
                        required: function(){
                            if( $('##upi' ).prop('checked') == true){
                                return true;
                            }else{
                                return false;
                            }
                        }
                    },
                },
                messages: {
                    email: {
                        required: "Please enter email address",                    
                    },
                    firstName: {
                        required: "Please enter first name",                    
                    },
                    lastName: {
                        required: "Please enter last name",                    
                    },
                    mobile: {
                        required: "Please enter mobile number",                    
                    },
                    zipCode: {
                        required: "Please enter zip code",                    
                    },
                    state: {
                        required: "Please select state",                    
                    },
                    address: {
                        required: "Please enter address",                    
                    },
                    billingFirstName: {
                        required: "Please enter first name for billing address",                    
                    },
                    billingLastName: {
                        required: "Please enter last name for billing address",                    
                    },
                    billingMobile: {
                        required: "Please enter mobile number for billing address",                    
                    },
                    billingZipCode: {
                        required: "Please enter zip code for billing address",                    
                    },
                    billingState: {
                        required: "Please select state for billing address",                    
                    },
                    billingAddress: {
                        required: "Please enter address for billing address",                    
                    },
                    creditCardName: {
                        required: "Please enter credit card holder name",                    
                    },
                    creditCardNumber: {
                        required: "Please enter credit card number",                    
                    },
                    cardExpieryDate: {
                        required: "Please enter credit card expiry date",                    
                    },
                    cvv: {
                        required: "Please enter credit card cvv number",                    
                    },
                    UPIID: {
                        required: "Please enter upi id/upi number",                    
                    },
                },
                ignore: [],
                errorElement: 'span',
                errorPlacement: function (error, element) {
                    var elem = $(element);
                    if (elem.hasClass("select2-hidden-accessible")) {
                        element = element.siblings(".select2");
                        error.insertAfter(element);
                    } else {
                        error.insertAfter(element);
                    }
                    error.addClass('invalid-feedback');
                },
                highlight: function (element, errorClass, validClass) {
                    if ($(element).hasClass('select2-hidden-accessible')) {
                        $(element).siblings('.select2').children('span').children('span.select2-selection').addClass("invalidCs")
                    } 
                    $(element).addClass('is-invalid');
                },
                unhighlight: function (element, errorClass, validClass) {
                    $(element).removeClass('is-invalid');
                    if ($(element).hasClass('select2-hidden-accessible')) {
                        $(element).siblings('.select2').children('span').children('span.select2-selection').removeClass("invalidCs");
                    }
                },
                submitHandler: function (form) {
                    event.preventDefault();
                    submitProductData();
                    
                }, 
            });

        });
        function checkRequireBill() {
            if( $('##same-address' ).prop('checked') == false ){
                return true;
            }else{
                return false;
            }
        }
        function checkRequireCreditCard() {
            if( $('##creditCard' ).prop('checked') == true){
                return true;
            }else{
                return false;
            }
        }
        function submitProductData() {
            var formData = new FormData($('##addOrderForm')[0]);
            $.ajax({
                type: "POST",
                url: "../ajaxOrder.cfm?customerId=" + customerId,
                data: formData,
                contentType: false,
                processData: false,
                success: function(result) {
                    console.log(result);
                    if (result.success) {
                        successToast("Your order is successfully completed!");
                    }
                }
            });
        }
    </script>
</cfoutput>