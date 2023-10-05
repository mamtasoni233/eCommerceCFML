<cfsetting enablecfoutputonly="true" showdebugoutput="false" />
<cfheader statuscode="200" statustext="OK" />
<cfcontent reset="true" type="application/json" />

<cfparam name="FkProductId" default="" />
<cfparam name="PkCartId" default="" />
<cfparam name="productPrice" default="" />
<cfparam name="productQty" default="" />
<cfparam name="FkCustomerId" default="" />
<cfparam name="isDeleted" default="0" />
<cfparam name="startRow" default="">
<cfparam name="pageNum" default="1">
<cfparam name="maxRows" default="9">
<cfset startRow = ( pageNum-1 ) * maxRows>

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
<cfset imagePath = "http://127.0.0.1:50847/assets/productImage/">
<cftry>
    <cfif structKeyExists(url, "ProductId") AND url.ProductId GT 0>
        <cfquery result="addToCartData">
            INSERT INTO cart (
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
    </cfif>
    <cfcatch>
        <cfset data['success'] = false>
        <cfset data['error'] = cfcatch>
    </cfcatch>
</cftry>
<cfset output =  serializeJSON(data)/>
<cfoutput>#output#</cfoutput>


