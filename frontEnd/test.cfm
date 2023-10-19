<cfloop array="#session.cart.product#" item="item">
    <cfquery name="getProductQty">
        SELECT productQty, PkProductId 
        FROM product 
        WHERE PkProductId = <cfqueryparam value = "#item.FkProductId#" cfsqltype = "cf_sql_integer">
    </cfquery>
    <cfdump  var="#getProductQty#">
    <cfset prodQty = getProductQty.productQty - item.Quantity>
    <cfdump  var="#prodQty#">
</cfloop>