<!--- <cfheader statuscode="200" statustext="OK" />
<cfcontent reset="true" type="application/json" /> --->

<cfparam name="PkCategoryId" default="" />
<cfparam name="categoryName" default="" />
<cfparam name="categoryImage" default="" />
<!---  <cfdump var="#form#">
<cfdump var="#url.PkCategoryId#"><cfabort> --->

<cfif structKeyExists(url, "PkCategoryId") AND url.PkCategoryId GT 0>
    <cfquery name="editCategoryData">
        SELECT PkCategoryId, categoryName, categoryImage FROM category WHERE PkCategoryId = <cfqueryparam value="#PkCategoryId#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfset PkCategoryId = editCategoryData.PkCategoryId>
    <cfset categoryName = editCategoryData.categoryName>
    <cfset categoryImage = editCategoryData.categoryImage>
    <cfoutput>
        
    </cfoutput>
</cfif>

<cfif structKeyExists(form, "categoryName") AND len(form.categoryName )GT 0>

    <cfif structKeyExists(form, "categoryImage") AND len(form.categoryImage) GT 0>
        <cfset txtcategoryImage = "">
        <cfset categoryImagePath = ExpandPath('./assets/categoryImage/')>

        <cffile action="upload" destination="#categoryImagePath#" fileField="form.categoryImage" nameconflict="makeunique" result="dataImage">
        <cfset txtcategoryImage = dataImage.serverfile>

        <cfif fileExists("#categoryImagePath##categoryImage#")>
            <cffile action="delete" file="#categoryImagePath##categoryImage#">
        </cfif>
    <cfelse>
        <cfset txtcategoryImage = "">
    </cfif>
    
    <cfif structKeyExists(url, "PkCategoryId") AND url.PkCategoryId GT 0>
        <cfquery name="updateCategoryData">
            UPDATE category SET                            
            PkCategoryId = <cfqueryparam value = "#form.PkCategoryId#" cfsqltype = "cf_sql_integer">
            , categoryName = <cfqueryparam value = "#form.categoryName#" cfsqltype = "cf_sql_varchar">
            , categoryImage = <cfqueryparam value = "#txtcategoryImage#" cfsqltype = "cf_sql_varchar">
            , updatedBy =  <cfqueryparam value = "#session.user.isLoggedIn#" cfsqltype = "cf_sql_integer">
            WHERE PkCategoryId = <cfqueryparam value = "#form.PkCategoryId#" cfsqltype = "cf_sql_integer">
        </cfquery> 
        <cfset session.user.categoryUpdate = 1>
        <!--- <cflocation url="index.cfm?pg=category&s=categoryList" addtoken="false"> --->
    <cfelse>
        <cfquery result="addCategoryData">
            INSERT INTO category (
                PkCategoryId
                , categoryName
                , categoryImage
                , createdBy
            ) VALUES (
                <cfqueryparam value = "#form.PkCategoryId#" cfsqltype = "cf_sql_integer">
                , <cfqueryparam value = "#form.categoryName#" cfsqltype = "cf_sql_varchar">
                , <cfqueryparam value = "#txtcategoryImage#" cfsqltype = "cf_sql_varchar">
                , <cfqueryparam value = "#session.user.isLoggedIn#" cfsqltype = "cf_sql_integer">
            )
        </cfquery>
        <cfset session.user.categorySave = 1>
        <!--- <cflocation url="index.cfm?pg=category&s=categoryList" addtoken="false"> --->
    </cfif> 
</cfif>