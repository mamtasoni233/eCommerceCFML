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

<cfif structKeyExists(url, 'formAction') AND url.formAction EQ 'login'>
    <cfif structKeyExists(url,'saved') AND url.saved GT 0>
        <cfset saved = url.saved>
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
                <cfset session.user = {}>
                <cfset session.user.isLoggedIn = login.PkUserId>
                <cfset session.user.firstName = login.firstName>
                <cfset session.user.lastName = login.lastName>
                <cfset session.user.email = login.email>
                <cfset session.user.gender = login.gender>
                <cfset session.user.dob = login.dob>
                <cflocation url="index.cfm?pg=dashboard&saved=2" addtoken="false">
            <cfelse>
                <cflocation url="login.cfm?error=1" addtoken="false">
            </cfif>
        <cfelse>
            <cflocation url="login.cfm" addtoken="false">
        </cfif>
    </cfif>
<cfelseif structKeyExists(url, 'formAction') AND url.formAction EQ 'signUp'>
    <cfif structKeyExists(form, 'firstName') AND len(form.firstName) GT 0>            
        <cfset dob = dateFormat(CreateDate(form.year, form.month, form.day), 'yyyy-mm-dd')>
        <cfset hashPassword = bcrypt.hashpw(form.password,gensalt)>
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
    <cfif structKeyExists(form, 'email') AND len(form.email) GT 0>  
        <cfquery name="getMail">
            SELECT PkUserId, firstName, lastName, email, dob, password, gender, token FROM users 
            WHERE email = <cfqueryparam value="#trim(form.email)#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfif getMail.recordCount EQ 1>
            <cfset token = bcrypt.hashpw(getMail.token,gensalt)>
            <cfset email = getMail.email>
            <cfset userId = getMail.PkUserId>
            <cfquery result="addToken">
                UPDATE users SET 
                token = <cfqueryparam value="#token#" cfsqltype="cf_sql_varchar">
                WHERE email= <cfqueryparam value="#trim(email)#" cfsqltype="cf_sql_varchar"> 
                AND PkUserId = <cfqueryparam value="#userId#" cfsqltype="cf_sql_integer">
            </cfquery>
            <cfquery name="getToken">
                SELECT email, PkUserId, token FROM users  
                WHERE email= <cfqueryparam value="#trim(email)#" cfsqltype="cf_sql_varchar"> 
                AND PkUserId = <cfqueryparam value="#userId#" cfsqltype="cf_sql_integer">
            </cfquery>
            <cfset tokenId = getToken.token>
            <cfmail to="#email#" 
                from="mamta.s@lucidsolutions.in" 
                subject="Hello from CFML">
                <a href="http://127.0.0.1:50001/auth-reset-password.cfm?token=#tokenId#"></a>
            </cfmail>
            <cflocation url="login.cfm?saved=3" addtoken="false">
        </cfif>
    </cfif>

<cfelseif structKeyExists(url, 'formAction') AND url.formAction EQ 'resetPass'>
    <cfif structKeyExists(form, 'email') AND len(form.email) GT 0>  
        <cfquery name="getToken">
            SELECT email, PkUserId, token FROM users  
            WHERE email= <cfqueryparam value="#trim(email)#" cfsqltype="cf_sql_varchar"> 
            AND PkUserId = <cfqueryparam value="#userId#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfif login.recordCount EQ 1>
            <cfset checkToken = bcrypt.checkpw(password, login.password)>
        </cfif>
            <cflocation url="login.cfm" addtoken="false">
    </cfif>

<cfelseif structKeyExists(url, 'formAction') AND url.formAction EQ 'logOut'>
    <cfset StructDelete(session,'user')>
    <cfset StructClear(session)>
    <cflocation url="login.cfm" addtoken="false">
</cfif>