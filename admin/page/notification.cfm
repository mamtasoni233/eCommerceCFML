<cfoutput>
    <cfswitch expression="#s#">
        <cfcase value="notificationList">
            <cfinclude template="./notificationList.cfm">
        </cfcase>
    </cfswitch>
</cfoutput>