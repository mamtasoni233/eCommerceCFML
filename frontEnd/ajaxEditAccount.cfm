<cfsetting enablecfoutputonly="true" showdebugoutput="false" />
<cfheader statuscode="200" statustext="OK" />
<cfcontent reset="true" type="application/json" />

<cfparam name="PkCustomerId" default="" />
<cfparam name="firstName" default="" />
<cfparam name="lastName" default="" />
<cfparam name="email" default="" />
<cfparam name="gender" default="" />
<cfparam name="dob" default="" />
<cfparam name="mobile" default="" />
<cfset bcrypt = application.bcrypt>
<cfset gensalt = bcrypt.gensalt()>
<cfparam name="password" default="" />
<cfparam name="createdBy" default="" />
<cfparam name="formAction" default="" />
<cfparam name="customerId" default="#session.customer.isLoggedIn#" />

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
<cftry>
    
    <cfif structKeyExists(url, "formAction") AND url.formAction EQ "editAccountDetail">
        <cfquery name="updatecustomerData">
            UPDATE customer SET
            firstName = <cfqueryparam value = "#form.firstName#" cfsqltype = "cf_sql_varchar">
            , lastName = <cfqueryparam value = "#form.lastName#" cfsqltype = "cf_sql_varchar">
            , email = <cfqueryparam value = "#form.email#" cfsqltype = "cf_sql_varchar">
            , mobile = <cfqueryparam value = "#form.mobile#" cfsqltype = "cf_sql_varchar">
            , updatedBy =  <cfqueryparam value = "#session.customer.isLoggedIn#" cfsqltype = "cf_sql_integer">
            , updatedDate =  <cfqueryparam value = "#CreateODBCDateTime(now())#" cfsqltype = "cf_sql_datetime">
            WHERE PkCustomerId = <cfqueryparam value = "#customerId#" cfsqltype = "cf_sql_integer">
            <cfset session.customer.customerUpdate = 1>
            <cflocation url="index.cfm?pg=account&s=editAccount" addtoken="false">
        </cfquery>
    </cfif>
	<cfif structKeyExists(url, "formAction") AND url.formAction EQ "changePassword">
		<cfquery name="getCustomerPassword">
			SELECT PkCustomerId, password FROM customer 
			WHERE PkCustomerId = <cfqueryparam value="#customerId#" cfsqltype="cf_sql_integer">
		</cfquery>
		<cfif getCustomerPassword.recordCount GT 0>
			<cfif structKeyExists(form, 'oldpassword') AND len(form.oldpassword) GT 0> 
				<cfset checkPassword = bcrypt.checkpw(form.oldpassword, getCustomerPassword.password)>
				<cfif checkPassword EQ true>
					<cfset hashPassword = bcrypt.hashpw(form.newPassword,gensalt)>
					<cfquery result="updatePassword">
						UPDATE customer SET  
						password = <cfqueryparam value="#hashPassword#" cfsqltype="cf_sql_varchar">
						WHERE PkCustomerId= <cfqueryparam value="#customerId#" cfsqltype="cf_sql_integer"> 
					</cfquery>
					<cfset session.customer.save = 6>
					<cflocation url="index.cfm?pg=account&s=changePassword" addtoken="false">
				<cfelse>
					<cfset session.customer.error = 2>
					<cflocation url="index.cfm?pg=account&s=changePassword" addtoken="false">
				</cfif>
			</cfif>

		</cfif>
	</cfif>
    <cfcatch>
        <cfset data['success'] = false>
        <cfset data['error'] = cfcatch>
    </cfcatch>
</cftry>
<cfset output =  serializeJSON(data)/>
<cfoutput>#output#</cfoutput>


