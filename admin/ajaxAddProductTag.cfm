<cfsetting enablecfoutputonly="true" showdebugoutput="false" />
<cfheader statuscode="200" statustext="OK" />
<cfcontent reset="true" type="application/json" />

<cfparam name="PkTagId" default="" />
<cfparam name="FkCategoryId" default="" />
<cfparam name="tagName" default="" />
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

<cffunction name="getCategoryResult" access="public" returntype="array">
        <cfargument name="parentId" default="0" required="true" type="any"/>
        <cfargument name="parentName" required="true" type="any"/>
        <cfargument name="returnArray" required="true" type="any"/>

        <cfset var qryGetCategory = "">
        <cfquery name="qryGetCategory">
            SELECT categoryName, PkCategoryId, parentCategoryId FROM Category 
            WHERE parentCategoryId =  <cfqueryparam value="#arguments.parentId#" cfsqltype="cf_sql_integer">
            AND isDeleted = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfif qryGetCategory.recordCount GT 0>
            <cfloop query="qryGetCategory">
                <cfset var res = StructNew()>
                <cfset res['catName'] = qryGetCategory.categoryName>
                <cfset res['PkCategoryId'] = qryGetCategory.PkCategoryId>
                <cfset res['parentCategoryId'] = qryGetCategory.parentCategoryId>
                <cfif len(arguments.parentName) GT 0>
                    <cfset res['catName']  = arguments.parentName & ' -> ' & qryGetCategory.categoryName>
                </cfif>
                <cfset test = reFind("->", res['catName'], 1, false, "all")>
                <cfif isArray(test) AND arrayLen(test) GT 0>
                    <cfset arrayAppend(arguments.returnArray, res)>
                </cfif>
                <cfset getCategoryResult(qryGetCategory.PkCategoryId, res['catName'], arguments.returnArray)>
            </cfloop>
        </cfif>
        <cfreturn arguments.returnArray>
</cffunction>

<cfset data = {}>
<cfset data['success'] = true>

<cfif structKeyExists(url, "formAction") AND url.formAction EQ "getRecord">
    <cfquery name="getProductTagDataRows">
        SELECT C.PkCategoryId, C.categoryName, P.PkTagId, P.tagName, P.isActive, P.createdBy, P.updatedBy, P.dateCreated, P.dateUpdated, P.isDeleted, U.PkUserId, CONCAT_WS(" ", U.firstName, U.lastName) AS userName, CONCAT_WS(" ", userUpdate.firstName, userUpdate.lastName) AS userNameUpdate
        FROM product_tags P
        LEFT JOIN category C ON P.FkCategoryId = C.PkCategoryId
        LEFT JOIN users U ON P.createdBy = U.PkUserId
        LEFT JOIN users userUpdate ON P.updatedBy = userUpdate.PkUserId
        WHERE 1 = 1
        <cfif structKeyExists(form, "isDeleted") AND form.isDeleted NEQ 2>
            AND P.isDeleted = <cfqueryparam value="#form.isDeleted#" cfsqltype = "cf_sql_integer">
        </cfif>

        <cfif structKeyExists(form, "search") AND len(form.search) GT 0>
            AND ( U.firstName LIKE <cfqueryparam value="%#trim(search)#%"> 
                    OR U.lastName LIKE <cfqueryparam value="%#trim(search)#%"> 
                    OR P.tagName LIKE <cfqueryparam value="%#trim(search)#%">
                    OR CONCAT_WS(' ', U.firstName, U.lastName) LIKE <cfqueryparam value="%#trim(search)#%">
                    OR CONCAT_WS(' ', userUpdate.firstName, userUpdate.lastName) LIKE <cfqueryparam value="%#trim(search)#%">
                )
        </cfif>
        <cfif structKeyExists(form, "order") AND len(form.order) GT 0>
            ORDER BY #form.order#
        </cfif>
    </cfquery>
    <cfquery name="getProductTagData">
        SELECT C.PkCategoryId, C.categoryName, P.PkTagId, P.tagName, P.isActive, P.createdBy, P.updatedBy, P.dateCreated, P.dateUpdated, P.isDeleted, U.PkUserId, CONCAT_WS(" ", U.firstName, U.lastName) AS userName, CONCAT_WS(" ", userUpdate.firstName, userUpdate.lastName) AS userNameUpdate
        FROM product_tags P
        LEFT JOIN category C ON P.FkCategoryId = C.PkCategoryId
        LEFT JOIN users U ON P.createdBy = U.PkUserId
        LEFT JOIN users userUpdate ON P.updatedBy = userUpdate.PkUserId
        WHERE 1 = 1
        <cfif structKeyExists(form, "isDeleted") AND form.isDeleted NEQ 2>
            AND P.isDeleted = <cfqueryparam value="#form.isDeleted#" cfsqltype = "cf_sql_integer">
        </cfif>

        <cfif structKeyExists(form, "search") AND len(form.search) GT 0>
            AND ( U.firstName LIKE <cfqueryparam value="%#trim(search)#%"> 
                    OR U.lastName LIKE <cfqueryparam value="%#trim(search)#%"> 
                    OR P.tagName LIKE <cfqueryparam value="%#trim(search)#%">
                    OR CONCAT_WS(' ', U.firstName, U.lastName) LIKE <cfqueryparam value="%#trim(search)#%">
                    OR CONCAT_WS(' ', userUpdate.firstName, userUpdate.lastName) LIKE <cfqueryparam value="%#trim(search)#%">
                )
        </cfif>
        <cfif structKeyExists(form, "order") AND len(form.order) GT 0>
            ORDER BY #form.order#
        </cfif>
        LIMIT #form.start#, #form.length#
    </cfquery>
    <cfset data['data'] = []>
    <cfset data['recordsFiltered'] = getProductTagDataRows.recordCount>
    <cfset data['draw'] = form.draw>
    <cfset data['recordsTotal'] = getProductTagDataRows.recordCount>
    <cfloop query="getProductTagData">
        <cfset dataRecord = {}>

        <cfset dataRecord['PkTagId'] = getProductTagData.PkTagId>
        <cfset dataRecord['tagName'] = getProductTagData.tagName>
        <cfset dataRecord['categoryName'] = getProductTagData.categoryName>
        <cfset dataRecord['isActive'] = getProductTagData.isActive>
        <cfset dataRecord['isDeleted'] = getProductTagData.isDeleted>
        <cfset dataRecord['createdBy'] = getProductTagData.createdBy>
        <cfset dataRecord['dateCreated'] = dateTimeFormat(getProductTagData.dateCreated, 'dd-mm-yyyy hh:nn:ss tt')>
        <cfset dataRecord['dateUpdated'] = dateTimeFormat(getProductTagData.dateUpdated, 'dd-mm-yyyy hh:nn:ss tt')>
        <cfset dataRecord['updatedBy'] = getProductTagData.updatedBy>
        <cfset dataRecord['PkUserId'] = getProductTagData.PkUserId>
        <cfset dataRecord['userName'] = getProductTagData.userName>
        <cfset dataRecord['userNameUpdate'] = getProductTagData.userNameUpdate>
        <cfset arrayAppend(data['data'], dataRecord)>
    </cfloop>
