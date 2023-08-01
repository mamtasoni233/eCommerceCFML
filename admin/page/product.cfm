<cfoutput>
    <cfswitch expression="#s#">
        <cfcase value="productList">
            <cfinclude template="./productList.cfm">
        </cfcase>
    </cfswitch>
</cfoutput>