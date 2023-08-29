<cfsetting enablecfoutputonly="true" showdebugoutput="false" />
<cfheader statuscode="200" statustext="OK" />
<cfcontent reset="true" type="application/json" />

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


<cffunction name="getParentCategoryResult" access="public" returntype="array">
        <cfargument name="parentId" required="true" type="any"/>
        <cfargument name="PkCategoryId" required="true" type="any"/>
        <cfargument name="parentName" required="true" type="any"/>
        <cfargument name="returnArray" required="true" type="any"/>

        <cfset var qryGetCategory = "">
        <cfquery name="qryGetCategory">
            SELECT categoryName, PkCategoryId FROM Category 
            WHERE parentCategoryId =  <cfqueryparam value="#arguments.parentId#" cfsqltype="cf_sql_integer">
            AND PkCategoryId != <cfqueryparam value="#arguments.PkCategoryId#" cfsqltype="cf_sql_integer"> 
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
                <cfset getParentCategoryResult(res.PkCategoryId, arguments.PkCategoryId, res.catName, arguments.returnArray)>
            </cfloop>
        </cfif>
        <cfreturn arguments.returnArray>
</cffunction>

<cfset data = {}>
<cfset data['success'] = true>