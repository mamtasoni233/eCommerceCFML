<!--- <cffunction name="getCategoryResult" access="public" returntype="array">
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


<cfset categoryList = getCategoryResult(0,"",[])> --->

<cffunction name="getCategoryResult" access="public" returntype="array">
    <cfargument name="parentId" default="0" required="false" type="numeric"/>
    <cfargument name="categoryId" default="0" required="false" type="numeric"/>
    <cfargument name="returnArray" required="false" type="array" default="#arrayNew(1)#"/>

    <cfset var qryGetCategory = "">
    <cfquery name="qryGetCategory">
        SELECT categoryName, PkCategoryId, parentCategoryId, categoryImage 
        FROM Category
        WHERE 1 = 1
        <cfif arguments.categoryId GT 0>
            AND PkCategoryId = <cfqueryparam value="#arguments.categoryId#" cfsqltype="cf_sql_integer">
        <cfelse>
            AND parentCategoryId = <cfqueryparam value="#arguments.parentId#" cfsqltype="cf_sql_integer">
        </cfif>
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
            <cfquery name="countProduct">
                SELECT COUNT(P.PkProductId) AS productCount
                FROM product P
                WHERE P.isDeleted = <cfqueryparam value="0" cfsqltype = "cf_sql_integer">
                AND P.FkCategoryId = <cfqueryparam value="#res['PkCategoryId']#" cfsqltype = "cf_sql_integer">
            </cfquery>
            <cfset res['productCount'] = countProduct.productCount>
            <cfset arrayAppend(arguments.returnArray, res)> 
        </cfloop>
    </cfif>
    <cfreturn arguments.returnArray>
</cffunction>

<cfquery name="qryGetSecLevelCat">
    SELECT C.parentCategoryId, B.parentCategoryId AS seclevelCat
    FROM category C, category B
    WHERE C.PkCategoryId = <cfqueryparam value="18" cfsqltype = "cf_sql_integer">
    AND B.PkCategoryId = C.parentCategoryId
</cfquery>
<cfset categoryList = getCategoryResult(qryGetSecLevelCat.seclevelCat, qryGetSecLevelCat.parentCategoryId)>
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


SELECT
    (
    SELECT
        CASE WHEN o.shipping = 'free' THEN SUM(oisub.totalCost)
            WHEN o.shipping = 'nextDay' THEN SUM(oisub.totalCost) + 50.00
            WHEN o.shipping = 'courier' THEN SUM(oisub.totalCost) + 100.00
        END
    FROM order_item oisub
    WHERE oisub.FkOrderId = O.PkOrderId
) AS 'totalAmt',
O.PkOrderId,
O.firstName,
O.lastName,
O.FkCustomerId,
O.shipping,
O.status,
O.createdBy,
O.updatedBy,
O.createdDate,
O.updatedDate,
C.PkCustomerId,
CONCAT_WS(" ", O.firstName, O.lastName) AS customerName,
userUpdate.PkUserId,
CONCAT_WS(
    " ",
    userUpdate.firstName,
    userUpdate.lastName
) AS userNameUpdate
FROM
    orders O
LEFT JOIN customer C ON
    O.createdBy = C.PkCustomerId
LEFT JOIN users userUpdate ON
    O.updatedBy = userUpdate.PkUserId;