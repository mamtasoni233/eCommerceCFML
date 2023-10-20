<cfsetting enablecfoutputonly="true" showdebugoutput="false" />
<cfheader statuscode="200" statustext="OK" />
<cfcontent reset="true" type="application/json" />

<cfparam name="PkCouponId" default="" />
<cfparam name="couponName" default="" />
<cfparam name="couponCode" default="" />
<cfparam name="discountValue" default="" />
<cfparam name="discountType" default="" />
<cfparam name="couponStartDate" default="" />
<cfparam name="couponExpDate" default="" />
<cfparam name="repeatRestriction" default="" />
<cfparam name="formAction" default="" />

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
<cfset productImagePath = ExpandPath('./assets/productImage/')>

<cfif structKeyExists(url, "formAction") AND url.formAction EQ "getRecord">
    <cfquery name="getCouponDataRows">
        SELECT C.PkCouponId, C.couponName, C.couponCode, C.discountValue, C.discountType, C.couponStartDate, C.couponExpDate, C.repeatRestriction,  C.isActive, C.createdBy, C.updatedBy, C.dateCreated, C.dateUpdated, C.isDeleted, U.PkUserId, CONCAT_WS(" ", U.firstName, U.lastName) AS userName, CONCAT_WS(" ", userUpdate.firstName, userUpdate.lastName) AS userNameUpdate
        FROM coupons C
        LEFT JOIN users U ON C.createdBy = U.PkUserId
        LEFT JOIN users userUpdate ON C.updatedBy = userUpdate.PkUserId
        WHERE 1 = 1
        <cfif structKeyExists(form, "isDeleted") AND form.isDeleted NEQ 2>
            AND C.isDeleted = <cfqueryparam value="#form.isDeleted#" cfsqltype = "cf_sql_integer">
        </cfif>

        <cfif structKeyExists(form, "search") AND len(form.search) GT 0>
            AND ( U.firstName LIKE <cfqueryparam value="%#trim(search)#%"> 
                    OR U.lastName LIKE <cfqueryparam value="%#trim(search)#%"> 
                    ORC.couponName LIKE <cfqueryparam value="%#trim(search)#%">
                    OR C.discountType LIKE <cfqueryparam value="%#trim(search)#%">
                    ORC.couponCode LIKE <cfqueryparam value="%#trim(search)#%">
                    ORC.discountValue LIKE <cfqueryparam value="%#trim(search)#%">
                )
        </cfif>
        <cfif structKeyExists(form, "order") AND len(form.order) GT 0>
            ORDER BY #form.order#
        </cfif>
    </cfquery>
    <cfquery name="getCouponData">
        SELECT C.PkCouponId, C.couponName, C.couponCode, C.discountValue, C.discountType, C.couponStartDate, C.couponExpDate, C.repeatRestriction,  C.isActive, C.createdBy, C.updatedBy, C.dateCreated, C.dateUpdated, C.isDeleted, U.PkUserId, CONCAT_WS(" ", U.firstName, U.lastName) AS userName, CONCAT_WS(" ", userUpdate.firstName, userUpdate.lastName) AS userNameUpdate
        FROM coupons C
        LEFT JOIN users U ON C.createdBy = U.PkUserId
        LEFT JOIN users userUpdate ON C.updatedBy = userUpdate.PkUserId
        WHERE 1 = 1
        <cfif structKeyExists(form, "isDeleted") AND form.isDeleted NEQ 2>
            AND C.isDeleted = <cfqueryparam value="#form.isDeleted#" cfsqltype = "cf_sql_integer">
        </cfif>

        <cfif structKeyExists(form, "search") AND len(form.search) GT 0>
            AND ( U.firstName LIKE <cfqueryparam value="%#trim(search)#%"> 
                    OR U.lastName LIKE <cfqueryparam value="%#trim(search)#%"> 
                    ORC.couponName LIKE <cfqueryparam value="%#trim(search)#%">
                    OR C.discountType LIKE <cfqueryparam value="%#trim(search)#%">
                    ORC.couponCode LIKE <cfqueryparam value="%#trim(search)#%">
                    ORC.discountValue LIKE <cfqueryparam value="%#trim(search)#%">
                )
        </cfif>
        <cfif structKeyExists(form, "order") AND len(form.order) GT 0>
            ORDER BY #form.order#
        </cfif>
        LIMIT #form.start#, #form.length#
        
    </cfquery>
    <cfset data['data'] = []>
    <cfset data['recordsFiltered'] = getCouponDataRows.recordCount>
    <cfset data['draw'] = form.draw>
    <cfset data['recordsTotal'] = getCouponDataRows.recordCount>
    <cfloop query="getCouponData">
        <cfset dataRecord = {}>
        <cfset dataRecord['PkCouponId'] = getCouponData.PkCouponId>
        <cfset dataRecord['couponName'] = getCouponData.couponName>
        <cfset dataRecord['couponCode'] = getCouponData.couponCode>
        <cfset dataRecord['discountValue'] = getCouponData.discountValue>
        <cfset dataRecord['discountType'] = getCouponData.discountType>
        <cfset dataRecord['repeatRestriction'] = getCouponData.repeatRestriction>
        <cfset dataRecord['couponStartDate'] = dateTimeFormat(getCouponData.couponStartDate, 'dd-mm-yyyy')>
        <cfset dataRecord['couponExpDate'] = dateTimeFormat(getCouponData.couponExpDate, 'dd-mm-yyyy')>
        <cfset dataRecord['isActive'] = getCouponData.isActive>
        <cfset dataRecord['isDeleted'] = getCouponData.isDeleted>
        <cfset dataRecord['createdBy'] = getCouponData.createdBy>
        <cfset dataRecord['dateCreated'] = dateTimeFormat(getCouponData.dateCreated, 'dd-mm-yyyy hh:nn:ss tt')>
        <cfset dataRecord['dateUpdated'] = dateTimeFormat(getCouponData.dateUpdated, 'dd-mm-yyyy hh:nn:ss tt')>
        <cfset dataRecord['updatedBy'] = getCouponData.updatedBy>
        <cfset dataRecord['PkUserId'] = getCouponData.PkUserId>
        <cfset dataRecord['userName'] = getCouponData.userName>
        <cfset dataRecord['userNameUpdate'] = getCouponData.userNameUpdate>
        <cfset dataRecord['sNo'] = 1>
        <cfset arrayAppend(data['data'], dataRecord)>
    </cfloop>
