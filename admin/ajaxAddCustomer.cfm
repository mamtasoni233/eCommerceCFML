<cfsetting enablecfoutputonly="true" showdebugoutput="false" />
<cfheader statuscode="200" statustext="OK" />
<cfcontent reset="true" type="application/json" />

<cfparam name="PkCustomerId" default="" />
<cfparam name="firstName" default="" />
<cfparam name="lastName" default="" />
<cfparam name="email" default="" />
<cfparam name="gender" default="" />
<cfparam name="dob" default="" />
<cfset bcrypt = application.bcrypt>
<cfset gensalt = bcrypt.gensalt()>
<cfparam name="password" default="" />
<cfparam name="createdBy" default="" />
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
<cfset customerProfilePath = ExpandPath('./assets/customerProfile/')>

<cfif structKeyExists(url, "formAction") AND url.formAction EQ "getRecord">
    <cfquery name="getCustomerDataRows">
        SELECT C.PkCustomerId, C.firstName, C.lastName, C.email, C.gender, C.dob, C.isActive, C.isBlcoked, C.createdBy, C.updatedBy, C.createdDate, C.updatedDate, C.isDeleted, U.PkUserId, CONCAT_WS(" ", U.firstName, U.lastName) AS userName, CONCAT_WS(" ", userUpdate.firstName, userUpdate.lastName) AS userNameUpdate
        FROM customer C
        LEFT JOIN users U ON C.createdBy = U.PkUserId
        LEFT JOIN users userUpdate ON C.updatedBy = userUpdate.PkUserId
        WHERE  C.isDeleted = <cfqueryparam value="0" cfsqltype = "cf_sql_integer">
        <cfif structKeyExists(form, "search") AND len(form.search) GT 0>
            AND ( U.firstName LIKE <cfqueryparam value="%#trim(search)#%"> 
                    OR U.lastName LIKE <cfqueryparam value="%#trim(search)#%"> 
                    OR C.firstName LIKE <cfqueryparam value="%#trim(search)#%">
                    OR C.lastName LIKE <cfqueryparam value="%#trim(search)#%">
                    OR C.email LIKE <cfqueryparam value="%#trim(search)#%">
                    OR C.gender LIKE <cfqueryparam value="%#trim(search)#%">
                    OR C.dob LIKE <cfqueryparam value="%#trim(search)#%">
                    OR CONCAT_WS(' ', U.firstName, U.lastName) LIKE <cfqueryparam value="%#trim(search)#%">
                    OR CONCAT_WS(' ', userUpdate.firstName, userUpdate.lastName) LIKE <cfqueryparam value="%#trim(search)#%">
                )
        </cfif>
        <cfif structKeyExists(form, "order") AND len(form.order) GT 0>
            ORDER BY #form.order#
        </cfif>
    </cfquery>
    <cfquery name="getCustomerData">
        SELECT C.PkCustomerId, C.firstName, C.lastName, C.email, C.gender, C.dob, C.isActive, C.isBlcoked, C.createdBy, C.updatedBy, C.createdDate, C.updatedDate, C.isDeleted, U.PkUserId, CONCAT_WS(" ", U.firstName, U.lastName) AS userName, CONCAT_WS(" ", userUpdate.firstName, userUpdate.lastName) AS userNameUpdate
        FROM customer C
        LEFT JOIN users U ON C.createdBy = U.PkUserId
        LEFT JOIN users userUpdate ON C.updatedBy = userUpdate.PkUserId
        WHERE  C.isDeleted = <cfqueryparam value="0" cfsqltype = "cf_sql_integer">
        <cfif structKeyExists(form, "search") AND len(form.search) GT 0>
            AND ( U.firstName LIKE <cfqueryparam value="%#trim(search)#%"> 
                    OR U.lastName LIKE <cfqueryparam value="%#trim(search)#%"> 
                    OR C.firstName LIKE <cfqueryparam value="%#trim(search)#%">
                    OR C.lastName LIKE <cfqueryparam value="%#trim(search)#%">
                    OR C.email LIKE <cfqueryparam value="%#trim(search)#%">
                    OR C.gender LIKE <cfqueryparam value="%#trim(search)#%">
                    OR C.dob LIKE <cfqueryparam value="%#trim(search)#%">
                )
        </cfif>
        
        <cfif structKeyExists(form, "order") AND len(form.order) GT 0>
            ORDER BY #form.order#
        </cfif>
        LIMIT #form.start#, #form.length#
    </cfquery>
    <cfset data['data'] = []>
    <cfset data['recordsFiltered'] = getCustomerDataRows.recordCount>
    <cfset data['draw'] = form.draw>
    <cfset data['recordsTotal'] = getCustomerDataRows.recordCount>
    <cfloop query="getCustomerData">
        <cfset dataRecord = {}>

        <cfset dataRecord['PkCustomerId'] = getCustomerData.PkCustomerId>
        <cfset dataRecord['firstName'] = getCustomerData.firstName>
        <cfset dataRecord['lastName'] = getCustomerData.lastName>
        <cfset dataRecord['email'] = getCustomerData.email>
        <cfset dataRecord['gender'] = getCustomerData.gender>
        <cfset dataRecord['dob'] = dateFormat(getCustomerData.dob, 'dd-mm-yyyy')>
        <cfset dataRecord['isActive'] = getCustomerData.isActive>
        <cfset dataRecord['isBlcoked'] = getCustomerData.isBlcoked>
        <cfset dataRecord['isDeleted'] = getCustomerData.isDeleted>
        <cfset dataRecord['createdBy'] = getCustomerData.createdBy>
        <cfset dataRecord['createdDate'] = dateTimeFormat(getCustomerData.createdDate, 'dd-mm-yyyy hh:nn:ss tt')>
        <cfset dataRecord['updatedDate'] = dateTimeFormat(getCustomerData.updatedDate, 'dd-mm-yyyy hh:nn:ss tt')>
        <cfset dataRecord['updatedBy'] = getCustomerData.updatedBy>
        <cfset dataRecord['PkUserId'] = getCustomerData.PkUserId>
        <cfset dataRecord['userName'] = getCustomerData.userName>
        <cfset dataRecord['userNameUpdate'] = getCustomerData.userNameUpdate>
        <cfset arrayAppend(data['data'], dataRecord)>
    </cfloop>
