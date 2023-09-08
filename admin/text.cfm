<cffunction name="getCategoryResult" access="public" returntype="array">
        <cfargument name="parentId" default="0" required="true" type="any"/>
        <cfargument name="parentName" required="true" type="any"/>
        <cfargument name="returnArray" required="true" type="any"/>
        <!--- <cfargument name="label" default="1" required="true" type="numeric"/> --->

        <cfset var qryGetCategory = "">
        <cfquery name="qryGetCategory">
            SELECT categoryName, PkCategoryId, parentCategoryId FROM Category 
            WHERE parentCategoryId =  <cfqueryparam value="#arguments.parentId#" cfsqltype="cf_sql_integer">
            AND isDeleted = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
        </cfquery>
        <!--- <cfdump var="#qryGetCategory#"> --->
        <cfif qryGetCategory.recordCount GT 0>
            <cfloop query="qryGetCategory">
                <cfset var res = StructNew()>
                <cfset res['catName'] = qryGetCategory.categoryName>
                <cfset res['PkCategoryId'] = qryGetCategory.PkCategoryId>
                <cfset res['parentCategoryId'] = qryGetCategory.parentCategoryId>
                <!--- <cfset res['label'] = arguments.label> --->
                <cfif len(arguments.parentName) GT 0>
                    <cfset res['catName']  = arguments.parentName & ' -> ' & qryGetCategory.categoryName>
                </cfif>       
                <!--- <cfif myArra EQ 1> --->
                    <!--- <cfset label = arguments.label + 2>
                    <cfif arguments.label EQ label>
                        <cfset arrayAppend(arguments.returnArray, res)> 
                    </cfif> --->
                    
                    <cfset myList = getCategoryResult(qryGetCategory.PkCategoryId, res['catName'], arguments.returnArray)>
                    <!--- <cfdump var="#myList#">  --->       
                    <cfset myArray = listToArray(res['catName'],"->", true, false)>
                    <cfdump var="#myArray#">
                    <cfset arrayAppend(arguments.returnArray, res)> 
                <!--- </cfif> --->
                <!--- <cfset getCategoryResult(qryGetCategory.PkCategoryId, res['catName'], ListToArray(arguments.returnArray," -> ", true, false))> --->
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
