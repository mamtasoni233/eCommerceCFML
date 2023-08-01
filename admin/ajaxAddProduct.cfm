
<cfsetting enablecfoutputonly="true" showdebugoutput="false" />
<cfheader statuscode="200" statustext="OK" />
<cfcontent reset="true" type="application/json" />

<cfparam name="PkProductId" default="" />
<cfparam name="FkCategoryId" default="" />
<cfparam name="productName" default="" />
<cfparam name="productQty" default="" />
<cfparam name="productImage" default="" />
<cfparam name="productPrice" default="" />
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
        <cfargument name="parentId" required="true" type="any"/>
        <cfargument name="parentName" required="true" type="any"/>
        <cfargument name="returnArray" required="true" type="any"/>

        <cfset var qryGetCategory = "">
        <cfquery name="qryGetCategory">
            SELECT categoryName, PkCategoryId FROM Category 
            WHERE parentCategoryId =  <cfqueryparam value="#arguments.parentId#" cfsqltype="cf_sql_integer">
            AND isDeleted = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfif qryGetCategory.recordCount GT 0>
            <cfloop query="qryGetCategory">
                <cfset var res = StructNew()>
                <cfset res.catName = qryGetCategory.categoryName>
                <cfset res.PkCategoryId = qryGetCategory.PkCategoryId>
                <cfif len(arguments.parentName) GT 0>
                    <cfset res.catName  = arguments.parentName & ' -> ' & qryGetCategory.categoryName>
                </cfif>       
                <cfset arrayAppend(arguments.returnArray, res)>         
                <cfset getCategoryResult(qryGetCategory.PkCategoryId, res.catName, arguments.returnArray)>
            </cfloop>
        </cfif>
        <cfreturn arguments.returnArray>
</cffunction>


<cfset data = {}>
<cfset data['success'] = true>

