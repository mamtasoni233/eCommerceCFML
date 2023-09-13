<cfsetting enablecfoutputonly="true" showdebugoutput="false" />
<cfheader statuscode="200" statustext="OK" />
<cfcontent reset="true" type="application/json" />

<cfparam name="PkProductId" default="" />
<cfparam name="FkCategoryId" default="" />
<cfparam name="productName" default="" />
<cfparam name="productQty" default="" />
<cfparam name="productImage" default="" />
<cfparam name="productPrice" default="" />
<cfparam name="productDescription" default="" />
<cfparam name="showProduct" default="" />
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
<cfset productImagePath = ExpandPath('./assets/productImage/')>

<cfif structKeyExists(url, "formAction") AND url.formAction EQ "getRecord">
    <cfquery name="getProductDataRows">
        SELECT C.PkCategoryId, C.categoryName, P.PkProductId, P.productQty, P.productName, P.productPrice, P.isActive, P.createdBy, P.updatedBy, P.dateCreated, P.dateUpdated, P.isDeleted, P.productDescription, U.PkUserId, CONCAT_WS(" ", U.firstName, U.lastName) AS userName, CONCAT_WS(" ", userUpdate.firstName, userUpdate.lastName) AS userNameUpdate
        FROM product P
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
                    OR P.productName LIKE <cfqueryparam value="%#trim(search)#%">
                    OR P.productPrice LIKE <cfqueryparam value="%#trim(search)#%">
                    OR P.productQty LIKE <cfqueryparam value="%#trim(search)#%">
                    OR P.productDescription LIKE <cfqueryparam value="%#trim(search)#%">
                )
        </cfif>
        <cfif structKeyExists(form, "order") AND len(form.order) GT 0>
            ORDER BY #form.order#
        </cfif>
    </cfquery>
    <cfquery name="getProductData">
        SELECT C.PkCategoryId, C.categoryName, P.PkProductId, P.productName,P.productQty, P.productPrice, P.isActive, P.createdBy, P.updatedBy, P.dateCreated, P.dateUpdated, P.isDeleted, P.productDescription, U.PkUserId, CONCAT_WS(" ", U.firstName, U.lastName) AS userName, CONCAT_WS(" ", userUpdate.firstName, userUpdate.lastName) AS userNameUpdate
        FROM product P
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
                    OR P.productName LIKE <cfqueryparam value="%#trim(search)#%">
                    OR P.productPrice LIKE <cfqueryparam value="%#trim(search)#%">
                    OR P.productQty LIKE <cfqueryparam value="%#trim(search)#%">
                    OR P.productDescription LIKE <cfqueryparam value="%#trim(search)#%">
                )
        </cfif>
        <cfif structKeyExists(form, "order") AND len(form.order) GT 0>
            ORDER BY #form.order#
        </cfif>
        LIMIT #form.start#, #form.length#
        
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
        <cfset dataRecord['productDescription'] = getProductData.productDescription>
        <cfset dataRecord['isActive'] = getProductData.isActive>
        <cfset dataRecord['isDeleted'] = getProductData.isDeleted>
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
    <cfquery name="editProductData">
        SELECT P.PkProductId, P.productName, P.productPrice,productQty, P.productDescription, P.isActive, P.FkCategoryId, PI.isDefault
        FROM product P LEFT JOIN product_image PI ON P.PkProductId = PI.FkProductId
        WHERE PkProductId = <cfqueryparam value="#PkProductId#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfset data['json'] = {}>
    <cfset data['json']['PkProductId'] = editProductData.PkProductId>
    <cfset data['json']['FkCategoryId'] = editProductData.FkCategoryId>
    <cfset data['json']['productName'] = editProductData.productName>
    <cfset data['json']['productPrice'] = editProductData.productPrice>
    <cfset data['json']['productQty'] = editProductData.productQty>
    <cfset data['json']['productDescription'] = editProductData.productDescription>
    <cfset data['json']['isActive'] = editProductData.isActive>
    <cfset data['json']['isDefault'] = editProductData.isDefault>
</cfif>


