<cfoutput>
    <cfswitch expression="#s#">
        <cfcase value="categoryList">
            <cfinclude template="./categoryList.cfm">
        </cfcase>
        <cfcase value="categoryAdd">
            <cfinclude template="./categoryAdd.cfm"> 
        </cfcase>
    </cfswitch>
</cfoutput>