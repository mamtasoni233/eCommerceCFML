<cfsetting enablecfoutputonly="true" showdebugoutput="false" />
<cfheader statuscode="200" statustext="OK" />
<cfcontent reset="true" type="application/json" />

<cfparam name="FkProductId" default="" />
<cfparam name="PkCartId" default="" />
<cfparam name="productPrice" default="" />
<cfparam name="productQty" default="" />
<cfparam name="FkCustomerId" default="" />
<cfparam name="isDeleted" default="0" />
<cfparam name="startRow" default="">
<cfparam name="pageNum" default="1">
<cfparam name="maxRows" default="9">
<cfparam name="formAction" default="">

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
<cfset imagePath = "http://127.0.0.1:50847/assets/productImage/">
<cftry>
    <cfif structKeyExists(url, "ProductId") AND url.ProductId GT 0>
        <!--- <cfdump  var="#form#"><cfabort> --->
        <cfif NOT StructKeyExists(session, "customer")>
            <cflocation url="login.cfm" addtoken="false">
        </cfif>
        <cfquery name="getCartProductQry">
            SELECT C.PkCartId, C.FkCustomerId, C.FkProductId, C.quantity, C.price, C.discountValue
            FROM cart C
            WHERE C.FkProductId = <cfqueryparam value = "#url.ProductId#" cfsqltype = "cf_sql_integer">
            AND C.FkCustomerId = <cfqueryparam value = "#form.customerId#" cfsqltype = "cf_sql_integer">
        </cfquery>
        <!--- <cfset discountValue = getCartProductQry.discountValue> --->
        <cfif getCartProductQry.FkProductId EQ url.ProductId>
            <cfset totalProductQty = getCartProductQry.quantity + form.productQty>
            <cfset totalPrice = getCartProductQry.price * totalProductQty>
            <cfset session.cart.finalAmount += totalPrice>
            <cfquery result="updateCartProductData">
                UPDATE cart SET
                quantity =  <cfqueryparam value = "#totalProductQty#" cfsqltype = "cf_sql_integer">
                , price =  <cfqueryparam value = "#totalPrice#" cfsqltype = "cf_sql_float">
                , updatedBy =  <cfqueryparam value = "#form.customerId#" cfsqltype = "cf_sql_integer">
                , dateUpdated =  <cfqueryparam value = "#now()#" cfsqltype = "cf_sql_datetime">
                WHERE PkCartId = <cfqueryparam value = "#getCartProductQry.PkCartId#" cfsqltype = "cf_sql_integer">
            </cfquery>
        <cfelse>
            <cfquery result="addToCartData">
                <cfset totalProductQty = form.productQty>
                <cfset totalPrice = form.productPrice * form.productQty>
                <cfset session.cart.finalAmount += totalPrice>
                INSERT INTO cart (
                    FkProductId
                    , FkCustomerId
                    , quantity
                    , price
                    , isDeleted
                    , createdBy
                    , dateCreated
                ) VALUES (
                    <cfqueryparam value = "#url.ProductId#" cfsqltype = "cf_sql_integer">
                    , <cfqueryparam value = "#form.customerId#" cfsqltype = "cf_sql_integer">
                    , <cfqueryparam value = "#totalProductQty#" cfsqltype = "cf_sql_integer">
                    , <cfqueryparam value = "#totalPrice#" cfsqltype = "cf_sql_float">
                    , <cfqueryparam value = "#isDeleted#" cfsqltype = "cf_sql_bit">
                    , <cfqueryparam value = "#session.customer.isLoggedIn#" cfsqltype = "cf_sql_integer">
                    , <cfqueryparam value = "#now()#" cfsqltype = "cf_sql_datetime">
                )
            </cfquery>
        </cfif>
        <cfset checkProdArray = arrayFilter(session.cart.product, function(idx) {
            return idx['FkProductId'] EQ url.ProductId
        })>
        <!--- <cfset checkProduct = arrayFind(session.cart.product, function(item) {
            return item['FkProductId'] EQ url.ProductId
        })>
        <cfdump  var="#checkProduct#"> --->
        <!--- <cfdump  var="#checkProdArray#">
        <cfdump  var="#checkProdArray[1]['Quantity']#"> --->
        <cfif arrayLen(checkProdArray) EQ 1>
            <cfset checkProdArray[1]['Quantity'] = totalProductQty>
            <cfset checkProdArray[1]['TotalCost'] = totalPrice>
        <cfelseif arrayLen(checkProdArray) EQ 0>
            <cfset dataRecord = {}>
            <cfset dataRecord['FkProductId'] = url.ProductId>
            <cfset dataRecord['TotalCost'] = totalPrice>
            <cfset dataRecord['Quantity'] = totalProductQty>
            <!--- <cfset dataRecord['DiscountValue'] = discountValue> --->
            <cfquery name="qryGetImage">
                SELECT PI.image, P.productName, P.PkProductId
                FROM product_image PI 
                LEFT JOIN product P ON PI.FkProductId = P.PkProductId AND P.isDeleted = 0
                WHERE PI.FkProductId = <cfqueryparam value="#url.ProductId#" cfsqltype="cf_sql_integer">
                AND PI.isDefault = 1
            </cfquery>
            <cfset dataRecord['Name'] = qryGetImage.productName>
            <cfset dataRecord['Image'] = qryGetImage.image>
            <cfset arrayAppend(session.cart['PRODUCT'], dataRecord)>
        </cfif>
        <!--- <cfset checkFkProductId = arrayMap(session.cart.product, function(item) {
            return item.FkProductId
        })> --->
        <cfset data['totalPrice'] = totalPrice>
        <cfset data['totalQty'] = totalProductQty>
    </cfif>
    <cfif structKeyExists(url, "geDetail") AND url.geDetail EQ "getCartData">
        <cfquery name="getCartProductQry">
            SELECT C.PkCartId, C.FkCustomerId, C.FkProductId, C.quantity, C.price, P.PkProductId, P.productName, P.productPrice, P.productQty, P.productDescription
            FROM cart C
            LEFT JOIN product P ON C.FkProductId = P.PkProductId
            WHERE C.FkCustomerId = <cfqueryparam value = "#session.customer.isLoggedIn#" cfsqltype = "cf_sql_integer">
        </cfquery>
        <cfquery name="getCartCount">
            SELECT SUM(quantity) AS 'totalCartValue' FROM cart WHERE FkCustomerId = <cfqueryparam value = "#getCartProductQry.FkCustomerId#" cfsqltype = "cf_sql_integer"> 
        </cfquery>
        <cfset imagePath = "http://127.0.0.1:50847/assets/productImage/">
        <cfsavecontent variable="data['html']">
            <cfoutput>
                <div class="offcanvas-header d-flex align-items-center">
                    <h5 class="offcanvas-title" id="offcanvasCartLabel">Your Cart</h5>
                    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                </div>
                <cfif getCartProductQry.recordCount GT 0>
                    <div class="offcanvas-body">
                        <div class="d-flex flex-column justify-content-between w-100 h-100">
                            <div>
                                <div class="mt-4 mb-5">
                                    <p class="d-flex justify-content-end mb-2 fs-6">
                                        <!--- <i class="ri-truck-line align-bottom me-2"></i><span class="fw-bolder">$22</span> away
                                        from free delivery --->
                                        <button class="btn btn-sm btn-outline-none bg-light border-0" id="removeAllCartValue">
                                            Remove Cart
                                            <i class="fa fa-trash text-danger"></i>
                                        </button>
                                    </p>
                                    <div class="progress f-h-1">
                                        <div
                                            class="progress-bar bg-success"
                                            role="progressbar" style="width: 25%"
                                            aria-valuenow="25"
                                            aria-valuemin="0"
                                            aria-valuemax="100"
                                        ></div>
                                    </div>
                                </div>
                                <!-- Cart Product-->
                                <cfset productSubTotal = 0>
                                <cfloop query="getCartProductQry">
                                    <!---   <cfset priceTotal = getCartProductQry.quantity * getCartProductQry.price> --->
                                    <cfset priceTotal = getCartProductQry.price>
                                    <cfset productSubTotal +=  priceTotal >
                                    <cfquery name="getProductImage">
                                        SELECT image, isDefault
                                        FROM product_image 
                                        WHERE FkProductId = <cfqueryparam value="#getCartProductQry.FkProductId#" cfsqltype = "cf_sql_integer">
                                    </cfquery>
                                    <div class="row mx-0 pb-4 mb-4 border-bottom">
                                        <div class="col-3">
                                            <cfif getProductImage.isDefault EQ 1>
                                                <picture class="d-block bg-light">
                                                    <img
                                                        class="img-fluid"
                                                        src="#imagePath##getProductImage.image#"
                                                        alt="Bootstrap 5 Template by Pixel Rocket"
                                                    >
                                                </picture>
                                            </cfif>
                                        </div>
                                        <div class="col-9">
                                            <div>
                                                <h6 class="justify-content-between d-flex align-items-start mb-2">
                                                    #getCartProductQry.productName#
                                                    <button class="btn btn-sm btn-outline-none bg-light border-0 removeCartProduct" id="removeCartProduct-#getCartProductQry.FkProductId#" data-productId ="#getCartProductQry.FkProductId#" data-name="#getCartProductQry.productName#">
                                                        <i class="ri-close-line"></i>
                                                    </button>
                                                </h6>
                                                <small class="d-block text-muted fw-bolder">Qty: #getCartProductQry.quantity#</small>
                                            </div>
                                            <p class="fw-bolder text-end m-0"><i class="fa fa-rupee"></i> #priceTotal#</p>
                                        </div>
                                    </div>
                                </cfloop>
                                <!--- / Cart Product --->
                            </div>
                            <div class="border-top pt-3">
                                <div class="d-flex justify-content-between align-items-center">
                                    <p class="m-0 fw-bolder">Subtotal</p>
                                    <p class="m-0 fw-bolder"><i class="fa fa-rupee"></i> #productSubTotal#</p>
                                </div>
                                <a
                                    href="index.cfm?pg=checkOut"
                                    class="btn btn-orange btn-orange-chunky mt-5 mb-2 d-block text-center"
                                >Checkout</a>
                                <a
                                    href="index.cfm?pg=cart"
                                    class="btn btn-dark fw-bolder d-block text-center transition-all opacity-50-hover"
                                >View Cart</a>
                            </div>
                        </div>
                    </div>
                <cfelse>
                    <div class="offcanvas-header align-items-center">
                        <h5 class="offcanvas-title">Cart Is Empty!!</h5>
                    </div>
                </cfif>
            </cfoutput>
        </cfsavecontent>
    </cfif>
    <cfif structKeyExists(url, "removeCartProduct")>
        <cfset checkProdArray = arrayFind(session.cart.product, function(idx) {
            return idx['FkProductId'] EQ url.removeCartProduct
        })>
        <cfset arrayDeleteAt(session.cart.product,checkProdArray)>
        <cfquery name="deleteCartProduct">
            DELETE FROM cart 
            WHERE FkProductId = <cfqueryparam value = "#url.removeCartProduct#" cfsqltype = "cf_sql_integer">
        </cfquery>
    </cfif>
    <cfif structKeyExists(url, "removeAllCartValue") AND url.removeAllCartValue EQ "removeAllProductToCart">
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
    <cfif structKeyExists(url, "getCartCountValue") AND url.getCartCountValue EQ "cartCounter">
        <cfquery name="getCartCount">
            SELECT SUM(quantity) AS 'totalCartValue' FROM cart WHERE FkCustomerId = <cfqueryparam value = "#session.customer.isLoggedIn#" cfsqltype = "cf_sql_integer"> 
        </cfquery>
        <cfset data['cartCountValue'] = getCartCount.totalCartValue>
        <!--- <cfif getCartCount.recordCount GT 0>
            <cfset data['cartCountValue'] = getCartCount.totalCartValue>
        <cfelse>
            <cfset data['cartCountValue'] = 0>
        </cfif> --->
        <!---  <cflock timeout="1" scope="session" type="exclusive">  --->
            <!--- <cfset session.cart.cartCount = getCartCount.totalCartValue> --->
            <!--- <cfset totalQuantity = {}>
            <cfset totalQuantity = getCartCount.totalCartValue> --->
            <!--- <cfset session.cart.product = [{'FkProductId':getCartProductQry.FkProductId,'Quantity':getCartCount.totalCartValue, 'totalCost':''}]> --->
            <!--- <cfset arrayAppend(session.cart.product['Quantity'], totalQuantity)> --->
        <!---  </cflock> --->
    </cfif>
    <cfif structKeyExists(url, "formAction") AND url.formAction EQ "addWishList">
        <!---  <cfdump  var="#form#">
            <cfdump  var="#url#"><cfabort> --->
        <cfquery name="getProductWishList">
            SELECT 
                PkWishListId, FkProductId, FkCustomerId, isLike
            FROM product_wishlist
            WHERE FkProductId = <cfqueryparam value="#form.productId#" cfsqltype = "cf_sql_integer">
            AND FkCustomerId = <cfqueryparam value="#form.customerId#" cfsqltype = "cf_sql_integer">
        </cfquery>
        <!--- <cfdump  var="#getProductWishList.recordcount#"> --->
        <cfif getProductWishList.FkProductId EQ form.productId>
            <cfquery result="updateWishListData">
                UPDATE product_wishlist SET
                FkProductId =  <cfqueryparam value = "#form.productId#" cfsqltype = "cf_sql_integer">
                , FkCustomerId =  <cfqueryparam value = "#form.customerId#" cfsqltype = "cf_sql_integer">
                , isLike =  <cfqueryparam value = "#form.isLike#" cfsqltype = "cf_sql_bit">
                , updatedBy =  <cfqueryparam value = "#session.customer.isLoggedIn#" cfsqltype = "cf_sql_integer">
                , dateUpdated =  <cfqueryparam value = "#now()#" cfsqltype = "cf_sql_datetime">
                WHERE FkCustomerId = <cfqueryparam value = "#form.customerId#" cfsqltype = "cf_sql_integer">
                AND FkProductId =  <cfqueryparam value = "#form.productId#" cfsqltype = "cf_sql_integer">
            </cfquery>
            <!--- <cfdump  var="#insertLikeData#"><cfabort> --->
            <cfelse>
                <cfquery result="insertLikeData">
                    INSERT INTO product_wishlist (
                        FkProductId
                        , FkCustomerId
                        , isLike
                        , createdBy
                    ) VALUES (
                        <cfqueryparam value = "#form.productId#" cfsqltype = "cf_sql_integer">
                        , <cfqueryparam value = "#form.customerId#" cfsqltype = "cf_sql_integer">
                        , <cfqueryparam value = "#form.isLike#" cfsqltype = "cf_sql_bit">
                        , <cfqueryparam value = "#session.customer.isLoggedIn#" cfsqltype = "cf_sql_integer">
                    )
                </cfquery>
        </cfif>
    </cfif>
    <cfif structKeyExists(url, "formAction") AND url.formAction EQ "removeWishList">
        <cfquery result="updateWishListData">
            UPDATE product_wishlist SET
            FkProductId =  <cfqueryparam value = "#form.productId#" cfsqltype = "cf_sql_integer">
            , FkCustomerId =  <cfqueryparam value = "#session.customer.isLoggedIn#" cfsqltype = "cf_sql_integer">
            , isLike =  <cfqueryparam value = "0" cfsqltype = "cf_sql_bit">
            , updatedBy =  <cfqueryparam value = "#session.customer.isLoggedIn#" cfsqltype = "cf_sql_integer">
            WHERE FkCustomerId = <cfqueryparam value = "#session.customer.isLoggedIn#" cfsqltype = "cf_sql_integer">
            AND FkProductId =  <cfqueryparam value = "#form.productId#" cfsqltype = "cf_sql_integer">
        </cfquery>
    </cfif>
    <cfcatch>
        <cfset data['success'] = false>
        <cfset data['error'] = cfcatch>
    </cfcatch>
</cftry>
<cfset output =  serializeJSON(data)/>
<cfoutput>#output#</cfoutput>