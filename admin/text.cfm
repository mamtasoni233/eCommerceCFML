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
                <cfif isArray(test) AND arrayLen(test) EQ 2>
                    <cfset arrayAppend(arguments.returnArray, res)>
                </cfif>
                <cfset getCategoryResult(qryGetCategory.PkCategoryId, res['catName'], arguments.returnArray)>
            </cfloop>
        </cfif>
        <cfreturn arguments.returnArray>
</cffunction>


<cfset categoryList = getCategoryResult(0,"",[])>
<!--- <cffunction name="getCategoryResult" access="public" returntype="array">
    <cfargument name="parentId" default="0" required="false" type="numeric"/>
    <cfargument name="returnArray" required="false" type="array" default="#arrayNew(1)#"/>

    <cfset var qryGetCategory = "">
    <cfquery name="qryGetCategory">
        SELECT categoryName, PkCategoryId, parentCategoryId, categoryImage FROM Category 
        WHERE parentCategoryId = <cfqueryparam value="#arguments.parentId#" cfsqltype="cf_sql_integer">
        AND isDeleted = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfif qryGetCategory.recordCount GT 0>
        <cfloop query="qryGetCategory">
            <cfset var res = StructNew()>
            <cfset res['child'] = []>
            <cfset res['catName'] = qryGetCategory.categoryName>
            <cfset res['PkCategoryId'] = qryGetCategory.PkCategoryId>
            <cfset res['parentCategoryId'] = qryGetCategory.parentCategoryId>
            <cfset res['categoryImage'] = qryGetCategory.categoryImage>
            <cfset res['child'] = getCategoryResult(res.PkCategoryId)>
            <cfset arrayAppend(arguments.returnArray, res)> 
        </cfloop>
    </cfif>
    <cfreturn arguments.returnArray>
</cffunction>
<cfset categoryList = getCategoryResult()> --->

<cfdump var="#categoryList#">
