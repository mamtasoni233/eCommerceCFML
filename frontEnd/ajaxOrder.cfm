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
        <!--- <cfquery name="getOrdersQry">
            SELECT PkOrderId, FkCustomerId
            FROM orders 
            WHERE FkCustomerId = <cfqueryparam value = "#url.customerId#" cfsqltype = "cf_sql_integer">
        </cfquery>
        <cfif getOrdersQry.recordCount GT 0> --->
            <!--- <cfquery result="UpdateToOrder">
                UPDATE orders SET
                firstName=  <cfqueryparam value = "#form.firstName#" cfsqltype = "cf_sql_varchar">
                , lastName=  <cfqueryparam value = "#form.lastName#" cfsqltype = "cf_sql_varchar">
                , email=  <cfqueryparam value = "#form.email#" cfsqltype = "cf_sql_varchar">
                , mobile=  <cfqueryparam value = "#form.mobile#" cfsqltype = "cf_sql_varchar">
                , address=  <cfqueryparam value = "#form.address#" cfsqltype = "cf_sql_text">
                , state=  <cfqueryparam value = "#form.state#" cfsqltype = "cf_sql_varchar">
                , zipCode=  <cfqueryparam value = "#form.zipCode#" cfsqltype = "cf_sql_integer">
                , billingFirstName=  <cfqueryparam value = "#form.billingFirstName#" cfsqltype = "cf_sql_varchar">
                , billingLastName=  <cfqueryparam value = "#form.billingLastName#" cfsqltype = "cf_sql_varchar">
                , billingMobile=  <cfqueryparam value = "#form.billingMobile#" cfsqltype = "cf_sql_varchar">
                , billingAddress=  <cfqueryparam value = "#form.billingAddress#" cfsqltype = "cf_sql_text">
                , billingState=  <cfqueryparam value = "#form.billingState#" cfsqltype = "cf_sql_varchar">
                , billingZipCode= <cfqueryparam value = "#form.billingZipCode#" cfsqltype = "cf_sql_integer" null="#NOT len(form.billingZipCode)#">
                , shipping=  <cfqueryparam value = "#form.shipping#" cfsqltype = "cf_sql_varchar">
                , paymentMethod=  <cfqueryparam value = "#form.paymentMethod#" cfsqltype = "cf_sql_varchar">
                , UPIID=  <cfqueryparam value = "#form.UPIID#" cfsqltype = "cf_sql_varchar">
                , creditCardName=  <cfqueryparam value = "#form.creditCardName#" cfsqltype = "cf_sql_varchar">
                , creditCardNumber=  <cfqueryparam value = "#form.creditCardNumber#" cfsqltype = "cf_sql_varchar" null="#NOT len(form.creditCardNumber)#">
                , cardExpieryDate=  <cfqueryparam value = "#form.cardExpieryDate#" cfsqltype = "cf_sql_date" null="#NOT len(form.cardExpieryDate)#">
                , cvv=  <cfqueryparam value = "#form.cvv#" cfsqltype = "cf_sql_integer" null="#NOT len(form.cvv)#">
                , updatedBy =  <cfqueryparam value = "#session.customer.isLoggedIn#" cfsqltype = "cf_sql_integer">
                WHERE PkOrderId = <cfqueryparam value = "#getOrdersQry.PkOrderId#" cfsqltype = "cf_sql_integer">
            </cfquery>
        <cfelse> --->
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
                    <!--- <cfdump  var="#getProductQty#"> --->
                    <cfset prodQty = getProductQty.productQty - item.Quantity>
                    <!--- <cfdump  var="#prodQty#"> --->
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
        <!---  </cfif> --->
    </cfif>
    <cfcatch>
        <cfset data['success'] = false>
        <cfset data['error'] = cfcatch>
    </cfcatch>
</cftry>
<cfset output =  serializeJSON(data)/>
<cfoutput>#output#</cfoutput>


