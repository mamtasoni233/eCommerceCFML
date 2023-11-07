<cfparam name="order_id" default="url.order_id" />
<cfparam name="PkItemId" default="" />
<cfparam name="FkCustomerId" default="" />
<cfparam name="FkProductId" default="" />
<cfparam name="PkOrderId" default="" />
<cfparam name="totalQuantity" default="" />
<cfparam name="totalCost" default="" />
<cfparam name="status" default="" />
<cfparam name="totalQuantity" default="" />
<cfparam name="totalCost" default="" />
<cfparam name="startRow" default="">
<cfparam name="pageNum" default="1">
<cfparam name="maxRows" default="5">
<cfset startRow = ( pageNum-1 ) * maxRows>

<cfquery name="getOrderDetails">
    SELECT 
        PkOrderId, FkCustomerId, firstName, lastName, email, mobile, address, state, zipCode, billingFirstName, billingLastName, billingMobile, billingAddress, billingState, billingZipCode, shipping, finalAmount, discountValue, paymentMethod, UPIID, creditCardName, creditCardNumber, cardExpieryDate, cvv, CONCAT_WS(" ", firstName, lastName) AS customerName, createdDate
    FROM orders O 
    WHERE PkOrderId = <cfqueryparam value = "#url.order_id#" cfsqltype = "cf_sql_integer">
</cfquery>

<cfquery name="getOrderItemData">
    SELECT 
        O.PkItemId, O.FkCustomerId, O.FkOrderId, O.FkProductId, O.totalQuantity, O.totalCost, O.createdBy, O.updatedBy, O.dateCreated, O.dateUpdated, C.PkCustomerId, CONCAT_WS(" ", C.firstName, C.lastName) AS customerName, userUpdate.PkUserId, CONCAT_WS(" ", userUpdate.firstName, userUpdate.lastName) AS userNameUpdate, PI.image, P.productName, P.productPrice
    FROM order_item O
    LEFT JOIN customer C ON O.createdBy = C.PkCustomerId
    LEFT JOIN product P ON O.FkProductId = P.PkProductId 
    LEFT JOIN product_image PI ON O.FkProductId = PI.FkProductId AND PI.isDefault = 1
    LEFT JOIN users userUpdate ON O.updatedBy = userUpdate.PkUserId
    WHERE  O.FkOrderId = <cfqueryparam value="#url.order_id#" cfsqltype = "cf_sql_integer">
</cfquery>

<cfquery name="getOrderPriceData">
    SELECT
        CASE
            WHEN O.shipping = 'free' THEN 00.00
            WHEN O.shipping = 'nextDay' THEN 50.00
            WHEN O.shipping = 'courier' THEN 100.00
        END AS 'shippingAmount',
        O.PkOrderId, O.firstName, O.lastName, O.FkCustomerId, O.shipping, O.status, O.finalAmount, O.discountValue, O.createdBy, O.updatedBy, O.createdDate, O.updatedDate, O.isDeleted, C.PkCustomerId, CONCAT_WS(" ", O.firstName, O.lastName) AS customerName
    FROM
        orders O
    LEFT JOIN customer C ON
        O.createdBy = C.PkCustomerId
    WHERE O.PkOrderId = <cfqueryparam value="#url.order_id#" cfsqltype = "cf_sql_integer">
    AND O.isDeleted = <cfqueryparam value="0" cfsqltype = "cf_sql_bit">
</cfquery>

<cfset totalPrice = (getOrderPriceData.finalAmount + getOrderPriceData.shippingAmount) - getOrderPriceData.discountValue>

