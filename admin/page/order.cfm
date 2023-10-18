<cfoutput>
    <cfswitch expression="#s#">
        <cfcase value="orderList">
            <cfinclude template="./orderList.cfm">
        </cfcase>
    </cfswitch>
</cfoutput>