<cfif structKeyExists(form, "productName") AND len(trim(form.productName)) GT 0>
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
            , productDescription =  <cfqueryparam value = "#form.productDescription#" cfsqltype = "cf_sql_text">
            , isActive = <cfqueryparam value = "#isActive#" cfsqltype = "cf_sql_bit">
            , updatedBy =  <cfqueryparam value = "#session.user.isLoggedIn#" cfsqltype = "cf_sql_integer">
            , dateUpdated =  <cfqueryparam value = "#now()#" cfsqltype = "cf_sql_datetime">
            WHERE PkProductId = <cfqueryparam value = "#url.PkProductId#" cfsqltype = "cf_sql_integer">
        </cfquery>
        
    <cfelse>
        <cfquery result="addProductData">
            INSERT INTO product (
                productName
                , FkCategoryId
                , productPrice
                , productQty
                , productDescription
                , isActive
                , createdBy
                , dateCreated
            ) VALUES (
                <cfqueryparam value = "#form.productName#" cfsqltype = "cf_sql_varchar">
                , <cfqueryparam value = "#form.category#" cfsqltype = "cf_sql_integer">
                ,  <cfqueryparam value = "#form.productPrice#" cfsqltype = "cf_sql_float">
                , <cfqueryparam value = "#form.productQty#" cfsqltype = "cf_sql_integer">
                , <cfqueryparam value = "#form.productDescription#" cfsqltype = "cf_sql_text">
                , <cfqueryparam value = "#isActive#" cfsqltype = "cf_sql_bit">
                , <cfqueryparam value = "#session.user.isLoggedIn#" cfsqltype = "cf_sql_integer">
                , <cfqueryparam value = "#now()#" cfsqltype = "cf_sql_datetime">
            )
        </cfquery>
        <cfset productId = addProductData.generatedKey>
    </cfif>
    <cfif structKeyExists(form, "filepond") AND arrayLen(form.filepond) GT 0>
        <cfloop array="#form.filepond#" index="i">
            <cfset txtproductImage = "">
            <cffile action="upload" destination="#productImagePath#" fileField="#i#"  nameconflict="makeunique" result="dataImage">
            <cfset txtproductImage = dataImage.serverfile>
            <cfquery name="getImage">
                SELECT PkImageId, image, isDefault FROM product_image 
                WHERE FkProductId = <cfqueryparam value="#productId#" cfsqltype = "cf_sql_integer">
            </cfquery>
            <cfif len(txtproductImage)  GT 0>
                <cfquery name="qryProductUpdateImg" result="qryResultProductUpdateImg">
                    INSERT INTO product_image (
                        image
                        , FkProductId
                        , createdBy
                        , dateCreated
                    ) VALUES (
                        <cfqueryparam value="#txtproductImage#">
                        , <cfqueryparam value = "#productId#" cfsqltype = "cf_sql_varchar">
                        , <cfqueryparam value = "#session.user.isLoggedIn#" cfsqltype = "cf_sql_integer">
                        , <cfqueryparam value = "#now()#" cfsqltype = "cf_sql_datetime">
                    )
                </cfquery>
            </cfif>
        </cfloop>
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
</cfif>

<cfif structKeyExists(url, 'delPkProductId') AND url.delPkProductId GT 0>
    <cfquery name="removeImage">
        SELECT PkImageId, image FROM product_image 
        WHERE FkProductId = <cfqueryparam value="#url.delPkProductId#" cfsqltype = "cf_sql_integer">
    </cfquery>

    <cfloop query="removeImage">
        <cfif fileExists("#productImagePath##removeImage.image#")>
            <cffile action="delete" file="#productImagePath##removeImage.image#">
        </cfif>
    </cfloop>
    <cfquery result="deleteProductData">
        UPDATE product SET
        isDeleted = <cfqueryparam value="1" cfsqltype = "cf_sql_integer">
        WHERE PkProductId IN(<cfqueryparam value="#url.delPkProductId#" list="true">)
    </cfquery>