</cfif>

<cfif structKeyExists(url, 'formAction') AND url.formAction EQ 'saveCustomer'>
    
    <cfif structKeyExists(form, "firstName") AND len(form.firstName) GT 0>
        <cfif structKeyExists(form, 'PkCustomerId') AND form.PkCustomerId EQ 0>
            <cfquery name="checkEmail">
                SELECT PkCustomerId, email FROM customer 
                WHERE email = <cfqueryparam value="#trim(email)#" cfsqltype="cf_sql_varchar"> AND 
                PkCustomerId != <cfqueryparam value = "#form.PkCustomerId#" cfsqltype = "cf_sql_integer">
            </cfquery>
            <cfif checkEmail.recordCount GT 0>
                <cflocation url="index.cfm?pg=customer&s=addCustomer&checkEmail=1" addtoken="false">
            </cfif>     
        </cfif>
        <cfif NOT structKeyExists(form, "isActive")>
            <cfset isActive = 0>
        <cfelse>
            <cfset isActive = form.isActive>
        </cfif>
        <cfset customerId = 0>
        <cfset dob = dateFormat(CreateDate(form.year, form.month, form.day), 'yyyy-mm-dd')>
        <cfset hashPassword = bcrypt.hashpw(form.password,gensalt)>
        <cfif structKeyExists(form, "PkCustomerId") AND form.PkCustomerId GT 0>
            <cfset customerId = form.PkCustomerId>
            <cfquery name="updatecustomerData">
                UPDATE customer SET
                firstName = <cfqueryparam value = "#form.firstName#" cfsqltype = "cf_sql_varchar">
                , lastName = <cfqueryparam value = "#form.lastName#" cfsqltype = "cf_sql_varchar">
                , email = <cfqueryparam value = "#form.email#" cfsqltype = "cf_sql_varchar">
                , isActive = <cfqueryparam value = "#isActive#" cfsqltype = "cf_sql_bit">
                , updatedBy =  <cfqueryparam value = "#session.user.isLoggedIn#" cfsqltype = "cf_sql_integer">
                , updatedDate =  <cfqueryparam value = "#CreateODBCDateTime(now())#" cfsqltype = "cf_sql_datetime">
                <cfif structKeyExists(form, "password") AND len( trim(form.password ) ) GT 0>
                    , password = <cfqueryparam value = "#hashPassword#" cfsqltype = "cf_sql_varchar">
                </cfif>
                WHERE PkCustomerId = <cfqueryparam value = "#customerId#" cfsqltype = "cf_sql_integer">
            </cfquery>
            <cfset session.customer = {}>
            <cfset session.customer.customerUpdate = 1>
            <cflocation url="index.cfm?pg=customer&s=customerList" addtoken="false">
        <cfelse>
            <cfquery result="addCustomerData">
                INSERT INTO customer (
                    firstName
                    , lastName
                    , email
                    , dob
                    , gender
                    <cfif structKeyExists(form, "password") AND len( trim(form.password ) ) GT 0>
                        , password
                    </cfif>
                    , isActive 
                    , createdBy
                    , createdDate
                ) VALUES (
                    <cfqueryparam value = "#form.firstName#" cfsqltype = "cf_sql_varchar">
                    , <cfqueryparam value = "#form.lastName#" cfsqltype = "cf_sql_varchar">
                    , <cfqueryparam value = "#form.email#" cfsqltype = "cf_sql_varchar">
                    , <cfqueryparam value = "#dob#" cfsqltype = "cf_sql_date">
                    , <cfqueryparam value = "#form.gender#" cfsqltype = "cf_sql_bit">
                    <cfif structKeyExists(form, "password") AND len( trim(form.password ) ) GT 0>
                        , <cfqueryparam value = "#hashPassword#" cfsqltype = "cf_sql_varchar">
                    </cfif>
                    , <cfqueryparam value = "#isActive#" cfsqltype = "cf_sql_bit">
                    , <cfqueryparam value = "#session.user.isLoggedIn#" cfsqltype = "cf_sql_varchar">
                    , <cfqueryparam value = "#CreateODBCDateTime(now())#" cfsqltype = "cf_sql_timestamp">
                )
            </cfquery>
            <cfset customerId = addCustomerData.generatedKey>
            <cfset session.customer = {}>
            <cfset session.customer.customerSave = 1>
            <cflocation url="index.cfm?pg=customer&s=customerList" addtoken="false">
        </cfif>
        <cfif structKeyExists(form, "password") AND len( trim(form.password ) ) GT 0>
            <cfquery name="qryPassword" result="qryResultPassword">
                UPDATE customer SET
                password = <cfqueryparam value = "#hashPassword#" cfsqltype = "cf_sql_varchar">
                WHERE PkCustomerId = <cfqueryparam value="#customerId#" cfsqltype="cf_sql_integer">
            </cfquery>
        </cfif>
        <cfif structKeyExists(form, "customerProfile") AND len(form.customerProfile) GT 0>
            <cfset txtcustomerProfile = "">
            <cffile action="upload" destination="#customerProfilePath#" fileField="customerProfile"  nameconflict="makeunique" result="dataImage">
            <cfset txtcustomerProfile = dataImage.serverfile>
            <cfquery name="qryGetImageName">
                SELECT profile
                FROM customer
                WHERE PkCustomerId = <cfqueryparam value="#customerId#" cfsqltype="cf_sql_integer">
            </cfquery>
            <cfif qryGetImageName.recordCount EQ 1 AND len(qryGetImageName.customerProfile) GT 0>
                <cfif fileExists("#customerProfilePath##qryGetImageName.customerProfile#")>
                    <cffile action="delete" file="#customerProfilePath##qryGetImageName.customerProfile#">
                </cfif>
            </cfif>
            <cfif len(txtcustomerProfile) GT 0>
                <cfquery name="qryCategoryUpdateImg" result="qryResultCategoryUpdateImg">
                    UPDATE category SET
                    profile = <cfqueryparam value="#txtcustomerProfile#" cfsqltype = "cf_sql_varchar">
                    WHERE PkCustomerId = <cfqueryparam value="#customerId#" cfsqltype="cf_sql_integer">
                </cfquery>
            </cfif>
        </cfif>
    </cfif>
