<cfoutput>
    <cfswitch expression="#s#">
        <cfcase value="userList">
            <cfinclude template="./userList.cfm">
        </cfcase>
        <cfcase value="addUser">
            <cfinclude template="./addUser.cfm">
        </cfcase>
    </cfswitch>
</cfoutput>