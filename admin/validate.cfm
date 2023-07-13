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
        <cfset dob = dateFormat(CreateDate(form.year, form.month, form.day), 'yyyy-mm-dd')>
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
    <cfif structKeyExists(form, 'email') AND len(form.email) GT 0>  
        <cfquery name="getMail">
            SELECT PkUserId, firstName, lastName, email, dob, password, gender FROM users 
            WHERE email = <cfqueryparam value="#trim(form.email)#" cfsqltype="cf_sql_varchar">
        </cfquery>
    </cfif>
    <cfif getMail.recordCount EQ 1>
        <!--- <cfset queryAddRow( getMail, { recipient = "recipient@example.com", lastname = "Doe", firstname = "John" }) /> --->
        <cfset email = getMail.email> 
        <cfset sendMail = getMail.email>
        <cfmail to="#email#" 
            from="mamta.s@lucidsolutions.in" 
            subject="Hello from CFML" 
            server="mail.example.com">

        This is the body of the email.

    </cfmail>
        <!--- <cfmail to="#email#" from="mamta.s@lucidsolutions.in" subject="Example email">
            Test Email Message!!
        </cfmail> --->
        <!--- Send --->
    </cfif>
    <cflocation url="auth-forgot-password.cfm" addtoken="false">

<cfelseif structKeyExists(url, 'formAction') AND url.formAction EQ 'logOut'>
    <cfset StructDelete(session,'user')>
    <cfset StructClear(Session)>
    <cflocation url="login.cfm" addtoken="false">
</cfif>