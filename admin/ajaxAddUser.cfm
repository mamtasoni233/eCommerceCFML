<cfsetting enablecfoutputonly="true" showdebugoutput="false" />
<cfheader statuscode="200" statustext="OK" />
<cfcontent reset="true" type="application/json" />

<cfparam name="PkUserId" default="" />
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
<cfset userProfilePath = ExpandPath('./assets/userProfile/')>

<cfif structKeyExists(url, "formAction") AND url.formAction EQ "getRecord">
    <cfquery name="getUserDataRows">
        SELECT 
            U.PkUserId, U.firstName, U.lastName, U.email, U.gender, U.dob, U.mobile, U.isActive, U.createdBy, U.updatedBy, U.createdDate, U.updatedDate, U.isDeleted, CONCAT_WS(" ", U.firstName, U.lastName) AS userName
        FROM users U
        WHERE U.PkUserId != <cfqueryparam value="#session.user.isLoggedIn#" cfsqltype = "cf_sql_integer">
        <cfif structKeyExists(form, "isDeleted") AND form.isDeleted NEQ 2>
            AND U.isDeleted = <cfqueryparam value="#form.isDeleted#" cfsqltype = "cf_sql_bit">
        </cfif>
        <cfif structKeyExists(form, "search") AND len(form.search) GT 0>
            AND ( U.firstName LIKE <cfqueryparam value="%#trim(search)#%"> 
                    OR U.lastName LIKE <cfqueryparam value="%#trim(search)#%"> 
                    OR U.firstName LIKE <cfqueryparam value="%#trim(search)#%">
                    OR U.lastName LIKE <cfqueryparam value="%#trim(search)#%">
                    OR U.email LIKE <cfqueryparam value="%#trim(search)#%">
                    OR U.gender LIKE <cfqueryparam value="%#trim(search)#%">
                    OR U.dob LIKE <cfqueryparam value="%#trim(search)#%">
                    OR U.mobile LIKE <cfqueryparam value="%#trim(search)#%">
                )
        </cfif>
        <cfif structKeyExists(form, "order") AND len(form.order) GT 0>
            ORDER BY #form.order#
        </cfif>
    </cfquery>
    <cfquery name="getUserData">
        SELECT 
            U.PkUserId, U.firstName, U.lastName, U.email, U.gender, U.dob, U.mobile, U.isActive, U.createdBy, U.updatedBy, U.createdDate, U.updatedDate, U.isDeleted, CONCAT_WS(" ", U.firstName, U.lastName) AS userName
        FROM users U
        WHERE U.PkUserId != <cfqueryparam value="#session.user.isLoggedIn#" cfsqltype = "cf_sql_integer">
        <cfif structKeyExists(form, "isDeleted") AND form.isDeleted NEQ 2>
            AND U.isDeleted = <cfqueryparam value="#form.isDeleted#" cfsqltype = "cf_sql_integer">
        </cfif>
        <cfif structKeyExists(form, "search") AND len(form.search) GT 0>
            AND ( U.firstName LIKE <cfqueryparam value="%#trim(search)#%"> 
                    OR U.lastName LIKE <cfqueryparam value="%#trim(search)#%"> 
                    OR U.firstName LIKE <cfqueryparam value="%#trim(search)#%">
                    OR U.lastName LIKE <cfqueryparam value="%#trim(search)#%">
                    OR U.email LIKE <cfqueryparam value="%#trim(search)#%">
                    OR U.gender LIKE <cfqueryparam value="%#trim(search)#%">
                    OR U.dob LIKE <cfqueryparam value="%#trim(search)#%">
                    OR U.mobile LIKE <cfqueryparam value="%#trim(search)#%">
                )
        </cfif>
        
        <cfif structKeyExists(form, "order") AND len(form.order) GT 0>
            ORDER BY #form.order#
        </cfif>
        LIMIT #form.start#, #form.length#
    </cfquery>
    <cfset data['data'] = []>
    <cfset data['recordsFiltered'] = getUserDataRows.recordCount>
    <cfset data['draw'] = form.draw>
    <cfset data['recordsTotal'] = getUserDataRows.recordCount>
    <cfloop query="getUserData">
        <cfset dataRecord = {}>

        <cfset dataRecord['PkUserId'] = getUserData.PkUserId>
        <cfset dataRecord['firstName'] = getUserData.firstName>
        <cfset dataRecord['lastName'] = getUserData.lastName>
        <cfset dataRecord['email'] = getUserData.email>
        <cfset dataRecord['gender'] = getUserData.gender>
        <cfset dataRecord['mobile'] = getUserData.mobile>
        <cfset dataRecord['dob'] = dateFormat(getUserData.dob, 'dd-mm-yyyy')>
        <cfset dataRecord['isActive'] = getUserData.isActive>
        <cfset dataRecord['isDeleted'] = getUserData.isDeleted>
        <cfset dataRecord['createdBy'] = getUserData.createdBy>
        <cfset dataRecord['createdDate'] = dateTimeFormat(getUserData.createdDate, 'dd-mm-yyyy hh:nn:ss tt')>
        <cfset dataRecord['updatedDate'] = dateTimeFormat(getUserData.updatedDate, 'dd-mm-yyyy hh:nn:ss tt')>
        <cfset dataRecord['updatedBy'] = getUserData.updatedBy>
        <cfset dataRecord['PkUserId'] = getUserData.PkUserId>
        <cfset dataRecord['userName'] = getUserData.userName>
        <cfset arrayAppend(data['data'], dataRecord)>
    </cfloop>
