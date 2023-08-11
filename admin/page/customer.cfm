<cfoutput>
    <cfswitch expression="#s#">
        <cfcase value="customerList">
            <cfinclude template="./customerList.cfm">
        </cfcase>
        <cfcase value="addCustomer">
            <cfinclude template="./addCustomer.cfm">
        </cfcase>
    </cfswitch>
</cfoutput>