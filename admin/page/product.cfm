<cfoutput>
    <cfswitch expression="#s#">
        <cfcase value="productList">
            <cfinclude template="./productList.cfm">
        </cfcase>
        <cfcase value="productAdd">
            <cfinclude template="./productAdd.cfm"> 
        </cfcase>
    </cfswitch>
</cfoutput>