<cfif structKeyExists(url, "formAction") AND url.formAction EQ "getRecord">
    <cfquery name="getProductDataRows">
        SELECT C.PkCategoryId, C.categoryName, P.PkProductId, P.productQty, P.productName, P.productPrice, P.productImage, P.isActive, P.createdBy, P.updatedBy, P.dateCreated, P.dateUpdated, P.isDeleted, U.PkUserId, CONCAT_WS(" ", U.firstName, U.lastName) AS userName, CONCAT_WS(" ", userUpdate.firstName, userUpdate.lastName) AS userNameUpdate
        FROM product P
        LEFT JOIN category C ON P.FkCategoryId = C.PkCategoryId
        LEFT JOIN users U ON P.createdBy = U.PkUserId
        LEFT JOIN users userUpdate ON P.updatedBy = userUpdate.PkUserId
        WHERE P.isDeleted = <cfqueryparam value="0" cfsqltype = "cf_sql_integer">

        <cfif structKeyExists(form, "search") AND len(form.search) GT 0>
            AND ( U.firstName LIKE <cfqueryparam value="%#trim(search)#%"> 
                    OR U.lastName LIKE <cfqueryparam value="%#trim(search)#%"> 
                    OR P.productName LIKE <cfqueryparam value="%#trim(search)#%">
                    OR P.productPrice LIKE <cfqueryparam value="%#trim(search)#%">
                    OR P.productQty LIKE <cfqueryparam value="%#trim(search)#%">
                    OR CONCAT_WS(' ', U.firstName, U.lastName) LIKE <cfqueryparam value="%#trim(search)#%">
                    OR CONCAT_WS(' ', userUpdate.firstName, userUpdate.lastName) LIKE <cfqueryparam value="%#trim(search)#%">
                )
        </cfif>
        <cfif structKeyExists(form, "order") AND len(form.order) GT 0>
            ORDER BY #form.order#
        </cfif>
    </cfquery>
    <cfquery name="getProductData">
        SELECT C.PkCategoryId, C.categoryName, P.PkProductId, P.productName,P.productQty, P.productPrice, P.productImage, P.isActive, P.createdBy, P.updatedBy, P.dateCreated, P.dateUpdated, P.isDeleted, U.PkUserId, CONCAT_WS(" ", U.firstName, U.lastName) AS userName, CONCAT_WS(" ", userUpdate.firstName, userUpdate.lastName) AS userNameUpdate
        FROM product P
        LEFT JOIN category C ON P.FkCategoryId = C.PkCategoryId
        LEFT JOIN users U ON P.createdBy = U.PkUserId
        LEFT JOIN users userUpdate ON P.updatedBy = userUpdate.PkUserId
        WHERE P.isDeleted = <cfqueryparam value="0" cfsqltype = "cf_sql_integer">

        <cfif structKeyExists(form, "search") AND len(form.search) GT 0>
            AND ( U.firstName LIKE <cfqueryparam value="%#trim(search)#%"> 
                    OR U.lastName LIKE <cfqueryparam value="%#trim(search)#%"> 
                    OR P.productName LIKE <cfqueryparam value="%#trim(search)#%">
                    OR P.productPrice LIKE <cfqueryparam value="%#trim(search)#%">
                    OR P.productQty LIKE <cfqueryparam value="%#trim(search)#%">
                    OR CONCAT_WS(' ', U.firstName, U.lastName) LIKE <cfqueryparam value="%#trim(search)#%">
                    OR CONCAT_WS(' ', userUpdate.firstName, userUpdate.lastName) LIKE <cfqueryparam value="%#trim(search)#%">
                )
        </cfif>
        <cfif structKeyExists(form, "order") AND len(form.order) GT 0>
            ORDER BY #form.order#
        </cfif>
        <cfif structKeyExists(form, "start") AND (form.start) GT 0>
            LIMIT #form.start#, #form.length#
        </cfif>
    </cfquery>
    <cfset data['data'] = []>
    <cfset data['recordsFiltered'] = getProductDataRows.recordCount>
    <cfset data['draw'] = form.draw>
    <cfset data['recordsTotal'] = getProductDataRows.recordCount>
    <cfloop query="getProductData">
        <cfset dataRecord = {}>

        <cfset dataRecord['PkProductId'] = getProductData.PkProductId>
        <cfset dataRecord['productName'] = getProductData.productName>
        <cfset dataRecord['categoryName'] = getProductData.categoryName>
        <cfset dataRecord['productQty'] = getProductData.productQty>
        <cfset dataRecord['productPrice'] = getProductData.productPrice>
        <cfset dataRecord['productImage'] = getProductData.productImage>
        <cfset dataRecord['isActive'] = getProductData.isActive>
        <cfset dataRecord['createdBy'] = getProductData.createdBy>
        <cfset dataRecord['dateCreated'] = dateTimeFormat(getProductData.dateCreated, 'dd-mm-yyyy hh:nn:ss tt')>
        <cfset dataRecord['dateUpdated'] = dateTimeFormat(getProductData.dateUpdated, 'dd-mm-yyyy hh:nn:ss tt')>
        <cfset dataRecord['updatedBy'] = getProductData.updatedBy>
        <cfset dataRecord['PkUserId'] = getProductData.PkUserId>
        <cfset dataRecord['userName'] = getProductData.userName>
        <cfset dataRecord['userNameUpdate'] = getProductData.userNameUpdate>
        <cfset arrayAppend(data['data'], dataRecord)>
    </cfloop>
</cfif>

<cfif structKeyExists(url, "PkProductId") AND url.PkProductId GT 0>
    <cfquery name="editCategoryData">
        SELECT PkProductId, productName, productImage, productPrice, productQty, isActive, FkCategoryId
        FROM product 
        WHERE PkProductId = <cfqueryparam value="#PkProductId#" cfsqltype="cf_sql_integer">
    </cfquery>

    <cfset data['json'] = {}>
    <cfset data['json']['PkProductId'] = editCategoryData.PkProductId>
    <cfset data['json']['FkCategoryId'] = editCategoryData.FkCategoryId>
    <cfset data['json']['productName'] = editCategoryData.productName>
    <cfset data['json']['productPrice'] = editCategoryData.productPrice>
    <cfset data['json']['productQty'] = editCategoryData.productQty>
    <cfset data['json']['productImage'] = editCategoryData.productImage>
    <cfset data['json']['isActive'] = editCategoryData.isActive>
</cfif>


