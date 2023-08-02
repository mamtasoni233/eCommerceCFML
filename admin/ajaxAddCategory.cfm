
<cfsetting enablecfoutputonly="true" showdebugoutput="false" />
<cfheader statuscode="200" statustext="OK" />
<cfcontent reset="true" type="application/json" />

<cfparam name="PkCategoryId" default="" />
<cfparam name="categoryName" default="" />
<cfparam name="categoryImage" default="" />
<cfparam name="parentCategory" default="" />
<cfparam name="showCatecgory" default="" />
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
<cfset categoryImagePath = ExpandPath('./assets/categoryImage/')>

<cfif structKeyExists(url, "formAction") AND url.formAction EQ "getRecord">
    <!--- <cfdump var="#form#" abort="true"> --->
    <cfquery name="getCategoryDataRows">
        SELECT C1.PkCategoryId, C1.categoryName, C1.parentCategoryId, C1.categoryImage, C1.isActive, C1.createdBy, C1.updatedBy, C1.dateCreated, C1.dateUpdated, C1.isDeleted, U.PkUserId, CONCAT_WS(" ", U.firstName, U.lastName) AS userName, CONCAT_WS(" ", userUpdate.firstName, userUpdate.lastName) AS userNameUpdate, C2.categoryName AS parentCategoryName
        FROM category C1
        LEFT JOIN category C2 ON C1.parentCategoryId = C2.PkCategoryId
        LEFT JOIN users U ON C1.createdBy = U.PkUserId
        LEFT JOIN users userUpdate ON C1.updatedBy = userUpdate.PkUserId
        WHERE  C1.isDeleted = <cfqueryparam value="#form.showCatecgory#" cfsqltype = "cf_sql_integer">
        <cfif structKeyExists(form, "search") AND len(form.search) GT 0>
            AND ( U.firstName LIKE <cfqueryparam value="%#trim(search)#%"> 
                    OR U.lastName LIKE <cfqueryparam value="%#trim(search)#%"> 
                    OR C1.categoryName LIKE <cfqueryparam value="%#trim(search)#%">
                    OR C2.categoryName LIKE <cfqueryparam value="%#trim(search)#%">
                    OR CONCAT_WS(' ', U.firstName, U.lastName) LIKE <cfqueryparam value="%#trim(search)#%">
                    OR CONCAT_WS(' ', userUpdate.firstName, userUpdate.lastName) LIKE <cfqueryparam value="%#trim(search)#%">
                )
        </cfif>
        <cfif structKeyExists(form, "order") AND len(form.order) GT 0>
            ORDER BY #form.order#
        </cfif>
    </cfquery>
    <cfquery name="getCategoryData">
        SELECT C1.PkCategoryId, C1.categoryName, C1.parentCategoryId, C1.categoryImage, C1.isActive, C1.createdBy, C1.updatedBy, C1.dateCreated, C1.dateUpdated, C1.isDeleted, U.PkUserId, CONCAT_WS(" ", U.firstName, U.lastName) AS userName, CONCAT_WS(" ", userUpdate.firstName, userUpdate.lastName) AS userNameUpdate, C2.categoryName AS parentCategoryName
        FROM category C1
        LEFT JOIN category C2 ON C1.parentCategoryId = C2.PkCategoryId
        LEFT JOIN users U ON C1.createdBy = U.PkUserId
        LEFT JOIN users userUpdate ON C1.updatedBy = userUpdate.PkUserId
        WHERE  C1.isDeleted = <cfqueryparam value="#form.showCatecgory#" cfsqltype = "cf_sql_integer">
        <cfif structKeyExists(form, "search") AND len(form.search) GT 0>
            AND ( U.firstName LIKE <cfqueryparam value="%#trim(search)#%"> 
                    OR U.lastName LIKE <cfqueryparam value="%#trim(search)#%"> 
                    OR C1.categoryName LIKE <cfqueryparam value="%#trim(search)#%">
                    OR C2.categoryName LIKE <cfqueryparam value="%#trim(search)#%">
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
    <cfset data['recordsFiltered'] = getCategoryDataRows.recordCount>
    <cfset data['draw'] = form.draw>
    <cfset data['recordsTotal'] = getCategoryDataRows.recordCount>
    <cfloop query="getCategoryData">
        <cfset dataRecord = {}>

        <cfset dataRecord['PkCategoryId'] = getCategoryData.PkCategoryId>
        <cfset dataRecord['parentCategoryName'] = getCategoryData.parentCategoryName>
        <cfset dataRecord['parentCategoryId'] = getCategoryData.parentCategoryId>
        <cfset dataRecord['categoryName'] = getCategoryData.categoryName>
        <cfset dataRecord['categoryImage'] = getCategoryData.categoryImage>
        <cfset dataRecord['isActive'] = getCategoryData.isActive>
        <cfset dataRecord['createdBy'] = getCategoryData.createdBy>
        <cfset dataRecord['dateCreated'] = dateTimeFormat(getCategoryData.dateCreated, 'dd-mm-yyyy hh:nn:ss tt')>
        <cfset dataRecord['dateUpdated'] = dateTimeFormat(getCategoryData.dateUpdated, 'dd-mm-yyyy hh:nn:ss tt')>
        <cfset dataRecord['updatedBy'] = getCategoryData.updatedBy>
        <cfset dataRecord['PkUserId'] = getCategoryData.PkUserId>
        <cfset dataRecord['userName'] = getCategoryData.userName>
        <cfset dataRecord['userNameUpdate'] = getCategoryData.userNameUpdate>
        <cfset arrayAppend(data['data'], dataRecord)>
    </cfloop>
</cfif>

<cfif structKeyExists(url, "PkCategoryId") AND url.PkCategoryId GT 0>
    <cfquery name="editCategoryData">
        SELECT PkCategoryId, categoryName, categoryImage, isActive, parentCategoryId
        FROM category 
        WHERE PkCategoryId = <cfqueryparam value="#PkCategoryId#" cfsqltype="cf_sql_integer">
    </cfquery>

    <cfset data['json'] = {}>
    <cfset data['json']['PkCategoryId'] = editCategoryData.PkCategoryId>
    <cfset data['json']['parentCategoryId'] = editCategoryData.parentCategoryId>
    <cfset data['json']['categoryName'] = editCategoryData.categoryName>
    <cfset data['json']['categoryImage'] = editCategoryData.categoryImage>
    <cfset data['json']['isActive'] = editCategoryData.isActive>
</cfif>


<cfif structKeyExists(form, "categoryName") AND len(form.categoryName) GT 0>
    <cfif NOT structKeyExists(form, "isActive")>
        <cfset isActive = 0>
    <cfelse>
        <cfset isActive = form.isActive>
    </cfif>
    <cfset catId = 0>

    <cfif structKeyExists(url, "PkCategoryId") AND url.PkCategoryId GT 0>
        <cfset catId = url.PkCategoryId>
        <cfquery name="updateCategoryData">
            UPDATE category SET
            categoryName = <cfqueryparam value = "#form.categoryName#" cfsqltype = "cf_sql_varchar">
            , parentCategoryId =  <cfqueryparam value = "#form.parentCategory#" cfsqltype = "cf_sql_integer">
            , isActive = <cfqueryparam value = "#isActive#" cfsqltype = "cf_sql_bit">
            , updatedBy =  <cfqueryparam value = "#session.user.isLoggedIn#" cfsqltype = "cf_sql_integer">
            , dateUpdated =  <cfqueryparam value = "#now()#" cfsqltype = "cf_sql_datetime">
            WHERE PkCategoryId = <cfqueryparam value = "#url.PkCategoryId#" cfsqltype = "cf_sql_integer">
        </cfquery>
    <cfelse>
        <cfquery result="addCategoryData">
            INSERT INTO category (
                categoryName
                , parentCategoryId
                , isActive
                , createdBy
                , dateCreated
            ) VALUES (
                <cfqueryparam value = "#form.categoryName#" cfsqltype = "cf_sql_varchar">
                , <cfqueryparam value = "#form.parentCategory#" cfsqltype = "cf_sql_integer">
                , <cfqueryparam value = "#isActive#" cfsqltype = "cf_sql_bit">
                , <cfqueryparam value = "#session.user.isLoggedIn#" cfsqltype = "cf_sql_integer">
                , <cfqueryparam value = "#now()#" cfsqltype = "cf_sql_datetime">
            )
        </cfquery>
        <cfset catId = addCategoryData.generatedKey>
    </cfif>
    <cfif structKeyExists(form, "categoryImage") AND len(form.categoryImage) GT 0>
        <cfset txtcategoryImage = "">
        <cffile action="upload" destination="#categoryImagePath#" fileField="categoryImage"  nameconflict="makeunique" result="dataImage">
        <cfset txtcategoryImage = dataImage.serverfile>
        <cfquery name="qryGetImageName">
            SELECT categoryImage
            FROM category
            WHERE PkCategoryId = <cfqueryparam value="#catId#" cfsqltype="cf_sql_integer">
        </cfquery>
        
        <cfif qryGetImageName.recordCount EQ 1 AND len(qryGetImageName.categoryImage) GT 0>
            <cfif fileExists("#categoryImagePath##categoryImage#")>
                <cffile action="delete" file="#categoryImagePath##categoryImage#">
            </cfif>
        </cfif>
        <cfif len(txtcategoryImage) GT 0>
            <cfquery name="qryCategoryUpdateImg" result="qryResultCategoryUpdateImg">
                UPDATE category SET
                categoryImage = <cfqueryparam value="#txtcategoryImage#" cfsqltype = "cf_sql_varchar">
                WHERE PkCategoryId = <cfqueryparam value="#catId#" cfsqltype="cf_sql_integer">
            </cfquery>
        </cfif>
    </cfif>
    <cfif structKeyExists(form, "removeImage")>
        <cfif fileExists("#categoryImagePath##categoryImage#")>
            <cffile action="delete" file="#categoryImagePath##categoryImage#">
        </cfif>
        <cfquery name="qryRemoveImage">
            UPDATE category SET 
            categoryImage = <cfqueryparam value = "" cfsqltype = "cf_sql_varchar">
            WHERE PkCategoryId = <cfqueryparam value="#catId#" cfsqltype="cf_sql_integer">
        </cfquery>
    </cfif>
</cfif>

<cfif structKeyExists(url, "statusId") AND url.statusId GT 0>
    <cfquery name="changeStatus">
        UPDATE category SET
        isActive = !isActive
        WHERE PkCategoryId = <cfqueryparam value = "#url.statusId#" cfsqltype = "cf_sql_integer">
    </cfquery>
</cfif>
<cfif structKeyExists(url, "formAction") AND url.formAction EQ 'getCategory'>
    <cfquery name="getCategory">
        SELECT categoryName, PkCategoryId FROM Category 
        WHERE 
            parentCategoryId = <cfqueryparam value="0" cfsqltype="cf_sql_integer"> 
            AND isDeleted = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfset data['data'] = []>
    <cfloop query="getCategory">
        <cfset dataRecord = {}>
        <cfset dataRecord['PkCategoryId'] = getCategory.PkCategoryId>
        <cfset dataRecord['categoryName'] = getCategory.categoryName>
        <cfset arrayAppend(data['data'], dataRecord)>
    </cfloop>
</cfif>
<cfif structKeyExists(url, 'delPkCategoryId') AND url.delPkCategoryId GT 0>
        <cfquery name="removeImage">
            SELECT PkCategoryId, categoryImage FROM Category 
            WHERE PkCategoryId = <cfqueryparam value="#url.delPkCategoryId#" cfsqltype = "cf_sql_integer">
        </cfquery>
        <cfif fileExists("#ExpandPath('./assets/categoryImage/')##removeImage.categoryImage#")>
            <cffile action="delete" file="#ExpandPath('./assets/categoryImage/')##removeImage.categoryImage#">
        </cfif>
        <cfquery result="deleteCategoryData">
            UPDATE category SET
            isDeleted = <cfqueryparam value="1" cfsqltype = "cf_sql_integer">
            WHERE PkCategoryId = <cfqueryparam value="#url.delPkCategoryId#" cfsqltype = "cf_sql_integer">
        </cfquery>
        <cfquery result="deleteParentCategoryData">
            UPDATE category SET
            isDeleted = <cfqueryparam value="1" cfsqltype = "cf_sql_integer">
            WHERE parentCategoryId = <cfqueryparam value="#url.delPkCategoryId#" cfsqltype = "cf_sql_integer">
        </cfquery>
</cfif>

<cfset output = serializeJson(data) />
<cfoutput>#rereplace(output,'//','')#</cfoutput>