</cfif>

<cfif structKeyExists(url, 'formAction') AND url.formAction EQ 'saveUser'>
    
    <cfif structKeyExists(form, "firstName") AND len(form.firstName) GT 0>
        <cfif structKeyExists(form, 'PkUserId') AND form.PkUserId EQ 0>
            <cfquery name="checkEmail">
                SELECT PkUserId, email FROM users 
                WHERE email = <cfqueryparam value="#trim(email)#" cfsqltype="cf_sql_varchar"> AND 
                PkUserId != <cfqueryparam value = "#form.PkUserId#" cfsqltype = "cf_sql_integer">
            </cfquery>
            <cfif checkEmail.recordCount GT 0>
                <cflocation url="index.cfm?pg=user&s=addUser&checkEmail=1" addtoken="false">
            </cfif>     
        </cfif>
        <cfif NOT structKeyExists(form, "isActive")>
            <cfset isActive = 0>
        <cfelse>
            <cfset isActive = form.isActive>
        </cfif>
        <cfset userId = 0>
        <cfset dob = dateFormat(CreateDate(form.year, form.month, form.day), 'yyyy-mm-dd')>
        <cfset hashPassword = bcrypt.hashpw(form.password,gensalt)>
        <cfif structKeyExists(form, "PkUserId") AND form.PkUserId GT 0>
            <cfset userId = form.PkUserId>
            <cfquery name="updateUserData">
                UPDATE users SET
                firstName = <cfqueryparam value = "#form.firstName#" cfsqltype = "cf_sql_varchar">
                , lastName = <cfqueryparam value = "#form.lastName#" cfsqltype = "cf_sql_varchar">
                , email = <cfqueryparam value = "#form.email#" cfsqltype = "cf_sql_varchar">
                , mobile = <cfqueryparam value = "#form.mobile#" cfsqltype = "cf_sql_varchar">
                , isActive = <cfqueryparam value = "#isActive#" cfsqltype = "cf_sql_bit">
                , updatedBy =  <cfqueryparam value = "#session.user.isLoggedIn#" cfsqltype = "cf_sql_integer">
                , updatedDate =  <cfqueryparam value = "#CreateODBCDateTime(now())#" cfsqltype = "cf_sql_datetime">
                <cfif structKeyExists(form, "password") AND len( trim(form.password ) ) GT 0>
                    , password = <cfqueryparam value = "#hashPassword#" cfsqltype = "cf_sql_varchar">
                </cfif>
                WHERE PkUserId = <cfqueryparam value = "#userId#" cfsqltype = "cf_sql_integer">
            </cfquery>
            <!--- <cfset session.user = {}> --->
            <cfset session.user.userUpdate = 1>
            <cflocation url="index.cfm?pg=user&s=userList" addtoken="false">
        <cfelse>
            <cfquery result="addUserData">
                INSERT INTO users (
                    firstName
                    , lastName
                    , email
                    , mobile
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
                    , <cfqueryparam value = "#form.mobile#" cfsqltype = "cf_sql_varchar">
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
            <cfset userId = addUserData.generatedKey>
            <!--- <cfset session.user = {}> --->
            <cfset session.user.customerSave = 1>
            <cflocation url="index.cfm?pg=user&s=userList" addtoken="false">
        </cfif>
        <cfif structKeyExists(form, "password") AND len( trim(form.password ) ) GT 0>
            <cfquery name="qryPassword" result="qryResultPassword">
                UPDATE users SET
                password = <cfqueryparam value = "#hashPassword#" cfsqltype = "cf_sql_varchar">
                WHERE PkUserId = <cfqueryparam value="#userId#" cfsqltype="cf_sql_integer">
            </cfquery>
        </cfif>
        <cfif structKeyExists(form, "userProfile") AND len(form.userProfile) GT 0>
            <cfset txtuserProfile = "">
            <cffile action="upload" destination="#userProfilePath#" fileField="userProfile"  nameconflict="makeunique" result="dataImage">
            <cfset txtuserProfile = dataImage.serverfile>
            <cfquery name="qryGetImageName">
                SELECT image
                FROM users
                WHERE PkUserId = <cfqueryparam value="#userId#" cfsqltype="cf_sql_integer">
            </cfquery>
            <cfif qryGetImageName.recordCount EQ 1 AND len(qryGetImageName.userProfile) GT 0>
                <cfif fileExists("#userProfilePath##qryGetImageName.userProfile#")>
                    <cffile action="delete" file="#userProfilePath##qryGetImageName.userProfile#">
                </cfif>
            </cfif>
            <cfif len(txtuserProfile) GT 0>
                <cfquery name="qryUserUpdateImg" result="qryResultUSerUpdateImg">
                    UPDATE users SET
                    image = <cfqueryparam value="#txtuserProfile#" cfsqltype = "cf_sql_varchar">
                    WHERE PkUserId = <cfqueryparam value="#userId#" cfsqltype="cf_sql_integer">
                </cfquery>
            </cfif>
        </cfif>
    </cfif>
</cfif>

<cfif structKeyExists(url, 'delPkUserId') AND url.delPkUserId GT 0>
        <cfquery name="removeImage">
            SELECT PkUserId, image FROM users 
            WHERE PkUserId = <cfqueryparam value="#url.delPkUserId#" cfsqltype = "cf_sql_integer">
        </cfquery>
        <cfif fileExists("#userProfilePath##removeImage.image#")>
            <cffile action="delete" file="#userProfilePath##removeImage.image#">
        </cfif>
        <cfquery result="deleteUserImageData">
            UPDATE users SET
            image = <cfqueryparam value = "" cfsqltype = "cf_sql_varchar">
            , isDeleted = <cfqueryparam value="1" cfsqltype = "cf_sql_integer">
            WHERE PkUserId = <cfqueryparam value="#url.delPkUserId#" cfsqltype = "cf_sql_integer">
        </cfquery>
</cfif>
<cfif structKeyExists(url, "statusId") AND url.statusId GT 0>
    <cfquery name="changeStatus">
        UPDATE users SET
        isActive = !isActive
        WHERE PkUserId = <cfqueryparam value = "#url.statusId#" cfsqltype = "cf_sql_integer">
    </cfquery>
</cfif>
<cfif structKeyExists(url, 'restorePkUserId') AND url.restorePkUserId GT 0>
    <cfquery result="restoreCustomerData">
        UPDATE users SET
        isDeleted = <cfqueryparam value="0" cfsqltype = "cf_sql_bit">
        WHERE PkUserId IN(<cfqueryparam value="#url.restorePkUserId#" list="true">)
    </cfquery>
</cfif>

<cfset output = serializeJson(data) />
<cfoutput>#rereplace(output,'//','')#</cfoutput>