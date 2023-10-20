<cfoutput>
    <cfswitch expression="#s#">
        <cfcase value="orderList">
            <cfinclude template="./orderList.cfm">
        </cfcase>
        <cfcase value="orderDetails">
            <cfinclude template="./orderDetails.cfm">
        </cfcase>
    </cfswitch>
</cfoutput>