</cfif>
<cfif structKeyExists(url, "formAction") AND url.formAction EQ "getProductImageRecord">
    <cfquery name="getProductImageDataRows">
        SELECT P.PkProductId, P.productName, PI.PkImageId, PI.FkProductId, PI.image, PI.isDefault, PI.createdBy, PI.dateCreated, U.PkUserId, CONCAT_WS(" ", U.firstName, U.lastName) AS userName
        FROM product_image PI
        LEFT JOIN product P ON PI.FkProductId = P.PkProductId
        LEFT JOIN users U ON PI.createdBy = U.PkUserId
        WHERE PI.FkProductId = <cfqueryparam value="#form.FkProductId#" cfsqltype = "cf_sql_integer">
        
        <cfif structKeyExists(form, "order") AND len(form.order) GT 0>
            ORDER BY #form.order#
        </cfif>
    </cfquery>
    <cfquery name="getProductImageData">
        SELECT P.PkProductId, P.productName, PI.PkImageId, PI.FkProductId, PI.image, PI.isActive, PI.isDefault, PI.createdBy, PI.dateCreated, U.PkUserId, CONCAT_WS(" ", U.firstName, U.lastName) AS userName
        FROM product_image PI
        LEFT JOIN product P ON PI.FkProductId = P.PkProductId
        LEFT JOIN users U ON P.createdBy = U.PkUserId
        WHERE PI.FkProductId = <cfqueryparam value="#form.FkProductId#" cfsqltype = "cf_sql_integer">
        <cfif structKeyExists(form, "order") AND len(form.order) GT 0>
            ORDER BY #form.order#
        </cfif>
        LIMIT #form.start#, #form.length#
    </cfquery>
    <cfset data['data'] = []>
    <cfset data['recordsFiltered'] = getProductImageDataRows.recordCount>
    <cfset data['draw'] = form.draw>
    <cfset data['recordsTotal'] = getProductImageDataRows.recordCount>
    <cfloop query="getProductImageData">
        <cfset dataRecord = {}>

        <cfset dataRecord['PkProductId'] = getProductImageData.PkProductId>
        <cfset dataRecord['PkImageId'] = getProductImageData.PkImageId>
        <cfset dataRecord['productName'] = getProductImageData.productName>
        <cfset dataRecord['image'] = getProductImageData.image>
        <cfset dataRecord['isActive'] = getProductImageData.isActive>
        <cfset dataRecord['isDefault'] = getProductImageData.isDefault>
        <cfset dataRecord['createdBy'] = getProductImageData.createdBy>
        <cfset dataRecord['dateCreated'] = dateTimeFormat(getProductImageData.dateCreated, 'dd-mm-yyyy hh:nn:ss tt')>
        <cfset dataRecord['PkUserId'] = getProductImageData.PkUserId>
        <cfset dataRecord['userName'] = getProductImageData.userName>
        <cfset dataRecord['sNo'] = 1>
        <cfset arrayAppend(data['data'], dataRecord)>
    </cfloop>
</cfif>
<cfif structKeyExists(url, 'delPkImageId') AND url.delPkImageId GT 0>
    <cfquery name="removeImage">
        SELECT PkImageId, image FROM product_image 
        WHERE PkImageId = <cfqueryparam value="#url.delPkImageId#" cfsqltype = "cf_sql_integer">
    </cfquery>

    <cfif fileExists("#productImagePath##removeImage.image#")>
        <cffile action="delete" file="#productImagePath##removeImage.image#">
    </cfif>
    <cfquery result="deleteProductData">
        DELETE FROM product_image WHERE
        PkImageId = <cfqueryparam value="#url.delPkImageId#" cfsqltype = "cf_sql_integer">
    </cfquery>
</cfif>

<cfif structKeyExists(url, "defaultId") AND url.defaultId GT 0>
    <cfquery name="changeDefault">
        UPDATE product_image SET
        isDefault = <cfqueryparam value = "1" cfsqltype = "cf_sql_bit">
        WHERE PkImageId = <cfqueryparam value = "#url.defaultId#" cfsqltype = "cf_sql_integer">
    </cfquery>
    <cfquery name="changeDefaultValue">
        UPDATE product_image SET
        isDefault = <cfqueryparam value = "0" cfsqltype = "cf_sql_bit">
        WHERE PkImageId != <cfqueryparam value = "#url.defaultId#" cfsqltype = "cf_sql_integer">
    </cfquery>
</cfif>

<cfset output = serializeJson(data) />
<cfoutput>#rereplace(output,'//','')#</cfoutput>