</cfif>

<cfif structKeyExists(url, 'delPkCustomerId') AND url.delPkCustomerId GT 0>
        <cfquery name="removeImage">
            SELECT PkCustomerId, profile FROM customer 
            WHERE PkCustomerId = <cfqueryparam value="#url.delPkCustomerId#" cfsqltype = "cf_sql_integer">
        </cfquery>
        <cfif fileExists("#customerProfilePath##removeImage.profile#")>
            <cffile action="delete" file="#customerProfilePath##removeImage.profile#">
        </cfif>
        <cfquery result="deleteCategoryData">
            UPDATE customer SET
            profile = <cfqueryparam value = "" cfsqltype = "cf_sql_varchar">
            , isDeleted = <cfqueryparam value="1" cfsqltype = "cf_sql_integer">
            WHERE PkCustomerId = <cfqueryparam value="#url.delPkCustomerId#" cfsqltype = "cf_sql_integer">
        </cfquery>
</cfif>
<cfif structKeyExists(url, "statusId") AND url.statusId GT 0>
    <cfquery name="changeStatus">
        UPDATE customer SET
        isActive = !isActive
        WHERE PkCustomerId = <cfqueryparam value = "#url.statusId#" cfsqltype = "cf_sql_integer">
    </cfquery>
</cfif>
<cfif structKeyExists(url, "blockId") AND url.blockId GT 0>
    <cfquery name="changeBlockStatus">
        UPDATE customer SET
        isBlcoked = !isBlcoked
        WHERE PkCustomerId = <cfqueryparam value = "#url.blockId#" cfsqltype = "cf_sql_integer">
    </cfquery>
</cfif>

<cfset output = serializeJson(data) />
<cfoutput>#rereplace(output,'//','')#</cfoutput>