<cfoutput>
    <cfswitch expression="#s#">
        <cfcase value="editAccount">
            <cfinclude template="./editAccount.cfm">
        </cfcase>
        <cfcase value="changePassword">
            <cfinclude template="./changePassword.cfm"> 
        </cfcase>
        <cfcase value="wishList">
            <cfinclude template="./wishList.cfm"> 
        </cfcase>
    </cfswitch>
</cfoutput>