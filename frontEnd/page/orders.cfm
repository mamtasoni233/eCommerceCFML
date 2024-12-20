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
<cfparam name="maxRows" default="9">
<cfset startRow = ( pageNum-1 ) * maxRows>
<cfquery name="getOrderDataRows">
    SELECT
        (
            SELECT
                SUM(oisub.totalQuantity)
            FROM order_item oisub
            WHERE oisub.FkOrderId = O.PkOrderId
        ) AS 'totalQuantity',
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
    WHERE O.FkCustomerId = <cfqueryparam value = "#session.customer.isLoggedIn#" cfsqltype = "cf_sql_integer">
    AND O.isDeleted = <cfqueryparam value="0" cfsqltype = "cf_sql_bit">
    <cfif structKeyExists(form, "search") AND len(form.search) GT 0>
        AND ( C.firstName LIKE <cfqueryparam value="%#trim(search)#%"> 
                OR C.lastName LIKE <cfqueryparam value="%#trim(search)#%"> 
                OR CONCAT_WS(" ", OD.firstName, OD.lastName) LIKE <cfqueryparam value="%#trim(search)#%">
            )
    </cfif>
    <cfif structKeyExists(form, "order") AND len(form.order) GT 0>
        ORDER BY #form.order#
    </cfif>
</cfquery>
<cfset totalPages = ceiling( getOrderDataRows.recordCount/maxRows )>
<cfquery name="getOrderData">
    SELECT
        (
            SELECT
                SUM(oisub.totalQuantity)
            FROM order_item oisub
            WHERE oisub.FkOrderId = O.PkOrderId
        ) AS 'totalQuantity',
        CASE
            WHEN O.shipping = 'free' THEN 00.00
            WHEN O.shipping = 'nextDay' THEN 50.00
            WHEN O.shipping = 'courier' THEN 100.00
        END AS 'shippingAmount',
        O.PkOrderId, O.firstName, O.lastName, O.FkCustomerId, O.shipping, O.status, O.finalAmount, O.discountValue, O.createdBy, O.updatedBy, O.createdDate, O.updatedDate, C.PkCustomerId, CONCAT_WS(" ", O.firstName, O.lastName) AS customerName
    FROM
        orders O
    LEFT JOIN customer C ON
        O.createdBy = C.PkCustomerId
    WHERE  O.FkCustomerId = <cfqueryparam value = "#session.customer.isLoggedIn#" cfsqltype = "cf_sql_integer">
    AND O.isDeleted = <cfqueryparam value="0" cfsqltype = "cf_sql_bit">
    <cfif structKeyExists(form, "search") AND len(form.search) GT 0>
        AND ( C.firstName LIKE <cfqueryparam value="%#trim(search)#%"> 
                OR C.lastName LIKE <cfqueryparam value="%#trim(search)#%"> 
                OR CONCAT_WS(" ", OD.firstName, OD.lastName) LIKE <cfqueryparam value="%#trim(search)#%">
            )
    </cfif>
    <cfif structKeyExists(form, "order") AND len(form.order) GT 0>
        ORDER BY #form.order#
    </cfif>
    LIMIT #startRow#, #maxRows#
</cfquery>
<cfset totalAmount = (getOrderData.finalAmount + getOrderData.shippingAmount) - getOrderData.discountValue>
<cfoutput>
    <section class="container">
        <!-- Breadcrumbs-->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="index.cfm?pg=dashboard">Home</a></li>
                <li class="breadcrumb-item active" aria-current="page">My Orders</li>
            </ol>
        </nav>           
        <!-- /Breadcrumbs-->
        <!-- Data Tables start -->
        <div class="d-flex justify-content-between mt-5">
            <h1 class="mb-6 mt-4 display-5 fw-bold ">My Orders</h1>
        </div>
        <div class="row">
            <!--- <h1>MY Orders</h1> --->
            <div class="col-9">
                <div class="table-responsive shadow-lg rounded-3">
                    <table class="table table-borderless table-hover align-middle mt-3" id="orderDataTable">
                        <thead class="ps-5">
                            <tr class="text-capitalize fw-bold">
                                <th class="ps-5">Order Id</th>
                                <th class="ps-5">Quantity</th>
                                <th class="ps-5">Status</th>
                                <th class="ps-5">Total</th>
                                <th class="ps-5">Order On</th>
                                <th class="ps-5">View</th>
                            </tr>
                        </thead>
                        <tbody>
                            <cfif getOrderData.recordCount EQ 0>
                                <tr>
                                    <td colspan="6" class="text-center text-muted">No record found</td></tr>
                                </tr>
                            <cfelse>
                                <cfloop query="getOrderData">
                                    <cfset statusId = getOrderData.status>
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
                                        <td class="ps-5">###getOrderData.PkOrderId#</td>
                                        <td class="ps-5">#getOrderData.totalQuantity#</td>
                                        <td class="ps-5">#statusName#</td>
                                        <td class="ps-5">#totalAmount#</td>
                                        <td class="ps-5">#dateTimeFormat(getOrderData.createdDate, 'dd/mm/yyyy hh:nn:ss tt')#</td>
                                        <td class="ps-5">
                                            <a class="btn btn-sm btn-orange rounded-3" data-bs-toggle="tooltip" title="View Details" href="index.cfm?pg=orderInfo&order_id=#getOrderData.PkOrderId#">
                                                <i class="fa-solid fa-eye"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </cfloop>
                            </cfif>
                        </tbody>
                    </table>
                </div>
                <cfif getOrderData.recordCount GT 5>
                    <ul class="pagination pagination-sm justify-content-end mt-5">
                        <li class="page-item <cfif pageNum EQ 1>disabled</cfif>">
                            <a  href="index.cfm?pg=orders&pageNum=#pageNum-1#" data-id="#pageNum#" class="page-link prev" >Previous</a>
                        </li>
                        <!--- <cfloop from="1" to="#totalPages#" index="i"> --->
                        <cfloop from="#max(1, pageNum - 2)#" to="#min(totalPages, pageNum + 2)#" index="i">
                            <li class="page-item <cfif pageNum EQ i>active</cfif>">
                                <a class="page-link mr-2" href="index.cfm?pg=orders&pageNum=#i#">
                                    #i#
                                </a>
                            </li>
                        </cfloop>
                        <li class="page-item <cfif pageNum EQ totalPages>disabled</cfif>">
                            <a href="index.cfm?pg=orders&pageNum=#pageNum+1#" data-id="#pageNum#" class="page-link next">Next</a>
                        </li>
                    </ul> 
                </cfif>
            </div>
            <div class="col-md-3">
                <cfinclude template="../common/sidebar.cfm">
            </div>
        </div>
        <!-- Data Tables end -->
    </section>
</cfoutput>