<cfquery name="getShippingStatusData">
    SELECT 
        SH.PkHistoryId, SH.FkOrderId, SH.status, SH.comment, SH.createdBy, SH.dateCreated, O.PkOrderId, O.isDeleted, U.PkUserId, CONCAT_WS(" ", U.firstName, U.lastName) AS userName, C.PkCustomerId, CONCAT_WS(" ", C.firstName, C.lastName) AS customerName, O.createdDate
    FROM status_history SH
    LEFT JOIN orders O ON SH.FkOrderId = O.PkOrderId 
    LEFT JOIN users U ON SH.createdBy = U.PkUserId
    LEFT JOIN customer C ON O.createdBy = C.PkCustomerId
    WHERE SH.FkOrderId = <cfqueryparam value="#url.order_id#" cfsqltype = "cf_sql_integer">
    AND O.isDeleted = <cfqueryparam value="0" cfsqltype = "cf_sql_bit">
</cfquery>

<cfoutput>
    
    <cfset imagePath = "http://127.0.0.1:50847/assets/productImage/">
    <section class="container">
        <!-- Breadcrumbs-->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="index.cfm?pg=dashboard">Home</a></li>
                <li class="breadcrumb-item active"><a href="index.cfm?pg=orders">My Orders</a></li>
                <li class="breadcrumb-item active" aria-current="page">Order Details</li>
            </ol>
        </nav>           
        <!-- /Breadcrumbs-->
        <!-- Order Details -->
        <div class="row">
            <h1>Order Details</h1>
            <div class="col-md-9">
                <div class="table-responsive shadow-lg rounded-3">
                    <table class="table table-borderless table-hover align-middle mt-3" id="orderInfoDataTable">
                        <thead>
                            <tr>
                                <th class="text-capitalize fw-bold fs-5 ps-4" colspan="2">Order Details</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="ps-4 text-capitalize fs-5">
                                    <div>
                                        <strong>Order ID: </strong> ###url.order_id#
                                    </div>
                                    <div>
                                        <strong>Order Placed On: </strong> #dateTimeFormat(getOrderDetails.createdDate, 'dd/mm/yyyy hh:nn:ss tt')#
                                    </div>
                                </td>
                                <td class="ps-4 text-capitalize fs-5">
                                    <strong>Payment Method: </strong> #getOrderDetails.paymentMethod#
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="row mt-3">
                    <div class="col-lg-6">
                        <div class="card border shadow-lg rounded-3">
                            <div class=" ps-4 p-2 fs-5 ">
                                <strong class="fw-bold">Payment Address</strong>
                            </div>
                            <div class=" ps-4 p-2 wordWrapClass fs-5">
                                <div>#getOrderDetails.firstName# #getOrderDetails.lastName#</div>
                                <div>#getOrderDetails.mobile#</div>
                                <div>#getOrderDetails.email#</div>
                                <div>#getOrderDetails.address#</div>
                                <div>#getOrderDetails.zipCode#</div>
                                <div>#getOrderDetails.state#</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="card border shadow-lg rounded-3">
                            <div class=" ps-4 p-2 fs-5">
                                <strong class="fw-bold">Shipping Address</strong>
                            </div>
                            <div class=" ps-4 p-2 wordWrapClass fs-5">
                                <div>#getOrderDetails.billingFirstName# #getOrderDetails.billingLastName#</div>
                                <div>#getOrderDetails.billingMobile#</div>
                                <div>#getOrderDetails.email#</div>
                                <div>#getOrderDetails.billingAddress#</div>
                                <div>#getOrderDetails.billingZipCode#</div>
                                <div>#getOrderDetails.billingState#</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="table-responsive card border shadow-lg rounded-3 mt-3">
                    <table class="table table-borderless table-hover align-middle mt-3">
                        <thead class="fs-5 fw-bolder">
                            <tr>
                                <th class="w-25 ps-4">Product Name</th>
                                <th class="w-25 ps-4">Image</th>
                                <th class="ps-4">Quantity</th>
                                <th class="ps-4">Price</th>
                                <th class="ps-4">Total</th>
                            </tr>
                            </thead>
                        <tbody >
                            <cfloop query="#getOrderItemData#">
                                <tr>
                                    <td class="ps-4">
                                        #getOrderItemData.productName#
                                    </td>
                                    <td class="ps-4">
                                        <img data-fancybox="group" class="image" src="#imagePath##getOrderItemData.image#" width="50" height="50">
                                    </td>
                                    <td class="ps-4">#getOrderItemData.totalQuantity#</td>
                                    <td class="ps-4"><i class="bi bi-currency-rupee fs-5"></i> #getOrderItemData.productPrice#</td>
                                    <td class="ps-4"><i class="bi bi-currency-rupee fs-5"></i> #getOrderItemData.totalCost#</td>
                                </tr>
                            </cfloop>
                        </tbody>
                    
                        <tfoot class="text-end">
                            <tr>
                                <td colspan="3"></td>
                                <td class="m-0 p-0 fs-5 fw-bolder pe-2">Shipping Charge :</td>
                                <td class="m-0 p-0 text-center"><i class="bi bi-currency-rupee fs-5"></i> #getOrderPriceData.shippingAmount#</td>
                            </tr>
                            <tr>
                                <td colspan="3"></td>
                                <td class="m-0 p-0 fs-5 fw-bolder pe-2">Sub Total :</td>
                                <td class="m-0 p-0 text-center"><i class="bi bi-currency-rupee fs-5"></i> #getOrderPriceData.finalAmount#</td>
                            </tr>
                            <tr>
                                <td colspan="3"></td>
                                <td class="m-0 p-0 fs-5 fw-bolder pe-2">Discount :</td>
                                <td class="m-0 p-0 text-center"><i class="bi bi-currency-rupee fs-5"></i> #getOrderPriceData.discountValue#</td>
                            </tr>
                            <tr>
                                <td colspan="3"></td>
                                <td class="m-0 p-0 fs-5 fw-bolder pe-2">Total :</td>
                                <td class="m-0 p-0 text-center"><i class="bi bi-currency-rupee fs-5"></i> #totalPrice#</td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
                <h1 class="mt-3">Order History</h1>
                <div class="table-responsive shadow-lg rounded-3">
                    <table class="table table-borderless table-hover align-middle mt-3">
                        <thead>
                            <tr>
                                <th class="w-25 ps-4">Date Added</th>
                                <th class="w-25 ps-4">Status</th>
                                <th class="w-50 ps-4">Comment</th>
                            </tr>
                        </thead>
                        <tbody>
                            <cfloop query="getShippingStatusData">
                                <cfset statusId = getShippingStatusData.status>
                                <cfif statusId EQ 0>
                                    <cfset statusName = "Pending">
                                <cfelseif statusId EQ 1>
                                    <cfset statusName = "In Process">
                                <cfelseif statusId EQ 2>
                                    <cfset statusName = "Dispatched>">
                                <cfelseif statusId EQ 3>
                                    <cfset statusName = "Shipped">
                                <cfelseif statusId EQ 4>
                                    <cfset statusName = "Cancelled">
                                <cfelseif statusId EQ 5>
                                    <cfset statusName = "Delivered">
                                <cfelse>
                                    <cfset statusName = Pending>">
                                </cfif>
                            <tr>
                                <td class="ps-4">#DateFormat(getShippingStatusData.createdDate, "dd/mm/yyyy")#</td>
                                <td class="ps-4">#statusName#</td>
                                <td class="ps-4">#getShippingStatusData.comment#</td>
                            </tr>
                            </cfloop>
                        <tbody>
                    </table>
                </div>
                <div class="row mt-4 mb-3">
                    <div class="col-lg-7">
                        <a href="index.cfm?pg=orders" data-bs-toggle="tooltip" title="Back" class="text-decoration-none text-white rounded-3 btn btn-sm btn-dark">
                            Back
                        </a>
                    </div>
                </div>

            </div>
            <div class="col-md-3">
                <cfinclude template="../common/sidebar.cfm">
            </div>
        </div>
        <!-- Order Details end -->
    </section>
</cfoutput>
