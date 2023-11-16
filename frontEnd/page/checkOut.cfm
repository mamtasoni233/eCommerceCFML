<cfparam name="PkProductId" default="" />
<cfparam name="productName" default="" />
<cfparam name="productPrice" default="" />
<cfparam name="productQty" default="" />
<cfparam name="isDeleted" default="0" />
<cfset customerId = session.customer.isLoggedIn>
<cfset sessionCouponId = session.cart.couponId>
<cfquery name="qryGetOrderDetail">
    SELECT FkCustomerId, firstName, lastName, email, mobile, address, state, zipCode, billingFirstName, billingLastName, billingMobile, billingAddress, billingState, billingZipCode, shipping, finalAmount, discountValue, paymentMethod, UPIID, creditCardName, creditCardNumber, cardExpieryDate, cvv
    FROM orders 
    WHERE FkCustomerId = <cfqueryparam value = "#customerId#" cfsqltype = "cf_sql_integer">
</cfquery>
<cfset finalAmount = 0>
<cfoutput>
    <style>
        .form-control{
            border-radius: 0 !important;
        }
        .bootstrap-tagsinput  {
            padding: 14px 6px;
        }
        .bootstrap-tagsinput .tag {
            background: red;
            padding: 4px;
            font-size: 14px;
        }
    </style>
    <cfset imagePath = "http://127.0.0.1:50847/assets/productImage/">
    <!--- <cfdump  var="#session#"> --->
    <!-- CheckOut Container-->
    <cfif isEmpty(session.cart.product)>
        <h1 class="mb-3 display-5 fw-bold text-center ">No Product Add In Cart</h1>
    <cfelse>
        <section class="container mt5">
            <h1 class="mb-3 display-5 fw-bold text-center chekOutHeading">Checkout Securely</h1>
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
                                        <input type="email" name="email" class="form-control" id="email" value="#qryGetOrderDetail.email#" placeholder="you@example.com">
                                    </div>
                                    <!-- Mailing List Signup-->
                                    <!---  <div class="form-group form-check m-0">
                                        <input type="checkbox" class="form-check-input" id="add-mailinglist" checked>
                                        <label class="form-check-label" for="add-mailinglist">Keep me updated with your latest news and offers</label>
                                    </div> --->
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
                                        <input type="text" name="firstName" class="form-control" id="firstName" placeholder="Enter First Name" value="#qryGetOrderDetail.firstName#">
                                    </div>
                                </div>
                                <!-- Last Name-->
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="lastName" class="form-label">Last name</label>
                                        <input type="text" name="lastName"  class="form-control" id="lastName" placeholder="Enter Last Name" value="#qryGetOrderDetail.lastName#" >
                                    </div>
                                </div>
                                <!-- Mobile Number-->
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="mobile" class="form-label">Mobile Number</label>
                                        <input type="number" name="mobile" class="form-control" id="mobile" placeholder="Enter Mobile Number" value="#qryGetOrderDetail.mobile#" >
                                    </div>
                                </div>
                                <!-- Post Code-->
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="zipCode" class="form-label">Zip/Post Code</label>
                                        <input type="text" name="zipCode" class="form-control" id="zipCode" placeholder="Enter Zip Code" value="#qryGetOrderDetail.zipCode#">
                                    </div>
                                </div>
                                <!-- State-->
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label for="state" class="form-label">State</label>
                                        <select class="form-select" id="state" name="state" data-placeholder="Please Select State">
                                            <option value=""></option>
                                            <option value="AP" <cfif qryGetOrderDetail.state EQ 'AP'>selected</cfif>>Andhra Pradesh</option>
                                            <option value="AR" <cfif qryGetOrderDetail.state EQ 'AR'>selected</cfif>>Arunachal Pradesh</option>
                                            <option value="AS" <cfif qryGetOrderDetail.state EQ 'AS'>selected</cfif>>Assam</option>
                                            <option value="BR" <cfif qryGetOrderDetail.state EQ 'BR'>selected</cfif>>Bihar</option>
                                            <option value="CT" <cfif qryGetOrderDetail.state EQ 'CT'>selected</cfif>>Chhattisgarh</option>
                                            <option value="GA" <cfif qryGetOrderDetail.state EQ 'GA'>selected</cfif>>Gujarat</option>
                                            <option value="HR" <cfif qryGetOrderDetail.state EQ 'HR'>selected</cfif>>Haryana</option>
                                            <option value="HP" <cfif qryGetOrderDetail.state EQ 'HP'>selected</cfif>>Himachal Pradesh</option>
                                            <option value="JK" <cfif qryGetOrderDetail.state EQ 'JK'>selected</cfif>>Jammu and Kashmir</option>
                                            <option value="GA" <cfif qryGetOrderDetail.state EQ 'GA'>selected</cfif>>Goa</option>
                                            <option value="JH" <cfif qryGetOrderDetail.state EQ 'JH'>selected</cfif>>Jharkhand</option>
                                            <option value="KA" <cfif qryGetOrderDetail.state EQ 'KA'>selected</cfif>>Karnataka</option>
                                            <option value="KL" <cfif qryGetOrderDetail.state EQ 'KL'>selected</cfif>>Kerala</option>
                                            <option value="MP" <cfif qryGetOrderDetail.state EQ 'MP'>selected</cfif>>Madhya Pradesh</option>
                                            <option value="MH" <cfif qryGetOrderDetail.state EQ 'MH'>selected</cfif>>Maharashtra</option>
                                            <option value="MN" <cfif qryGetOrderDetail.state EQ 'MN'>selected</cfif>>Manipur</option>
                                            <option value="ML" <cfif qryGetOrderDetail.state EQ 'ML'>selected</cfif>>Meghalaya</option>
                                            <option value="MZ" <cfif qryGetOrderDetail.state EQ 'MZ'>selected</cfif>>Mizoram</option>
                                            <option value="NL" <cfif qryGetOrderDetail.state EQ 'NL'>selected</cfif>>Nagaland</option>
                                            <option value="OR" <cfif qryGetOrderDetail.state EQ 'OR'>selected</cfif>>Odisha</option>
                                            <option value="PB" <cfif qryGetOrderDetail.state EQ 'PB'>selected</cfif>>Punjab</option>
                                            <option value="RJ" <cfif qryGetOrderDetail.state EQ 'RJ'>selected</cfif>>Rajasthan</option>
                                            <option value="SK" <cfif qryGetOrderDetail.state EQ 'SK'>selected</cfif>>Sikkim</option>
                                            <option value="TN" <cfif qryGetOrderDetail.state EQ 'TN'>selected</cfif>>Tamil Nadu</option>
                                            <option value="TG" <cfif qryGetOrderDetail.state EQ 'TG'>selected</cfif>>Telangana</option>
                                            <option value="TR" <cfif qryGetOrderDetail.state EQ 'TR'>selected</cfif>>Tripura</option>
                                            <option value="UT" <cfif qryGetOrderDetail.state EQ 'UT'>selected</cfif>>Uttarakhand</option>
                                            <option value="UP" <cfif qryGetOrderDetail.state EQ 'UP'>selected</cfif>>Uttar Pradesh</option>
                                            <option value="WB" <cfif qryGetOrderDetail.state EQ 'WB'>selected</cfif>>West Bengal</option>
                                            <option value="AN" <cfif qryGetOrderDetail.state EQ 'AN'>selected</cfif>>Andaman and Nicobar Islands</option>
                                            <option value="CH" <cfif qryGetOrderDetail.state EQ 'AP'>selected</cfif>>Chandigarh</option>
                                            <option value="DN" <cfif qryGetOrderDetail.state EQ 'AP'>selected</cfif>>Dadra and Nagar Haveli</option>
                                            <option value="DD" <cfif qryGetOrderDetail.state EQ 'AP'>selected</cfif>>Daman and Diu</option>
                                            <option value="DL" <cfif qryGetOrderDetail.state EQ 'AP'>selected</cfif>>Delhi</option>
                                            <option value="LD" <cfif qryGetOrderDetail.state EQ 'AP'>selected</cfif>>Lakshadweep</option>
                                            <option value="PY" <cfif qryGetOrderDetail.state EQ 'AP'>selected</cfif>>Puducherry</option>
                                        </select>
                                    </div>
                                </div>
                                <!-- Address-->
                                <div class="col-12">
                                    <div class="form-group">
                                        <label for="address" class="form-label">Address</label>
                                        <textarea name="address" class="form-control" id="address" row="1" placeholder="123 Some Street Somewhere" >#qryGetOrderDetail.address#</textarea>
                                        <!---  <input type="text" name="address" class="form-control" id="address" placeholder="123 Some Street Somewhere" > --->
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
                                        <!--- <input type="text" name="billingAddress" class="form-control" id="billingAddress" placeholder="123 Some Street Somewhere" > --->
                                        <textarea name="billingAddress" class="form-control" id="billingAddress" row="1" placeholder="123 Some Street Somewhere" ></textarea>
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
                                <input class="form-check-input" type="radio" name="shipping" id="freeShipping" data-value="0" value="free" <cfif structKeyExists(session.cart, 'shipping') AND session.cart.shipping EQ 0>checked</cfif>>
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
                                <input class="form-check-input" type="radio" name="shipping" id="nextDay" data-value="50.00" value="nextDay" <cfif structKeyExists(session.cart, 'shipping') AND session.cart.shipping EQ 50.00>checked</cfif>>
                                <label class="form-check-label" for="nextDay">
                                    <span class="d-flex justify-content-between align-items-start">
                                        <span>
                                            <span class="mb-0 fw-bolder d-block">UPS Next Day</span>
                                            <small class="fw-bolder">For all orders placed before 1pm Monday to Thursday</small>
                                        </span>
                                        <span class="small fw-bolder text-uppercase">
                                            <i class="fa fa-rupee"></i> 
                                            <span>50.00</span>
                                        </span>
                                    </span>
                                </label>
                            </div>
                        
                            <!-- courier Shipping Option-->
                            <div class="form-check form-group form-check-custom form-radio-custom mb-3">
                                <input class="form-check-input" type="radio" name="shipping" id="courier" data-value="100.00" value="courier" <cfif structKeyExists(session.cart, 'shipping') AND session.cart.shipping EQ 100.00>checked</cfif>>
                                <label class="form-check-label" for="courier">
                                    <span class="d-flex justify-content-between align-items-start">
                                        <span>
                                            <span class="mb-0 fw-bolder d-block">DHL Priority Service</span>
                                            <small class="fw-bolder">24 - 36 hour delivery</small>
                                        </span>
                                        <span class="small fw-bolder text-uppercase">
                                            <i class="fa fa-rupee"></i> 
                                            <span>100.00</span> 
                                        </span>
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
                                            </span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <!-- COD Info-->
                            <div class="cod-details bg-light p-4 mt-3 fw-bolder">
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
                                            <input type="text" class="form-control" name="creditCardNumber" id="creditCardNumber" placeholder=""  >
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="cardExpieryDate" class="form-label">Expiration</label>
                                            <input type="date" class="form-control" name="cardExpieryDate" id="cardExpieryDate" placeholder="">
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
                                            <input type="text" class="form-control" name="UPIID" id="UPIID" placeholder="">
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
                        <div class="bg-light p-4 sticky-md-top top-5 z-index-1">
                            <div class="border-bottom pb-3">
                                <!-- Cart Item-->
                                <!--- <cfset productSubTotal = 0> --->
                                <cfset totalPrice = 0>
                                <cfset discountValue = session.cart.Discount>
                                <cfloop array="#session.cart.product#" item="item">
                                    <!--- <cfset productSubTotal +=  item.TotalCost > --->
                                    <!--- <cfset totalPrice = session.cart.finalAmount - discountValue > --->
                                    <div class="d-none d-md-flex justify-content-between align-items-start py-2">
                                        <div class="d-flex flex-grow-1 justify-content-start align-items-start">
                                            <div class="position-relative f-w-20 border p-2 me-4">
                                                <span class="checkout-item-qty">#item.Quantity#</span>
                                                <img src="#imagePath##item.Image#" alt="" class="rounded img-fluid">
                                            </div>
                                            <div>
                                                <p class="mb-1 fs-6 fw-bolder">#item.Name#</p>
                                            </div>
                                        </div>
                                        <div class="flex-shrink-0 fw-bolder">
                                            <i class="fa fa-rupee"></i> <span>#item.TotalCost#</span>
                                        </div>
                                    </div>
                                </cfloop>
                                <!-- / Cart Item-->
                            </div>
                            <div class="py-3 border-bottom">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <p class="m-0 fw-bolder fs-6">Subtotal</p>
                                    <p class="m-0 fs-6 fw-bolder"><i class="fa fa-rupee"></i> <span>#session.cart.finalAmount#</span></p>
                                </div>
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <p class="m-0 fw-bolder fs-6">Shipping</p>
                                    <p class="m-0 fs-6 fw-bolder"><!--- <i class="fa fa-rupee"></i>  ---><span id="shippingTotal">#session.cart.shipping#</span></p>
                                </div>
                                <div class="d-flex justify-content-between align-items-center ">
                                    <p class="m-0 fw-bolder fs-6">Discount</p>
                                    <p class="m-0 fs-6 fw-bolder"><i class="fa fa-rupee"></i> <span id="totalDiscount">#discountValue#</span></p>
                                </div>
                            </div>
                            <div class="py-3 border-bottom">
                                <div class="d-flex justify-content-between align-items-center">
                                    
                                    <cfset finalAmount =  (session.cart.finalAmount + session.cart.shipping) - session.cart.Discount >
                                    <div>
                                        <p class="m-0 fw-bold fs-5">Grand Total</p>
                                    </div>
                                    <p class="m-0 fs-5 fw-bold"><i class="fa fa-rupee"></i> <span id="grandTotal">#finalAmount#</span></p>
                                </div>
                            </div>
                            <!-- Coupon Code-->
                            <div class="d-flex justify-content-between">
                                <button class="btn btn-link p-0 my-3 fw-bolder text-decoration-none" type="button"
                                    data-bs-toggle="collapse" data-bs-target="##couponContainer" aria-expanded="false"
                                    aria-controls="couponContainer">
                                    <span class="d-flex">
                                        <img class="w23 f-left" src="https://media6.ppl-media.com/mediafiles/ecomm/promo/1669713839_icon_coupon.svg">
                                        <span class="text-orange  px-3 fw-bold">Apply Promo Code</span>
                                    </span> 
                                </button>
                                <cfif sessionCouponId GT 0>
                                    <button type="button" id="removeCoupon" class="btn btn-link btn-sm btn-light btn-outline-none text-danger <!--- d-none ---> btn-link p-0 my-3 fw-bold pe-auto">Remove Coupon</button>
                                <cfelse>
                                    <button type="button" id="removeCoupon" class="btn btn-link btn-sm btn-light btn-outline-none text-danger d-none btn-link p-0 my-3 fw-bold pe-auto">Remove Coupon</button>
                                </cfif>
                            </div>
                            <div class="collapse" id="couponContainer">
                                <cfset checkFkProductId = arrayMap(session.cart.product, function(item) {
                                    return item.FkProductId
                                })>
                                <cfset currentDate = dateFormat(now(), 'yyyy-mm-dd')>
                                <cfquery name="getCoupon">
                                    
                                    SELECT PkCouponId, FkProductId, couponName, couponCode, description, couponStartDate, couponExpDate 
                                    FROM coupons 
                                    WHERE FkproductId IN (0,<cfqueryparam value="#checkFkProductId#" list="true">) 
                                    AND couponStartDate <=<cfqueryparam value="#now()#" cfsqltype="cf_sql_date"> AND couponExpDate >=<cfqueryparam value="#now()#" cfsqltype="cf_sql_date">
                                </cfquery>
                                <cfquery name="qryGetCouponName" dbtype="query">
                                    SELECT *
                                    FROM getCoupon
                                    WHERE PkCouponId = <cfqueryparam value="#session.cart.couponId#" cfsqltype="cf_sql_integer">
                                </cfquery>
                                <div class="card card-body border p-2">
                                    <div class="input-group mt-3 couponApplied">
                                        <input type="text" name="couponAppliedInput" id="couponAppliedInput" class="form-control couponAppliedInput" placeholder="Enter coupon" value="#qryGetCouponName.couponCode#" <!--- data-role="tagsinput" --->>
                                        <button type="button" class="btn btn-dark btn-sm px-4 text-center" id="couponAppliedBtn">Apply</button>
                                    </div>
                                    <div id="alertDiv"></div>
                                    <div class="text-center mt-3"><h5>OR</h5></div>
                                    <div id="couponListContainer">
                                        <div class="">
                                            <!-- Coupon Options -->
                                            <cfloop query="getCoupon">
                                                <div class="mt-0" id="couponList">
                                                    <div class="d-flex justify-content-between w-100">
                                                        <div id="couponDetails-#getCoupon.PkCouponId#" data-id="#getCoupon.PkCouponId#" class="couponDetails mb-2 <cfif structKeyExists(session.cart, 'couponId') AND session.cart.couponId EQ getCoupon.PkCouponId>text-decoration-line-through</cfif>">
                                                            <span class="fw-bolder">#getCoupon.couponName# -</span>
                                                            <span class="fw-bold text-uppercase couponcode">#getCoupon.couponCode#</span>
                                                            <div class="small">(#getCoupon.description#)</div>
                                                        </div>
                                                        <div>
                                                            <input class="btn btn-sm btn-orange text-center text-white mb-2 addCoupon <cfif structKeyExists(session.cart, 'couponId') AND session.cart.couponId EQ getCoupon.PkCouponId>disabled</cfif>" type="button" name="addCoupon" data-coupon="#getCoupon.couponCode#" data-cid="#getCoupon.PkCouponId#" id="addCoupon-#getCoupon.PkCouponId#" value="Apply">
                                                        </div>
                                                    </div>
                                                </div> 
                                            </cfloop>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- / Coupon Code-->
                            <!-- Accept Terms Checkbox-->
                            <div class="form-group form-check my-4">
                                <input type="checkbox" class="form-check-input" name="acceptTerms" id="accept-terms" checked>
                                <label class="form-check-label fw-bolder" for="accept-terms">I agree to Alpine's <a href="##">terms & conditions</a></label>
                            </div>
                            <button type="submit" class="btn btn-dark w-100 fw-bolder d-block text-center transition-all opacity-50-hover" >Complete Order</button>      
                        </div>                
                    </div>
                    <!-- /Checkout Panel Summary -->
                </div>
            </form>
        </section>
    </cfif>
    <!-- / CheckOut Container-->

    <script>
        var #toScript('#customerId#', 'customerId')#
        var #toScript('#finalAmount#', 'finalAmount')#
        var #toScript('#sessionCouponId#', 'sessionCouponId')#
        var shippingValue = 0;
        var couponCode = '';
        /* let totalPrice = 0;
        var grandTotal = $('##grandTotal').html(); */
        $(document).ready( function () { 
            // const regexUPI = ^[a-zA-Z0-9.-]{2, 256}@[a-zA-Z][a-zA-Z]{2, 64}$;
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
            /* $('input[name=shipping]').on("click", function () {
                var value = $(this).attr('data-value');
                if (value == 'Free') {
                    totalPrice = parseFloat(grandTotal);
                } else {
                    totalPrice = parseFloat(value) + parseFloat(grandTotal);
                }
                parseFloat($('##shippingTotal').html(value));
                $('##grandTotal').html(totalPrice);
            }); */
            $('input[name=shipping]').on("change", function () {
                shippingValue = $(this).attr('data-value');
                //alert(shippingValue)
                /* console.log(shippingValue); */
                // var grandTotal = $('##grandTotal').html();
                ajaxAddCouponShipping(couponCode, shippingValue);
                /* if (shippingValue == 'Free') {
                    totalPrice = 0 + parseFloat(grandTotal);
                } else { */
                    // totalPrice = parseFloat(shippingValue) + parseFloat(grandTotal);
               /*  } */
                /*   $('##grandTotal').html(totalPrice); */
                /* grandTotal = totalPrice; */
                parseFloat($('##shippingTotal').html(shippingValue));
                /* grandTotal = parseFloat(shippingValue) + parseFloat(grandTotal); */
            });
            $.validator.addMethod(
                "regex",
                function(value, element, regexp) {
                    return this.optional(element) || regexp.test(value);
                },
                "Please enter correct upi addess...."
            );
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
                        },
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
                            } else {
                                return false;
                            }
                        },
                        regex: /^[0-9A-Za-z.-]{2,256}@[A-Za-z]{2,64}$/
                    },
                    acceptTerms: {
                        required: function(){
                            if( $('##accept-terms' ).prop('checked') == true){
                                return false;
                            }else{
                                return true;
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
                        regex: 'Please enter correct upi addess'
                    },
                    acceptTerms: {
                        required: "Please checked the aggree terms and conditions",                    
                    },
                },
                ignore: [],
                errorElement: 'span',
                errorPlacement: function (error, element) {
                    var elem = $(element);
                    /* if (elem.hasClass("select2-hidden-accessible")) {
                        element = element.siblings(".select2");
                        error.insertAfter(element);
                    } else {
                        error.insertAfter(element);
                    } */
                    if (elem.hasClass("select2-hidden-accessible")) {
                        element = element.siblings(".select2");
                        error.insertAfter(element);
                    } else if (elem.attr("name") == "acceptTerms") {
                        error.insertAfter($('##accept-terms'));
                    } else {
                        error.insertAfter(element);
                    }
                    error.addClass('invalid-feedback');
                },
                highlight: function (element, errorClass, validClass) {
                    /*  if ($(element).hasClass('select2-hidden-accessible')) {
                        $(element).siblings('.select2').children('span').children('span.select2-selection').addClass("invalidCs")
                    } */
                    if ($(element).hasClass('form-check-input')){
                        if ($(element).attr('name') == 'acceptTerms') {
                            $('##accept-terms').addClass('is-invalid');
                        }
                    } else {
                        $(element).addClass('is-invalid');
                    } 
                    //$(element).addClass('is-invalid');
                },
                unhighlight: function (element, errorClass, validClass) {
                    /* if ($(element).hasClass('select2-hidden-accessible')) {
                        $(element).siblings('.select2').children('span').children('span.select2-selection').removeClass("invalidCs");
                    } */
                    //$(element).removeClass('is-invalid');
                    if ($(element).hasClass('form-check-input')){
                        if ($(element).attr('name') == 'acceptTerms') {
                            $('##accept-terms').removeClass('is-invalid');
                        }
                    } else {
                        $(element).removeClass('is-invalid');
                    }
                    /*   $(element).hasClass('select2-hidden-accessible').removeClass("is-invalid"); */
                    /* if ($(element).hasClass('form-select')) {
                        $(element).removeClass("is-invalid");
                    } */
                    
                },
                submitHandler: function (form) {
                    if( $('##same-address' ).prop('checked') == true ){
                        var firstName = $('##firstName').val();
                        var lastName = $('##lastName').val();
                        var mobile = $('##mobile').val();
                        var zipCode = $('##zipCode').val();
                        var state = $('##state').val();
                        var address = $('##address').val();
                        $('##billingFirstName').val(firstName);
                        $('##billingLastName').val(lastName);
                        console.log($('##billingFirstName').val(firstName));
                        $('##billingMobile').val(mobile);
                        $('##billingZipCode').val(zipCode);
                        $('##billingState').val(state);
                        $('##billingAddress').val(address);
                    }
                    event.preventDefault();
                    submitProductData();
                    
                }, 
            });

            // $('##couponAppliedInput').tagsinput();

            $('.addCoupon').on('click', function () {
                var coupon = $(this).data('coupon');
                var cId = $(this).data('cid');
                console.log(cId);
                $('##couponAppliedInput').val(coupon);
                $('.couponDetails').removeClass('text-decoration-line-through');
                $('.addCoupon').removeClass('disabled');
                $('##couponDetails-'+cId).addClass('text-decoration-line-through');
                $('##addCoupon-'+cId).addClass('disabled');
                $('##removeCoupon').removeClass('d-none');
                $('##couponAppliedBtn').click();
            });
            
            $('##couponAppliedBtn').on('click', function() {
                couponCode = $('##couponAppliedInput').val();
                //let id = $('.couponDetails').attr('data-id');
                //couponCode = $("##couponAppliedInput").tagsinput('items');
                // console.log('couponCode', couponCode);
                ajaxAddCouponShipping(couponCode, shippingValue); 
                /* if(couponCode != ''){
                    ajaxAddCouponShipping(couponCode, shippingValue); 
                    $('##alertDiv').html('<div class="mt-2 alert alert-success alert-dismissible show fade"><i class="bi bi-check-circle"></i>Coupon Succefully applied!!<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>');
                    $('##removeCoupon').removeClass('d-none');
                } else{
                    $('##alertDiv').html('<div class="mt-2 alert alert-danger alert-dismissible show fade"><i class="bi bi-exclamation-circle"></i>Please add coupon..<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>');
                } */
            });
            $('##removeCoupon').on('click', function (){
                // $('##couponAppliedInput').val('');
                // $('.couponDetails').removeClass('text-decoration-line-through');
                // $('.addCoupon').removeClass('disabled');
                $.ajax({
                    type: "POST",
                    url: "../ajaxOrder.cfm?formAction=removeCoupon",
                    success: function(result) {
                        if (result.success) {
                            successToast("You have successfully removed coupon!");
                            $('##couponAppliedInput').val('');
                            $('.couponDetails').removeClass('text-decoration-line-through');
                            $('.addCoupon').removeClass('disabled');
                            var discount = $('##totalDiscount').text(result.discountAmt);
                            var priceTotal = $('##grandTotal').html(result.priceTotal);
                            finalAmount = parseFloat(result.priceTotal);
                            $('##removeCoupon').addClass('d-none');
                        }
                    }
                });
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
                    if (result.success) {
                        successToast("Your order is successfully completed!");
                        $('.chekOutHeading').text('Your Cart Is Empty');
                        $("##addOrderForm").addClass('d-none');
                        setTimeout(() => {
                            location.href = 'index.cfm?pg=dashboard';
                        }, 500);
                    }
                }
            });
        }
        function ajaxAddCouponShipping(couponCode, shippingValue) {
            $.ajax({
                type: "POST",
                url: "../ajaxOrder.cfm?formAction=applyCoupon", 
                data: {"couponCode":couponCode, "shippingValue":shippingValue},
                async: false,
                success: function(result) {
                    if (result.success) {
                        if(couponCode != ''){
                            if (result.couponChecked.success == true) {
                                $('##alertDiv').html('<div class="mt-2 alert alert-success alert-dismissible show fade"><i class="bi bi-check-circle"></i>'+result.message+'<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>');
                                $('##removeCoupon').removeClass('d-none');
                            } else{
                                $('##alertDiv').html('<div class="mt-2 alert alert-danger alert-dismissible show fade"><i class="bi bi-exclamation-circle"></i>'+result.message+'<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>');
                            }
                        } else{
                            $('##alertDiv').html('<div class="mt-2 alert alert-danger alert-dismissible show fade"><i class="bi bi-exclamation-circle"></i>Please add coupon..<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>');
                        }
                        var discount = $('##totalDiscount').text(result.discountAmt);
                        var priceTotal = $('##grandTotal').html(result.priceTotal);
                        finalAmount = parseFloat(result.priceTotal);
                    } 
                }
            });
        }
    </script>
</cfoutput>