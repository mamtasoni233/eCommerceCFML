<!--- <cfloop array="#session.cart.product#" item="item">
    <cfquery name="getProductQty">
        SELECT productQty, PkProductId 
        FROM product 
        WHERE PkProductId = <cfqueryparam value = "#item.FkProductId#" cfsqltype = "cf_sql_integer">
    </cfquery>
    <cfdump  var="#getProductQty#">
    <cfset prodQty = getProductQty.productQty - item.Quantity>
    <cfdump  var="#prodQty#">
</cfloop> --->
<cfdump  var="#session.cart#">
    <cfset priceTotal = 0>
    <cfloop array="#session.cart.product#" item="item">
        <cfset priceTotal += item.TotalCost>
    </cfloop>
    <cfdump  var="#priceTotal#">
    <cfquery name="checkcoupon">
        SELECT couponCode, couponName, PkCouponId, discountValue, discountType, couponStartDate, couponExpDate, repeatRestriction
        FROM coupons 
        WHERE couponCode = <cfqueryparam value = "15OFFDEP" cfsqltype = "cf_sql_varchar">
    </cfquery>
    <cfif checkcoupon.recordCount GT 0>
        <cfset priceTotal = 0>
        <cfloop array="#session.cart.product#" item="item">
            <cfset priceTotal += item.TotalCost>
        </cfloop>
        <cfdump  var="#priceTotal#">
        <cfset discountAmount = 0>
        <cfif checkcoupon.discountType EQ 1>
            <cfset discountAmount = priceTotal - (priceTotal * checkcoupon.discountValue )/100>
        <cfelse>
            <cfset discountAmount = priceTotal - checkcoupon.discountValue>
        </cfif>
        <cfdump  var="#discountAmount#">
    </cfif>

