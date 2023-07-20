<cfparam name="txtIconImage" default="">

<cfquery name="qryGetProfile">
    SELECT image FROM users WHERE PkUserId = <cfqueryparam value = "#session.user.isLoggedIn#" cfsqltype = "cf_sql_integer">
</cfquery>
<cfset profile = qryGetProfile.image>
<cfset profileImagePath = ExpandPath('./assets/profileImage/')>
<cfif structKeyExists(form, "customProfile") AND len(form.customProfile) GT 0>
    <cfset txtIconImage = "">
    <cffile action="upload" destination="#profileImagePath#" fileField="form.customProfile" nameconflict="makeunique" result="dataImage">
    <cfset txtIconImage = dataImage.serverfile>

    <cfif fileExists("#profileImagePath##profile#")>
        <cffile action="delete" file="#profileImagePath##profile#">
    </cfif>
<cfelseif structKeyExists(form, 'avtarProfile') AND len(form.avtarProfile) GT 0>
    <cfset txtIconImage = form.avtarProfile>
    <cfif fileExists("#profileImagePath##profile#")>
        <cffile action="delete" file="#profileImagePath##profile#">
    </cfif>
</cfif>
<cfquery result="addCustomImage">
    UPDATE users SET 
        image = <cfqueryparam value = "#txtIconImage#" cfsqltype = "cf_sql_varchar">
        WHERE PkUserId = <cfqueryparam value = "#session.user.isLoggedIn#" cfsqltype = "cf_sql_integer">
</cfquery>

<cfset session.user.profile = txtIconImage>

<!--- custom profile upload --->

D:\Vishal Task\eCommerce\admin\assets\profileImage\avatar-3.jpg