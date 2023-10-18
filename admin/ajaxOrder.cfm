<cfsetting enablecfoutputonly="true" showdebugoutput="false" />
<cfheader statuscode="200" statustext="OK" />
<cfcontent reset="true" type="application/json" />

<cfparam name="PkItemId" default="" />
<cfparam name="FkCustomerId" default="" />
<cfparam name="FkProductId" default="" />
<cfparam name="FkOrderId" default="" />
<cfparam name="PkCategoryId" default="" />
<cfparam name="totalQuantity" default="" />
<cfparam name="totalCost" default="" />
<cfparam name="statusId" default="" />
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
<cftry>
    <cfif structKeyExists(url, "formAction") AND url.formAction EQ "getRecord">
        <cfquery name="getOrderDataRows">
            SELECT O.PkItemId, O.FkCustomerId, O.FkOrderId, O.FkProductId, O.totalQuantity, O.totalCost, O.statusId, O.createdBy, O.updatedBy, O.dateCreated, O.dateUpdated, C.PkCustomerId, CONCAT_WS(" ", OD.firstName, OD.lastName) AS customerName, userUpdate.PkUserId, CONCAT_WS(" ", userUpdate.firstName, userUpdate.lastName) AS userNameUpdate
            FROM order_item O
            LEFT JOIN customer C ON O.createdBy = C.PkCustomerId
            LEFT JOIN orders OD ON O.FkOrderId = OD.PkOrderId
            LEFT JOIN users userUpdate ON O.updatedBy = userUpdate.PkUserId
            WHERE  1 = 1
            <cfif structKeyExists(form, "statusId") AND form.statusId NEQ 4>
                AND O.statusId = <cfqueryparam value="#form.statusId#" cfsqltype = "cf_sql_integer">
            </cfif>
            <cfif structKeyExists(form, "search") AND len(form.search) GT 0>
                AND ( C.firstName LIKE <cfqueryparam value="%#trim(search)#%"> 
                        OR C.lastName LIKE <cfqueryparam value="%#trim(search)#%"> 
                        OR CONCAT_WS(" ", OD.firstName, OD.lastName) LIKE <cfqueryparam value="%#trim(search)#%">
                    )
            </cfif>
            Group By O.FkOrderId
            <cfif structKeyExists(form, "order") AND len(form.order) GT 0>
                ORDER BY #form.order#
            </cfif>
        </cfquery>
        <cfquery name="getOrderData">
            SELECT O.PkItemId, O.FkCustomerId, O.FkOrderId, O.FkProductId, O.totalQuantity, O.totalCost, O.statusId, O.createdBy, O.updatedBy, O.dateCreated, O.dateUpdated, C.PkCustomerId, CONCAT_WS(" ", OD.firstName, OD.lastName) AS customerName, userUpdate.PkUserId, CONCAT_WS(" ", userUpdate.firstName, userUpdate.lastName) AS userNameUpdate
            FROM order_item O
            LEFT JOIN customer C ON O.createdBy = C.PkCustomerId
            LEFT JOIN orders OD ON O.FkOrderId = OD.PkOrderId
            LEFT JOIN users userUpdate ON O.updatedBy = userUpdate.PkUserId
            WHERE  1 = 1
            <cfif structKeyExists(form, "statusId") AND form.statusId NEQ 4>
                AND O.statusId = <cfqueryparam value="#form.statusId#" cfsqltype = "cf_sql_integer">
            </cfif>
            <cfif structKeyExists(form, "search") AND len(form.search) GT 0>
                AND ( C.firstName LIKE <cfqueryparam value="%#trim(search)#%"> 
                        OR C.lastName LIKE <cfqueryparam value="%#trim(search)#%"> 
                        OR CONCAT_WS(" ", OD.firstName, OD.lastName) LIKE <cfqueryparam value="%#trim(search)#%">
                    )
            </cfif>
            Group By O.FkOrderId
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

            <cfset dataRecord['PkItemId'] = getOrderData.PkItemId>
            <cfset dataRecord['FkOrderId'] = getOrderData.FkOrderId>
            <cfset dataRecord['statusId'] = getOrderData.statusId>
            <cfset dataRecord['createdBy'] = getOrderData.createdBy>
            <cfset dataRecord['dateCreated'] = dateTimeFormat(getOrderData.dateCreated, 'dd-mm-yyyy hh:nn:ss tt')>
            <cfset dataRecord['dateUpdated'] = dateTimeFormat(getOrderData.dateUpdated, 'dd-mm-yyyy hh:nn:ss tt')>
            <cfset dataRecord['updatedBy'] = getOrderData.updatedBy>
            <cfset dataRecord['PkUserId'] = getOrderData.PkUserId>
            <cfset dataRecord['PkCustomerId'] = getOrderData.PkCustomerId>
            <cfset dataRecord['customerName'] = getOrderData.customerName>
            <cfset dataRecord['userNameUpdate'] = getOrderData.userNameUpdate>
            <cfset arrayAppend(data['data'], dataRecord)>
        </cfloop>
    </cfif>

    <cfif structKeyExists(url, "FkOrderId") AND url.FkOrderId GT 0>
        <cfquery name="editOrderItemData">
            SELECT O.PkItemId, O.FkCustomerId, O.FkOrderId, O.FkProductId, O.totalQuantity, O.totalCost, O.statusId, O.createdBy, O.updatedBy, O.dateCreated, O.dateUpdated, C.PkCustomerId, CONCAT_WS(" ", C.firstName, C.lastName) AS customerName, userUpdate.PkUserId, CONCAT_WS(" ", userUpdate.firstName, userUpdate.lastName) AS userNameUpdate, PI.image, P.productName, Ord.address, Ord.billingAddress
            FROM order_item O
            LEFT JOIN customer C ON O.createdBy = C.PkCustomerId
            LEFT JOIN product P ON O.FkProductId = P.PkProductId 
            LEFT JOIN product_image PI ON O.FkProductId = PI.FkProductId AND PI.isDefault = 1
            LEFT JOIN orders Ord ON O.FkOrderId = Ord.PkOrderId
            LEFT JOIN users userUpdate ON O.updatedBy = userUpdate.PkUserId
            WHERE  O.FkOrderId = <cfqueryparam value="#url.FkOrderId#" cfsqltype = "cf_sql_integer">
        </cfquery>

        <cfset data['json'] = {}>

        <cfset data['json']['PkItemId'] = editOrderItemData.PkItemId>
        <cfset data['json']['FkOrderId'] = editOrderItemData.FkOrderId>
        <cfset data['json']['address'] = editOrderItemData.address>
        <cfset data['json']['billingAddress'] = editOrderItemData.billingAddress>
    </cfif>

    <cfif structKeyExists(url, "formAction") AND url.formAction EQ "getOrderItemRecord" >
        <cfquery name="getOrderItemDataRows">
            SELECT O.PkItemId, O.FkCustomerId, O.FkOrderId, O.FkProductId, O.totalQuantity, O.totalCost, O.statusId, O.createdBy, O.updatedBy, O.dateCreated, O.dateUpdated, C.PkCustomerId, CONCAT_WS(" ", C.firstName, C.lastName) AS customerName, userUpdate.PkUserId, CONCAT_WS(" ", userUpdate.firstName, userUpdate.lastName) AS userNameUpdate, PI.image, P.productName
            FROM order_item O
            LEFT JOIN customer C ON O.createdBy = C.PkCustomerId
            LEFT JOIN product P ON O.FkProductId = P.PkProductId 
            LEFT JOIN product_image PI ON O.FkProductId = PI.FkProductId AND PI.isDefault = 1
            LEFT JOIN users userUpdate ON O.updatedBy = userUpdate.PkUserId
            WHERE  O.FkOrderId = <cfqueryparam value="#form.FkOrderId#" cfsqltype = "cf_sql_integer">
        </cfquery>
        <cfquery name="getOrderItemData">
            SELECT O.PkItemId, O.FkCustomerId, O.FkOrderId, O.FkProductId, O.totalQuantity, O.totalCost, O.statusId, O.createdBy, O.updatedBy, O.dateCreated, O.dateUpdated, C.PkCustomerId, CONCAT_WS(" ", C.firstName, C.lastName) AS customerName, userUpdate.PkUserId, CONCAT_WS(" ", userUpdate.firstName, userUpdate.lastName) AS userNameUpdate, PI.image, P.productName
            FROM order_item O
            LEFT JOIN customer C ON O.createdBy = C.PkCustomerId
            LEFT JOIN product P ON O.FkProductId = P.PkProductId 
            LEFT JOIN product_image PI ON O.FkProductId = PI.FkProductId AND PI.isDefault = 1
            LEFT JOIN users userUpdate ON O.updatedBy = userUpdate.PkUserId
            WHERE  O.FkOrderId = <cfqueryparam value="#form.FkOrderId#" cfsqltype = "cf_sql_integer">
            <cfif structKeyExists(form, "order") AND len(form.order) GT 0>
                ORDER BY #form.order#
            </cfif>
            LIMIT #form.start#, #form.length#
        </cfquery>
        <cfset data['data'] = []>
        <cfset data['recordsFiltered'] = getOrderItemDataRows.recordCount>
        <cfset data['draw'] = form.draw>
        <cfset data['recordsTotal'] = getOrderItemDataRows.recordCount>
        <cfloop query="getOrderItemData">
            <cfset dataRecord = {}>
            <cfset dataRecord['PkItemId'] = getOrderItemData.PkItemId>
            <cfset dataRecord['FkOrderId'] = getOrderItemData.FkOrderId>
            <cfset dataRecord['FkCustomerId'] = getOrderItemData.FkCustomerId>
            <cfset dataRecord['statusId'] = getOrderItemData.statusId>
            <cfset dataRecord['totalQuantity'] = getOrderItemData.totalQuantity>
            <cfset dataRecord['totalCost'] = getOrderItemData.totalCost>
            <cfset dataRecord['productName'] = getOrderItemData.productName>
            <cfset dataRecord['image'] = getOrderItemData.image>
            <cfset dataRecord['createdBy'] = getOrderItemData.createdBy>
            <cfset dataRecord['dateCreated'] = dateTimeFormat(getOrderItemData.dateCreated, 'dd-mm-yyyy hh:nn:ss tt')>
            <cfset dataRecord['dateUpdated'] = dateTimeFormat(getOrderItemData.dateUpdated, 'dd-mm-yyyy hh:nn:ss tt')>
            <cfset dataRecord['updatedBy'] = getOrderItemData.updatedBy>
            <cfset dataRecord['PkUserId'] = getOrderItemData.PkUserId>
            <cfset dataRecord['PkCustomerId'] = getOrderItemData.PkCustomerId>
            <cfset dataRecord['customerName'] = getOrderItemData.customerName>
            <cfset dataRecord['userNameUpdate'] = getOrderItemData.userNameUpdate>
            <cfset dataRecord['sNo'] = 1>
            <cfset arrayAppend(data['data'], dataRecord)>
        </cfloop>
    </cfif>
    <cfcatch>
        <cfset data['success'] = false>
        <cfset data['error'] = cfcatch>
    </cfcatch>
</cftry>
<cfset output =  serializeJSON(data)/>
<cfoutput>#output#</cfoutput>


