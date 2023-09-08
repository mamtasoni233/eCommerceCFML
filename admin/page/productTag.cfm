<cfoutput>
    <cfswitch expression="#s#">
        <cfcase value="productTagList">
            <cfinclude template="./productTagList.cfm">
        </cfcase>
    </cfswitch>
</cfoutput>