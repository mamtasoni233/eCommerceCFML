<cfoutput>
    <cfswitch expression="#s#">
        <cfcase value="couponList">
            <cfinclude template="./couponList.cfm">
        </cfcase>
    </cfswitch>
</cfoutput>