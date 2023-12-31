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
                , <cfqueryparam value = "#session.cart.finalAmount#" cfsqltype = "cf_sql_float">
                , <cfqueryparam value = "#session.cart.Discount#" cfsqltype = "cf_sql_float">
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
        <cfquery result="addNotification">
            INSERT INTO notifications (
                FkOrderId 
                , subject
                , message
                , createdBy
            ) VALUES (
                <cfqueryparam value = "#PkOrderId#" cfsqltype = "cf_sql_integer">
                , <cfqueryparam value = "New Order Placed #PkOrderId#" cfsqltype = "cf_sql_varchar">
                , <cfqueryparam value = " '#session.customer.firstName# #session.customer.lastName#' has placed a new order which is pending." cfsqltype = "cf_sql_text">
                , <cfqueryparam value = "#session.customer.isLoggedIn#" cfsqltype = "cf_sql_integer">
            )
        </cfquery>
        <cfset PkNotificationId = addNotification.generatedKey>
        <cfset receiverList = "1,7">
        <cfloop list="#receiverList#" index="i">
            <cfquery result="addNotification">
                INSERT INTO send_notification (
                    FkNotificationId 
                    , receiver_id
                    , isRead
                ) VALUES (
                    <cfqueryparam value = "#PkNotificationId#" cfsqltype = "cf_sql_integer">
                    , <cfqueryparam value = "#i#" cfsqltype = "cf_sql_integer">
                    , <cfqueryparam value = "0" cfsqltype = "cf_sql_bit">
                )
            </cfquery>
        </cfloop>
        <cfif getOrderItemQry.recordCount EQ 0>
            <cfloop array="#session.cart.product#" item="item">
                <cfquery result="addOrderItem">
                    INSERT INTO order_item (
                        FkCustomerId
                        , FkOrderId
                        , FkProductId
                        , FkCouponId
                        , totalQuantity
                        , totalCost
                        , createdBy
                    ) VALUES (
                        <cfqueryparam value = "#url.customerId#" cfsqltype = "cf_sql_integer">
                        , <cfqueryparam value = "#PkOrderId#" cfsqltype = "cf_sql_integer">
                        , <cfqueryparam value = "#item.FkProductId#" cfsqltype = "cf_sql_integer">
                        , <cfqueryparam value = "#item.CoupanId#" cfsqltype = "cf_sql_varchar">
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
            <cfset session.cart.Discount = 0>
            <cfset session.cart.finalAmount = 0>
            <cfset session.cart.shipping = 0>
            <cfset session.cart.couponId = 0>
            <cfquery name="deleteCartProduct">
                DELETE FROM cart 
                WHERE FkCustomerId = <cfqueryparam value = "#session.customer.isLoggedIn#" cfsqltype = "cf_sql_integer">
            </cfquery>
        </cfif>
    </cfif>
    <cfif structKeyExists(url, "formAction") AND url.formAction EQ 'applyCoupon'>
        <cfif structKeyExists(form, 'shippingValue')>
            <cfset session.cart.shipping = form.shippingValue>
        </cfif>
        <cfquery name="checkcoupon">
            SELECT couponCode, couponName, PkCouponId, discountValue, discountType, couponStartDate, couponExpDate, repeatRestriction
            FROM coupons 
            WHERE couponCode = <cfqueryparam value = "#form.couponCode#" cfsqltype = "cf_sql_varchar">
            AND couponStartDate <=<cfqueryparam value="#now()#" cfsqltype="cf_sql_date"> AND couponExpDate >=<cfqueryparam value="#now()#" cfsqltype="cf_sql_date">
        </cfquery>
        <cfset data['couponChecked'] = {'success':false}> 
        <cfif checkcoupon.recordCount GT 0>
            <cfset data['couponChecked'] = {'success':true}> 
            <cfif data['couponChecked'].success EQ true>
                <cfset priceTotal = 0>
                <cfset discountAmount = 0>
                <cfset totalDiscount = 0>
                <cfset session.cart.couponId = checkcoupon.PkCouponId>
                <cfset productArrayLen="#arrayLen(session.cart.product)#">
                <cfloop array="#session.cart.product#" item="item">
                    <cfset priceTotal = item.TotalCost>
                    <cfif checkcoupon.discountType EQ 1>
                        <cfset discountAmount = (priceTotal * checkcoupon.discountValue )/100>
                    <cfelse>
                        <cfset discountAmount = checkcoupon.discountValue/ productArrayLen>
                    </cfif>
                    <cfset item.DiscountValue = discountAmount>
                    <cfset item.CoupanId = checkcoupon.PkCouponId>
                    <cfquery result="updateDiscountValueCart">
                        UPDATE cart SET 
                        FkCouponId = <cfqueryparam value = "#item.CoupanId#" cfsqltype = "cf_sql_varchar">
                        , discountValue = <cfqueryparam value = "#item.DiscountValue#" cfsqltype = "cf_sql_float">
                        WHERE FkProductId = <cfqueryparam value = "#item.FkProductId#" cfsqltype = "cf_sql_integer">
                        AND FkCustomerId = <cfqueryparam value = "#session.customer.isLoggedIn#" cfsqltype = "cf_sql_integer">
                    </cfquery>
                    <cfset totalDiscount += item.DiscountValue>
                </cfloop>
                <cfset session.cart.Discount = totalDiscount>
                <cfset data['message'] = 'Coupon Succefully applied!!'>
            </cfif>
        <cfelse>
            <cfif data['couponChecked'].success EQ false>
                <cfset data['message'] = 'Sorry! Coupon code is expired or not found!'>
            </cfif>
        </cfif>
        <!--- <cfset dateCompare = dateCompare(checkcoupon.couponExpDate, dateFormat(now(), 'yyyy-mm-dd'), 'd')>
        <cfdump  var="#dateCompare#"><cfabort> --->
        <!--- <cfif checkcoupon.recordCount GT 0>
            <cfif dateCompare(checkcoupon.couponStartDate, now(), 'd') EQ -1>
                <cfif couponChecked.success EQ false>
                    <cfset data['message'] = 'Sorry! Coupon code is expired!!'>
                </cfif>
            <cfelseif dateCompare(checkcoupon.couponStartDate, now(), 'd') EQ 0>
                <cfset couponChecked = {'success':true}> 
                <cfif couponChecked.success EQ true>
                    <cfset data['message'] = 'Coupon Succefully applied!!'>
                    <cfset priceTotal = 0>
                    <cfset discountAmount = 0>
                    <cfset totalDiscount = 0>
                    <cfset session.cart.couponId = checkcoupon.PkCouponId>
                    <cfset productArrayLen="#arrayLen(session.cart.product)#">
                    <cfloop array="#session.cart.product#" item="item">
                        <cfset priceTotal = item.TotalCost>
                        <cfif checkcoupon.discountType EQ 1>
                            <cfset discountAmount = (priceTotal * checkcoupon.discountValue )/100>
                        <cfelse>
                            <cfset discountAmount = checkcoupon.discountValue/ productArrayLen>
                        </cfif>
                        <cfset item.DiscountValue = discountAmount>
                        <cfset item.CoupanId = checkcoupon.PkCouponId>
                        <cfquery result="updateDiscountValueCart">
                            UPDATE cart SET 
                            FkCouponId = <cfqueryparam value = "#item.CoupanId#" cfsqltype = "cf_sql_varchar">
                            , discountValue = <cfqueryparam value = "#item.DiscountValue#" cfsqltype = "cf_sql_float">
                            WHERE FkProductId = <cfqueryparam value = "#item.FkProductId#" cfsqltype = "cf_sql_integer">
                            AND FkCustomerId = <cfqueryparam value = "#session.customer.isLoggedIn#" cfsqltype = "cf_sql_integer">
                        </cfquery>
                        <cfset totalDiscount += item.DiscountValue>
                    </cfloop>
                    <cfset session.cart.Discount = totalDiscount>
                </cfif>
            <cfelseif dateCompare(checkcoupon.couponStartDate, now(), 'd') EQ 1>
                <cfif couponChecked.success EQ false>
                    <cfset data['message'] = 'Sorry! Coupon is not found!!'>
                </cfif>
            </cfif>
        </cfif> --->
        <cfset data['discountAmt'] = session.cart.Discount>
        <cfset data['shippingAmt'] = session.cart.shipping>
        <cfset data['priceTotal'] = (session.cart.finalAmount + session.cart.shipping )- session.cart.Discount>
    </cfif>
    
    <cfif structKeyExists(url, "formAction") AND url.formAction EQ "getRecord">
        <cfquery name="getOrderDataRows">
            SELECT
                (       
                    SELECT
                        SUM(oisub.totalQuantity)
                    FROM order_item oisub
                    WHERE oisub.FkOrderId = O.PkOrderId
                ) AS 'totalQuantity',
            O.PkOrderId, O.firstName, O.lastName, O.FkCustomerId, O.shipping, O.status, O.finalAmount, O.discountValue, O.createdBy, O.updatedBy, O.createdDate, O.updatedDate, O.isDeleted, C.PkCustomerId, CONCAT_WS(" ", O.firstName, O.lastName) AS customerName, 
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
        <cfquery name="getOrderData">
            SELECT
                (
                    SELECT
                        SUM(oisub.totalQuantity)
                    FROM order_item oisub
                    WHERE oisub.FkOrderId = O.PkOrderId
                ) AS 'totalQuantity',
            O.PkOrderId, O.firstName, O.lastName, O.FkCustomerId, O.shipping, O.status, O.finalAmount, O.discountValue, O.createdBy, O.updatedBy, O.createdDate, O.updatedDate, C.PkCustomerId, CONCAT_WS(" ", O.firstName, O.lastName) AS customerName,
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
            LIMIT #form.start#, #form.length#
        </cfquery>
        <cfset data['data'] = []>
        <cfset data['recordsFiltered'] = getOrderDataRows.recordCount>
        <cfset data['draw'] = form.draw>
        <cfset data['recordsTotal'] = getOrderDataRows.recordCount>
        <cfloop query="getOrderData">
            <cfset dataRecord = {}>

            <cfset dataRecord['PkOrderId'] = getOrderData.PkOrderId>
            <cfset dataRecord['totalQuantity'] = getOrderData.totalQuantity>
            <cfset dataRecord['finalAmount'] = getOrderData.finalAmount>
            <cfset dataRecord['discountValue'] = getOrderData.discountValue>
            <cfset dataRecord['status'] = getOrderData.status>
            <cfset dataRecord['createdBy'] = getOrderData.createdBy>
            <cfset dataRecord['createdDate'] = dateTimeFormat(getOrderData.createdDate, 'dd-mm-yyyy hh:nn:ss tt')>
            <cfset dataRecord['PkCustomerId'] = getOrderData.PkCustomerId>
            <cfset dataRecord['customerName'] = getOrderData.customerName>
            <cfset arrayAppend(data['data'], dataRecord)>
        </cfloop>
    </cfif>

    <cfif structKeyExists(url, "formAction") AND url.formAction EQ 'removeCoupon'>
        <cfset session.cart.couponId = 0>
        <cfloop array="#session.cart.product#" item="item">
            <cfset item.DiscountValue = 0>
            <cfset item.CoupanId = 0>
            <cfquery result="updateDiscountValueCart">
                UPDATE cart SET 
                FkCouponId = <cfqueryparam value = "#item.CoupanId#" cfsqltype = "cf_sql_varchar">
                , discountValue = <cfqueryparam value = "#item.DiscountValue#" cfsqltype = "cf_sql_float">
                WHERE FkProductId = <cfqueryparam value = "#item.FkProductId#" cfsqltype = "cf_sql_integer">
                AND FkCustomerId = <cfqueryparam value = "#session.customer.isLoggedIn#" cfsqltype = "cf_sql_integer">
            </cfquery>
        </cfloop>
        <cfset session.cart.Discount = 0>
        <cfset data['discountAmt'] = session.cart.Discount>
        <cfset data['priceTotal'] = (session.cart.finalAmount + session.cart.shipping )- session.cart.Discount>
    </cfif>
    <cfcatch>
        <cfset data['success'] = false>
        <cfset data['error'] = cfcatch>
    </cfcatch>
</cftry>
<cfset output =  serializeJSON(data)/>
<cfoutput>#output#</cfoutput>