</cfif>

<cfif structKeyExists(url, "PkCouponId") AND url.PkCouponId GT 0>
    <cfquery name="editCouponData">
        SELECT C.PkCouponId, C.couponName, C.couponCode, C.discountValue, C.discountType, C.couponStartDate, C.couponExpDate, C.repeatRestriction, C.isActive
        FROM coupons C
        WHERE PkCouponId = <cfqueryparam value="#PkCouponId#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfset data['json'] = {}>
    <cfset data['json']['PkCouponId'] = editCouponData.PkCouponId>
    <cfset data['json']['couponName'] = editCouponData.couponName>
    <cfset data['json']['couponCode'] = editCouponData.couponCode>
    <cfset data['json']['discountValue'] = editCouponData.discountValue>
    <cfset data['json']['discountType'] = editCouponData.discountType>
    <cfset data['json']['couponStartDate'] = dateTimeFormat(editCouponData.couponStartDate, 'dd-mm-yyyy')>
    <cfset data['json']['couponExpDate'] = dateTimeFormat(editCouponData.couponExpDate, 'dd-mm-yyyy')>
    <cfset data['json']['repeatRestriction'] = editCouponData.repeatRestriction>
    <cfset data['json']['isActive'] = editCouponData.isActive>

</cfif>

<cfif structKeyExists(form, "couponName") AND len(trim(form.couponName)) GT 0>
    <cfif NOT structKeyExists(form, "isActive")>
        <cfset isActive = 0>
    <cfelse>
        <cfset isActive = form.isActive>
    </cfif>
    <cfset productId = 0>
    <cfif structKeyExists(url, "PkCouponId") AND url.PkCouponId GT 0>
        <cfset productId = url.PkCouponId>
        <cfquery name="updateCouponData">
            UPDATE coupons SET
            couponName = <cfqueryparam value = "#form.couponName#" cfsqltype = "cf_sql_varchar">
            , couponCode = <cfqueryparam value = "#form.couponCode#" cfsqltype = "cf_sql_varchar">
            , discountValue =  <cfqueryparam value = "#form.discountValue#" cfsqltype = "cf_sql_float">
            , discountType =  <cfqueryparam value = "#form.discountType#" cfsqltype = "cf_sql_integer">
            , couponStartDate =  <cfqueryparam value = "#form.couponStartDate#" cfsqltype = "cf_sql_date">
            , couponExpDate =  <cfqueryparam value = "#form.couponExpDate#" cfsqltype = "cf_sql_date">
            , repeatRestriction =  <cfqueryparam value = "#form.repeatRestriction#" cfsqltype = "cf_sql_integer">
            , isActive = <cfqueryparam value = "#isActive#" cfsqltype = "cf_sql_bit">
            , updatedBy =  <cfqueryparam value = "#session.user.isLoggedIn#" cfsqltype = "cf_sql_integer">
            , dateUpdated =  <cfqueryparam value = "#now()#" cfsqltype = "cf_sql_datetime">
            WHERE PkCouponId = <cfqueryparam value = "#url.PkCouponId#" cfsqltype = "cf_sql_integer">
        </cfquery>
    <cfelse>
        <cfquery result="addProductData">
            INSERT INTO coupons (
                couponName
                , couponCode
                , discountValue
                , discountType
                , couponStartDate
                , couponExpDate
                , repeatRestriction
                , isActive
                , createdBy
                , dateCreated
            ) VALUES (
                <cfqueryparam value = "#form.couponName#" cfsqltype = "cf_sql_varchar">
                ,  <cfqueryparam value = "#form.couponCode#" cfsqltype = "cf_sql_varchar">
                , <cfqueryparam value = "#form.discountValue#" cfsqltype = "cf_sql_float">
                , <cfqueryparam value = "#form.discountType#" cfsqltype = "cf_sql_integer">
                , <cfqueryparam value = "#form.couponStartDate#" cfsqltype = "cf_sql_date">
                , <cfqueryparam value = "#form.couponExpDate#" cfsqltype = "cf_sql_date">
                , <cfqueryparam value = "#form.repeatRestriction#" cfsqltype = "cf_sql_integer">
                , <cfqueryparam value = "#isActive#" cfsqltype = "cf_sql_bit">
                , <cfqueryparam value = "#session.user.isLoggedIn#" cfsqltype = "cf_sql_integer">
                , <cfqueryparam value = "#now()#" cfsqltype = "cf_sql_datetime">
            )
        </cfquery>
    </cfif>
