<cfsetting enablecfoutputonly="true" showdebugoutput="false" />
<cfheader statuscode="200" statustext="OK" />
<cfcontent reset="true" type="application/json" />

<cfparam name="PkProductId" default="" />
<cfparam name="FkCategoryId" default="" />
<cfparam name="PkCategoryId" default="" />
<cfparam name="PkTagId" default="" />
<cfparam name="isDeleted" default="0" />
<cfparam name="startRow" default="">
<cfparam name="pageNum" default="1">
<cfparam name="maxRows" default="9">
<cfparam name="sorting" default="P.productName ASC">
<cfset startRow = ( pageNum-1 ) * maxRows>

<cffunction name="convertToObject" access="public" returntype="any" output="false"
        hint="Converts an entire query or the given record to a struct. This might return a structure (single record) or an array of structures.">
        <cfargument name="Query" type="query" required="true" />
        <cfargument name="Row" type="numeric" required="false" default="0" />
        <cfargument name="lowerCase" type="boolean" required="false" default="true" />
    
        <cfscript>
            var loc = StructNew();
			if (arguments.Query.RecordCount EQ 0){
				if (arguments.Row GT 0){
                    return(StructNew());
				}else{
                    return(arraynew(1));
				}
			}
			if (arguments.Row){
				loc.FromIndex = arguments.Row;
				loc.ToIndex = arguments.Row;
			} else {
				loc.FromIndex = 1;
				loc.ToIndex = arguments.Query.RecordCount;
			}
			if(arguments.lowerCase EQ true ){
				loc.Columns = ListToArray( LCASE(arguments.Query.ColumnList));
			}else{
				loc.Columns = ListToArray( arguments.Query.ColumnList);
			}
			loc.ColumnCount = ArrayLen( loc.Columns );
			loc.DataArray = ArrayNew( 1 );
			for (loc.RowIndex = loc.FromIndex ; loc.RowIndex LTE loc.ToIndex ; loc.RowIndex = (loc.RowIndex + 1)){
				ArrayAppend( loc.DataArray, StructNew() );
				loc.DataArrayIndex = ArrayLen( loc.DataArray );
				for (loc.ColumnIndex = 1 ; loc.ColumnIndex LTE loc.ColumnCount ; loc.ColumnIndex = (loc.ColumnIndex + 1)){
					loc.ColumnName = loc.Columns[ loc.ColumnIndex ];
					loc.DataArray[ loc.DataArrayIndex ][ loc.ColumnName ] = arguments.Query[ loc.ColumnName ][ loc.RowIndex ];
				}
			}
			if (arguments.Row){
				return( loc.DataArray[ 1 ] );
			} else {
				return( loc.DataArray );
			}
			return loc.DataArray;
    </cfscript>