<cfif structKeyExists(form, "productName") AND len(form.productName) GT 0>
    <cfif NOT structKeyExists(form, "isActive")>
        <cfset isActive = 0>
    <cfelse>
        <cfset isActive = form.isActive>
    </cfif>
    <cfset productId = 0>

    <cfif structKeyExists(url, "PkProductId") AND url.PkProductId GT 0>
        
        <cfset productId = url.PkProductId>
        <cfquery name="updateproductData">
            UPDATE product SET
            productName = <cfqueryparam value = "#form.productName#" cfsqltype = "cf_sql_varchar">
            , FkCategoryId =  <cfqueryparam value = "#form.category#" cfsqltype = "cf_sql_integer">
            , productPrice =  <cfqueryparam value = "#form.productPrice#" cfsqltype = "cf_sql_float">
            , productQty =  <cfqueryparam value = "#form.productQty#" cfsqltype = "cf_sql_integer">
            , isActive = <cfqueryparam value = "#isActive#" cfsqltype = "cf_sql_bit">
            , updatedBy =  <cfqueryparam value = "#session.user.isLoggedIn#" cfsqltype = "cf_sql_integer">
            , dateUpdated =  <cfqueryparam value = "#now()#" cfsqltype = "cf_sql_datetime">
            WHERE PkProductId = <cfqueryparam value = "#url.PkProductId#" cfsqltype = "cf_sql_integer">
        </cfquery>
    <cfelse>
        <!--- <cfdump var="#form#" abort="true"> --->
        <cfquery result="addProductData">
            INSERT INTO product (
                productName
                , FkCategoryId
                , productPrice
                , productQty
                , isActive
                , createdBy
                , dateCreated
            ) VALUES (
                <cfqueryparam value = "#form.productName#" cfsqltype = "cf_sql_varchar">
                , <cfqueryparam value = "#form.category#" cfsqltype = "cf_sql_integer">
                ,  <cfqueryparam value = "#form.productPrice#" cfsqltype = "cf_sql_float">
                , <cfqueryparam value = "#form.productQty#" cfsqltype = "cf_sql_integer">
                , <cfqueryparam value = "#isActive#" cfsqltype = "cf_sql_bit">
                , <cfqueryparam value = "#session.user.isLoggedIn#" cfsqltype = "cf_sql_integer">
                , <cfqueryparam value = "#now()#" cfsqltype = "cf_sql_datetime">
            )
        </cfquery>
        <cfset productId = addProductData.generatedKey>
    </cfif>
    <cfif structKeyExists(form, "productImage") AND len(form.productImage) GT 0>
        <cfset txtproductImage = "">
        <cfset productImagePath = ExpandPath('./assets/productImage/')>
        <cffile action="upload" destination="#productImagePath#" fileField="productImage"  nameconflict="makeunique" result="dataImage">
        <cfset txtproductImage = dataImage.serverfile>

        <cfquery name="qryGetImageName">
            SELECT productImage
            FROM product
            WHERE PkProductId = <cfqueryparam value="#productId#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfif qryGetImageName.recordCount EQ 1 AND len(qryGetImageName.productImage) GT 0>
            <cfif fileExists("#productImagePath##productImage#")>
                <cffile action="delete" file="#productImagePath##productImage#">
            </cfif>
        </cfif>
        <cfif len(txtproductImage) GT 0>
            <cfquery name="qryProductUpdateImg" result="qryResultProductUpdateImg">
                UPDATE product SET
                productImage = <cfqueryparam value="#txtproductImage#">
                WHERE PkProductId = <cfqueryparam value="#productId#" cfsqltype="cf_sql_integer">
            </cfquery>
        </cfif>
    </cfif>
</cfif>
<cfif structKeyExists(url, "statusId") AND url.statusId GT 0>
    <cfquery name="changeStatus">
        UPDATE product SET
        isActive = !isActive
        WHERE PkProductId = <cfqueryparam value = "#url.statusId#" cfsqltype = "cf_sql_integer">
    </cfquery>
</cfif>

<cfif structKeyExists(url, "formAction") AND url.formAction EQ 'getCategory'>
    <cfset data['categoryList'] = getCategoryResult(0,"",[])>
    <!--- <cfset data = serializeJson(res) /> --->
    <!--- <cfoutput>#serializeJson(res)#</cfoutput> --->
    <!--- <cfdump var="#res#" abort="true"> --->
</cfif>

<cfif structKeyExists(url, 'delPkProductId') AND url.delPkProductId GT 0>
        <cfquery name="removeImage">
            SELECT PkProductId, productImage FROM product 
            WHERE PkProductId = <cfqueryparam value="#url.delPkProductId#" cfsqltype = "cf_sql_integer">
        </cfquery>

        <cfif fileExists("#ExpandPath('./assets/productImage/')##removeImage.productImage#")>
            <cffile action="delete" file="#ExpandPath('./assets/productImage/')##removeImage.productImage#">
        </cfif>
        <cfquery result="deleteProductData">
            UPDATE product SET
            isDeleted = <cfqueryparam value="1" cfsqltype = "cf_sql_integer">
            WHERE PkProductId = <cfqueryparam value="#url.delPkProductId#" cfsqltype = "cf_sql_integer">
        </cfquery>
    </cfif>
<cfset output = serializeJson(data) />
<cfoutput>#rereplace(output,'//','')#</cfoutput>