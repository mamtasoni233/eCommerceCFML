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
    SELECT PkOrderId, firstName, lastName, email, mobile, zipCode, state, billingZipCode, billingState, FkCustomerId, shipping, finalAmount, discountValue, paymentMethod, status, CONCAT_WS(" ", firstName, lastName) AS customerName, address, billingAddress, createdDate
    FROM orders O 
    WHERE PkOrderId = <cfqueryparam value = "#url.order_id#" cfsqltype = "cf_sql_integer">
</cfquery>

<cfoutput>
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
                <div class="col-8">
                    <table class="table-responsive table table-bordered table-hover mt-3">
                        <thead>
                            <tr>
                                <th class="text-capitalize fw-bolder fs-3" colspan="2">Order Details</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="">
                                    <div class="text-capitalize fs-5">
                                        <strong>Order ID: </strong> #url.order_id#
                                    </div>
                                    <div class="text-capitalize fs-5">
                                        <strong>Order Placed On: </strong> #dateTimeFormat(getOrderDetails.createdDate, 'dd/mm/yyyy hh:nn:ss tt')#
                                    </div>
                                </td>
                                <td class="">
                                    <div class="text-capitalize fs-5">
                                        <strong>Payment Method: </strong> #getOrderDetails.paymentMethod#
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                </table>
                </div>
            </div>
        <!-- Order Details end -->
    </section>
</cfoutput>