</cfif>
<cfif structKeyExists(url, "statusId") AND url.statusId GT 0>
    <cfquery name="changeStatus">
        UPDATE coupons SET
        isActive = !isActive
        WHERE PkCouponId = <cfqueryparam value = "#url.statusId#" cfsqltype = "cf_sql_integer">
    </cfquery>
</cfif>

<cfif structKeyExists(url, 'delPkCouponId') AND url.delPkCouponId GT 0>
    <cfquery result="deleteCouponData">
        UPDATE coupons SET
        isDeleted = <cfqueryparam value="1" cfsqltype = "cf_sql_integer">
        WHERE PkCouponId IN(<cfqueryparam value="#url.delPkCouponId#" list="true">)
    </cfquery>
</cfif>
<cfif structKeyExists(url, 'restorePkCouponId') AND url.restorePkCouponId GT 0>
    <cfquery result="restoreProductData">
        UPDATE coupons SET
        isDeleted = <cfqueryparam value="0" cfsqltype = "cf_sql_integer">
        WHERE PkCouponId = <cfqueryparam value="#url.restorePkCouponId#" cfsqltype = "cf_sql_integer">
    </cfquery>
</cfif>

<cfset output = serializeJson(data) />
<cfoutput>#rereplace(output,'//','')#</cfoutput>