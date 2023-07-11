<cfparam name="firstName" default="" />
<cfparam name="lastName" default="" />
<cfparam name="email" default="" />
<cfparam name="gender" default="" />
<cfparam name="dob" default="" />
<cfparam name="password" default="" />

<cfparam name="saved" default=""/>
<cfparam name="formAction" default="">
<cfset bcrypt = application.bcrypt>
<cfset gensalt = bcrypt.gensalt()>
<cfset session.user = {}>

<cfif structKeyExists(url, 'formAction') AND url.formAction EQ 'login'>
    <cfif structKeyExists(url,'saved') AND len(url.saved) GT 0>
        <cfset saved = url.saved>
    <cfelse>
        <cfset saved = "0">
    </cfif>
    <cfif len(trim(email)) GT 0>
        <cfquery name="login">
            SELECT PkUserId, firstName, lastName, email, dob, password, gender FROM users 
            WHERE email = <cfqueryparam value="#trim(email)#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfif login.recordCount EQ 1>
            <!--- <cfset hashPassword = bcrypt.hashpw(login.password, gensalt)> --->
            <cfset checkPassword = bcrypt.checkpw(password, login.password)>
            <cfif checkPassword EQ true>
                <cfset session.user.isLoggedIn = login.PkUserId>
                <cfset session.user.firstName = login.firstName>
                <cfset session.user.lastName = login.lastName>
                <cfset session.user.email = login.email>
                <cfset session.user.gender = login.gender>
                <cfset session.user.dob = login.dob>
                <cflocation url="index.cfm?saved=2" addtoken="false">
            <cfelse>
                <cflocation url="login.cfm?error=1" addtoken="false">
            </cfif>
        <cfelse>
            <cflocation url="login.cfm" addtoken="false">
        </cfif>
    </cfif>
<cfelseif structKeyExists(url, 'formAction') AND url.formAction EQ 'signUp'>
    <cfif structKeyExists(form, 'firstName') AND len(form.firstName) GT 0>
        <cfset year = "#form.year#">
        <cfset month = "#form.month#">
        <cfset day = "#form.day#">
        <cfset dateDob = "#year##month##day#">             
        <cfset dob = dateFormat(CreateDate(year, month, day), 'yyyy-mm-dd')>
        <cfset hashPassword = bcrypt.hashpw(form.password,gensalt)>
        <!--- <cfquery>
            SELECT email, PkUserId FROM users WHERE email=<cfqueryparam value = "#form.email#" cfsqltype = "cf_sql_varchar">
        </cfquery> --->
        <cfquery name="insertUserQuery">
            INSERT INTO users (
                firstName
                , lastName
                , email
                , dob
                , gender
                , password
            ) VALUES (
                <cfqueryparam value = "#form.firstName#" cfsqltype = "cf_sql_varchar">
                , <cfqueryparam value = "#form.lastName#" cfsqltype = "cf_sql_varchar">
                , <cfqueryparam value = "#form.email#" cfsqltype = "cf_sql_varchar">
                , <cfqueryparam value = "#dob#" cfsqltype = "cf_sql_date">
                , <cfqueryparam value = "#form.gender#" cfsqltype = "cf_sql_bit">
                , <cfqueryparam value = "#hashPassword#" cfsqltype = "cf_sql_varchar">
            )
        </cfquery>
        <cflocation url="login.cfm?saved=1" addtoken="false">
    </cfif>
<cfelseif structKeyExists(url, 'formAction') AND url.formAction EQ 'forgotPass'>

<cfelseif structKeyExists(url, 'formAction') AND url.formAction EQ 'logOut'>
    <cfset StructDelete(session,'user')>
    <cfset StructClear(Session)>
    <cflocation url="login.cfm" addtoken="false">
</cfif>