</cfif>

<cfif structKeyExists(url, "PkTagId") AND url.PkTagId GT 0>
    <cfquery name="editProductTagData">
        SELECT PkTagId, tagName, isActive, FkCategoryId
        FROM product_tags 
        WHERE PkTagId = <cfqueryparam value="#PkTagId#" cfsqltype="cf_sql_integer">
    </cfquery>

    <cfset data['json'] = {}>
    <cfset data['json']['PkTagId'] = editProductTagData.PkTagId>
    <cfset data['json']['FkCategoryId'] = editProductTagData.FkCategoryId>
    <cfset data['json']['tagName'] = editProductTagData.tagName>
    <cfset data['json']['isActive'] = editProductTagData.isActive>
</cfif>


<cfif structKeyExists(form, "tagName") AND len(form.tagName) GT 0>
    <cfif NOT structKeyExists(form, "isActive")>
        <cfset isActive = 0>
    <cfelse>
        <cfset isActive = form.isActive>
    </cfif>
    <cfset productId = 0>

    <cfif structKeyExists(url, "PkTagId") AND url.PkTagId GT 0>
        
        <cfset productId = url.PkTagId>
        <cfquery name="updateproductTagData">
            UPDATE product_tags SET
            tagName = <cfqueryparam value = "#form.tagName#" cfsqltype = "cf_sql_varchar">
            , FkCategoryId =  <cfqueryparam value = "#form.category#" cfsqltype = "cf_sql_integer">
            , isActive = <cfqueryparam value = "#isActive#" cfsqltype = "cf_sql_bit">
            , updatedBy =  <cfqueryparam value = "#session.user.isLoggedIn#" cfsqltype = "cf_sql_integer">
            , dateUpdated =  <cfqueryparam value = "#now()#" cfsqltype = "cf_sql_datetime">
            WHERE PkTagId = <cfqueryparam value = "#url.PkTagId#" cfsqltype = "cf_sql_integer">
        </cfquery>
    <cfelse>
        <cfquery result="addProductData">
            INSERT INTO product_tags (
                tagName
                , FkCategoryId
                , isActive
                , createdBy
                , dateCreated
            ) VALUES (
                <cfqueryparam value = "#form.tagName#" cfsqltype = "cf_sql_varchar">
                , <cfqueryparam value = "#form.category#" cfsqltype = "cf_sql_integer">
                , <cfqueryparam value = "#isActive#" cfsqltype = "cf_sql_bit">
                , <cfqueryparam value = "#session.user.isLoggedIn#" cfsqltype = "cf_sql_integer">
                , <cfqueryparam value = "#now()#" cfsqltype = "cf_sql_datetime">
            )
        </cfquery>
        <cfset productId = addProductData.generatedKey>
    </cfif>
    
</cfif>
<cfif structKeyExists(url, "statusId") AND url.statusId GT 0>
    <cfquery name="changeStatus">
        UPDATE product_tags SET
        isActive = !isActive
        WHERE PkTagId = <cfqueryparam value = "#url.statusId#" cfsqltype = "cf_sql_integer">
    </cfquery>
</cfif>

<cfif structKeyExists(url, "formAction") AND url.formAction EQ 'getCategory'>
    <cfset data['categoryList'] = getCategoryResult(0,"",[])>
</cfif>

<cfif structKeyExists(url, 'delPkTagId') AND url.delPkTagId GT 0>
    <cfquery result="deleteProductData">
        UPDATE product_tags SET
        isDeleted = <cfqueryparam value="1" cfsqltype = "cf_sql_bit">
        WHERE PkTagId = <cfqueryparam value="#url.delPkTagId#" cfsqltype = "cf_sql_integer">
    </cfquery>
</cfif>
<cfif structKeyExists(url, 'restorePkTagId') AND url.restorePkTagId GT 0>
    <cfquery result="restorePRoductTagData">
        UPDATE product_tags SET
        isDeleted = <cfqueryparam value="0" cfsqltype = "cf_sql_bit">
        WHERE PkTagId = <cfqueryparam value="#url.restorePkTagId#" cfsqltype = "cf_sql_integer">
    </cfquery>
</cfif>

<cfset output = serializeJson(data) />
<cfoutput>#rereplace(output,'//','')#</cfoutput>