</cffunction>
<cfset data = {}>
<cfset data['success'] = true>
<cftry>
    <cfif structKeyExists(url, "customerId") AND url.customerId GT 0>
        <cfif NOT StructKeyExists(session, "customer")>
            <cflocation url="login.cfm" addtoken="false">
        </cfif>
        <cfquery result="addToOrder">
            INSERT INTO orders (
                FkCustomerId
                , firstName
                , lastName
                , email
                , mobile
                , address
                , state
                , zipCode
                , billingFirstName
                , billingLastName
                , billingMobile 
                , billingAddress
                , billingState
                , billingZipCode
                , shipping
                , finalAmount
                , discountValue
                , paymentMethod
                , UPIID
                , creditCardName
                , creditCardNumber
                , cardExpieryDate
                , cvv
                , createdBy
            ) VALUES (
                <cfqueryparam value = "#url.customerId#" cfsqltype = "cf_sql_integer">
                , <cfqueryparam value = "#form.firstName#" cfsqltype = "cf_sql_varchar">
                , <cfqueryparam value = "#form.lastName#" cfsqltype = "cf_sql_varchar">
                , <cfqueryparam value = "#form.email#" cfsqltype = "cf_sql_varchar">
                , <cfqueryparam value = "#form.mobile#" cfsqltype = "cf_sql_varchar">
                , <cfqueryparam value = "#form.address#" cfsqltype = "cf_sql_text">
                , <cfqueryparam value = "#form.state#" cfsqltype = "cf_sql_varchar">
                , <cfqueryparam value = "#form.zipCode#" cfsqltype = "cf_sql_integer">
                , <cfqueryparam value = "#form.billingFirstName#" cfsqltype = "cf_sql_varchar">
                , <cfqueryparam value = "#form.billingLastName#" cfsqltype = "cf_sql_varchar">
                , <cfqueryparam value = "#form.billingMobile#" cfsqltype = "cf_sql_varchar">
                , <cfqueryparam value = "#form.billingAddress#" cfsqltype = "cf_sql_text">
                , <cfqueryparam value = "#form.billingState#" cfsqltype = "cf_sql_varchar">
                , <cfqueryparam value = "#form.billingZipCode#" cfsqltype = "cf_sql_integer" null="#NOT len(form.billingZipCode)#">
                , <cfqueryparam value = "#form.shipping#" cfsqltype = "cf_sql_varchar">
                , <cfqueryparam value = "#form.finalAmount#" cfsqltype = "cf_sql_float">
                , <cfqueryparam value = "#form.discountValue#" cfsqltype = "cf_sql_float">
                , <cfqueryparam value = "#form.paymentMethod#" cfsqltype = "cf_sql_varchar">
                , <cfqueryparam value = "#form.UPIID#" cfsqltype = "cf_sql_varchar">
                , <cfqueryparam value = "#form.creditCardName#" cfsqltype = "cf_sql_varchar">
                , <cfqueryparam value = "#form.creditCardNumber#" cfsqltype = "cf_sql_varchar" null="#NOT len(form.creditCardNumber)#">
                , <cfqueryparam value = "#form.cardExpieryDate#" cfsqltype = "cf_sql_date" null="#NOT len(form.cardExpieryDate)#">
                , <cfqueryparam value = "#form.cvv#" cfsqltype = "cf_sql_integer" null="#NOT len(form.cvv)#">
                , <cfqueryparam value = "#session.customer.isLoggedIn#" cfsqltype = "cf_sql_integer">
            )
        </cfquery>
        <cfset PkOrderId = addToOrder.generatedKey>
        <cfquery name="getOrderItemQry">
            SELECT PkItemId , FkOrderId 
            FROM order_item 
            WHERE FkOrderId  = <cfqueryparam value = "#PkOrderId#" cfsqltype = "cf_sql_integer">
        </cfquery>
        <cfquery result="addStatus">
            INSERT INTO status_history (
                FkOrderId 
                , status
                , createdBy
            ) VALUES (
                <cfqueryparam value = "#PkOrderId#" cfsqltype = "cf_sql_integer">
                , <cfqueryparam value = "0" cfsqltype = "cf_sql_integer">
                , <cfqueryparam value = "#session.customer.isLoggedIn#" cfsqltype = "cf_sql_integer">
            )
        </cfquery>
        <cfif getOrderItemQry.recordCount EQ 0>
            <cfloop array="#session.cart.product#" item="item">
                <cfquery result="addOrderItem">
                    INSERT INTO order_item (
                        FkCustomerId
                        , FkOrderId
                        , FkProductId
                        , totalQuantity
                        , totalCost
                        , createdBy
                    ) VALUES (
                        <cfqueryparam value = "#url.customerId#" cfsqltype = "cf_sql_integer">
                        , <cfqueryparam value = "#PkOrderId#" cfsqltype = "cf_sql_integer">
                        , <cfqueryparam value = "#item.FkProductId#" cfsqltype = "cf_sql_integer">
                        , <cfqueryparam value = "#item.Quantity#" cfsqltype = "cf_sql_integer">
                        , <cfqueryparam value = "#item.TotalCost#" cfsqltype = "cf_sql_float">
                        , <cfqueryparam value = "#session.customer.isLoggedIn#" cfsqltype = "cf_sql_integer">
                    )
                </cfquery>
            </cfloop>
            <cfloop array="#session.cart.product#" item="item">
                <cfquery name="getProductQty">
                    SELECT productQty, PkProductId 
                    FROM product 
                    WHERE PkProductId = <cfqueryparam value = "#item.FkProductId#" cfsqltype = "cf_sql_integer">
                </cfquery>
                <cfset prodQty = getProductQty.productQty - item.Quantity>
                <cfquery result="qryUpdateProductQty">
                    UPDATE product SET productQty = <cfqueryparam value = "#prodQty#" cfsqltype = "cf_sql_integer">
                    WHERE PkProductId = <cfqueryparam value = "#getProductQty.PkProductId#" cfsqltype = "cf_sql_integer">
                </cfquery>
            </cfloop>
            <cfset session.cart['PRODUCT'] = []>
            <cfquery name="deleteCartProduct">
                DELETE FROM cart 
                WHERE FkCustomerId = <cfqueryparam value = "#session.customer.isLoggedIn#" cfsqltype = "cf_sql_integer">
            </cfquery>
        </cfif>
    </cfif>
    <cfif structKeyExists(url, "formAction") AND url.formAction EQ 'applyCoupon'>
        <cfquery name="checkcoupon">
            SELECT couponCode, couponName, PkCouponId, discountValue, discountType, couponStartDate, couponExpDate, repeatRestriction
            FROM coupons 
            WHERE couponCode = <cfqueryparam value = "#form.code#" cfsqltype = "cf_sql_varchar">
        </cfquery>
        <cfif checkcoupon.recordCount GT 0>
            <cfset priceTotal = 0>
            <cfloop array="#session.cart.product#" item="item">
                <cfset priceTotal += item.TotalCost>
            </cfloop>
            <cfset discountAmount = 0>
            <cfif checkcoupon.discountType EQ 1>
                <cfset discountAmount = (priceTotal * checkcoupon.discountValue )/100>
            <cfelse>
                <cfset discountAmount = checkcoupon.discountValue>
            </cfif>

        </cfif>
        <!--- <cfset checkProdArray = arrayMap(session.cart.product, function(item) {
            return item.DiscountValue
        })>
        <cfset checkProdArray = discountAmount> --->
        <cfset checkProdArray = arrayFilter(session.cart.product, function(item) {
            return item.DiscountValue
        })>
        <!---  <cfset checkProdArray = arrayInsertAt(session.cart.product, 2, 4) --->
        
        <!---  <cfdump  var="#checkProdArray#"> --->
        <cfif arrayLen(checkProdArray)>
            <cfset checkProdArray['DiscountValue'] = discountAmount>
        </cfif>
        <!--- <cfset data['discountAmt'] = discountAmount> --->
    </cfif>
    <cfcatch>
        <cfset data['success'] = false>
        <cfset data['error'] = cfcatch>
    </cfcatch>
</cftry>
<cfset output =  serializeJSON(data)/>
<cfoutput>#output#</cfoutput>


