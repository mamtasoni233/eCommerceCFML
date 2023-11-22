<cfsetting enablecfoutputonly="true" showdebugoutput="false" />
<cfheader statuscode="200" statustext="OK" />
<cfcontent reset="true" type="application/json" />

<cfparam name="PkNotificationId" default="" />
<cfparam name="FkOrderId" default="" />
<cfparam name="message" default="" />
<cfparam name="subject" default="" />
<cfparam name="formAction" default="" />

<cffunction name="convertToObject" access="public" returntype="any" output="false"
        hint="Converts an entire query or the given record to a struct. This might return a structure (single record) or an array of structures.">
        <cfargument name="Query" type="query" required="true" />
        <cfargument name="Row" type="numeric" required="false" default="0" />
        <cfargument name="lowerCase" type="boolean" required="false" default="true" />
    
        <cfscript>
            var loc = StructNew();
			if (arguments.Query.RecordCount EQ 0){
				if (arguments.Row GT 0){
                    return(StructNew());
				}else{
                    return(arraynew(1));
				}
			}
			if (arguments.Row){
				loc.FromIndex = arguments.Row;
				loc.ToIndex = arguments.Row;
			} else {
				loc.FromIndex = 1;
				loc.ToIndex = arguments.Query.RecordCount;
			}
			if(arguments.lowerCase EQ true ){
				loc.Columns = ListToArray( LCASE(arguments.Query.ColumnList));
			}else{
				loc.Columns = ListToArray( arguments.Query.ColumnList);
			}
			loc.ColumnCount = ArrayLen( loc.Columns );
			loc.DataArray = ArrayNew( 1 );
			for (loc.RowIndex = loc.FromIndex ; loc.RowIndex LTE loc.ToIndex ; loc.RowIndex = (loc.RowIndex + 1)){
				ArrayAppend( loc.DataArray, StructNew() );
				loc.DataArrayIndex = ArrayLen( loc.DataArray );
				for (loc.ColumnIndex = 1 ; loc.ColumnIndex LTE loc.ColumnCount ; loc.ColumnIndex = (loc.ColumnIndex + 1)){
					loc.ColumnName = loc.Columns[ loc.ColumnIndex ];
					loc.DataArray[ loc.DataArrayIndex ][ loc.ColumnName ] = arguments.Query[ loc.ColumnName ][ loc.RowIndex ];
				}
			}
			if (arguments.Row){
				return( loc.DataArray[ 1 ] );
			} else {
				return( loc.DataArray );
			}
			return loc.DataArray;
    </cfscript>
</cffunction>
<cfset data = {}>
<cfset data['success'] = true>
<cftry>
    <cfif structKeyExists(url, "formAction") AND url.formAction EQ "getRecord">
        <cfquery name="getNotificationDataRows">
            SELECT
                N.FkOrderId, N.subject, N.PkNotificationId, N.message, N.createdBy, N.createdDate, SN.isRead, SN.PkSendNotificationId, SN.FkNotificationId, SN.receiver_id, C.PkCustomerId, CONCAT_WS(" ", C.firstName, C.lastName) AS customerName, O.status
            FROM send_notification SN
            LEFT JOIN notifications N  ON N.PkNotificationId = SN.FkNotificationId
            LEFT JOIN customer C ON N.createdBy = C.PkCustomerId
            LEFT JOIN orders O ON N.FkOrderId = O.PkOrderId
            WHERE SN.receiver_id = <cfqueryparam value="#session.user.isLoggedIn#" cfsqltype = "cf_sql_integer">
            <cfif structKeyExists(form, "search") AND len(form.search) GT 0>
                AND ( C.firstName LIKE <cfqueryparam value="%#trim(search)#%"> 
                        OR C.lastName LIKE <cfqueryparam value="%#trim(search)#%"> 
                        OR N.subject LIKE <cfqueryparam value="%#trim(search)#%"> 
                        OR N.message LIKE <cfqueryparam value="%#trim(search)#%"> 
                        OR CONCAT_WS(" ", C.firstName, C.lastName) LIKE <cfqueryparam value="%#trim(search)#%">
                    )
            </cfif>
            <cfif structKeyExists(form, "order") AND len(form.order) GT 0>
                ORDER BY #form.order#
            </cfif>
        </cfquery>
        <cfquery name="getNotificationData">
            SELECT
                N.FkOrderId, N.subject, N.PkNotificationId, N.message, N.createdBy, N.createdDate, SN.isRead, 
                SN.PkSendNotificationId, SN.FkNotificationId, SN.receiver_id, C.PkCustomerId, CONCAT_WS(" ", C.firstName, C.lastName) AS customerName, O.status
            FROM send_notification SN 
            LEFT JOIN notifications N ON SN.FkNotificationId = N.PkNotificationId    
            LEFT JOIN customer C ON N.createdBy = C.PkCustomerId
            LEFT JOIN orders O ON N.FkOrderId = O.PkOrderId
            WHERE SN.receiver_id = <cfqueryparam value="#session.user.isLoggedIn#" cfsqltype = "cf_sql_integer">
            <cfif structKeyExists(form, "search") AND len(form.search) GT 0>
                AND ( C.firstName LIKE <cfqueryparam value="%#trim(search)#%"> 
                        OR C.lastName LIKE <cfqueryparam value="%#trim(search)#%"> 
                        OR N.subject LIKE <cfqueryparam value="%#trim(search)#%"> 
                        OR N.message LIKE <cfqueryparam value="%#trim(search)#%"> 
                        OR CONCAT_WS(" ", C.firstName, C.lastName) LIKE <cfqueryparam value="%#trim(search)#%">
                    )
            </cfif>
            <cfif structKeyExists(form, "order") AND len(form.order) GT 0>
                ORDER BY #form.order#
            </cfif>
            LIMIT #form.start#, #form.length#
        </cfquery>
        <cfset data['data'] = []>
        <cfset data['recordsFiltered'] = getNotificationDataRows.recordCount>
        <cfset data['draw'] = form.draw>
        <cfset data['recordsTotal'] = getNotificationDataRows.recordCount>
        <cfloop query="getNotificationData">
            <cfset dataRecord = {}>
            <cfset dataRecord['PkNotificationId'] = getNotificationData.PkNotificationId>
            <cfset dataRecord['PkSendNotificationId'] = getNotificationData.PkSendNotificationId>
            <cfset dataRecord['FkOrderId'] = getNotificationData.FkOrderId>
            <cfset dataRecord['subject'] = getNotificationData.subject>
            <cfset dataRecord['status'] = getNotificationData.status>
            <cfset dataRecord['receiver_id'] = getNotificationData.receiver_id>
            <cfset dataRecord['isRead'] = getNotificationData.isRead>
            <cfset dataRecord['message'] = getNotificationData.message>
            <cfset dataRecord['createdBy'] = getNotificationData.createdBy>
            <cfset dataRecord['createdDate'] = dateTimeFormat(getNotificationData.createdDate, 'dd-mm-yyyy hh:nn:ss tt')>
            <cfset dataRecord['PkCustomerId'] = getNotificationData.PkCustomerId>
            <cfset dataRecord['customerName'] = getNotificationData.customerName>
            <cfset arrayAppend(data['data'], dataRecord)>
        </cfloop>
    </cfif>
    <cfif structKeyExists(url, "PkSendNotificationId") AND url.PkSendNotificationId GT 0>
        <cfquery name="getNotificationDetailsById">
            SELECT
                N.FkOrderId, N.subject, N.PkNotificationId, N.message, N.createdBy, N.createdDate, C.PkCustomerId, CONCAT_WS(" ", C.firstName, C.lastName) AS customerName, SN.isRead, SN.receiver_id, SN.PkSendNotificationId
            FROM send_notification SN  
            LEFT JOIN notifications N ON SN.FkNotificationId = N.PkNotificationId
            LEFT JOIN customer C ON N.createdBy = C.PkCustomerId
            WHERE SN.PkSendNotificationId = <cfqueryparam value="#url.PkSendNotificationId#" cfsqltype = "cf_sql_integer">
        </cfquery>
        <cfset data['json'] = {}>
        <cfset data['json']['FkOrderId'] = getNotificationDetailsById.FkOrderId>
        <cfset data['json']['PkSendNotificationId'] = getNotificationDetailsById.PkSendNotificationId>
        <cfset data['json']['subject'] = getNotificationDetailsById.subject>
        <cfset data['json']['message'] = getNotificationDetailsById.message>
        <cfset data['json']['isRead'] = getNotificationDetailsById.isRead>
        <cfset data['json']['customerName'] = getNotificationDetailsById.customerName>
        <cfset data['json']['createdDate'] = dateTimeFormat(getNotificationDetailsById.createdDate, 'dd-mmmm-yyyy hh:nn:ss tt')>
    </cfif>

    <cfif structKeyExists(url, "updatePkNotificationId") AND url.updatePkNotificationId GT 0>
        <cfquery result="getNotificationDetailsById">
            UPDATE send_notification SET 
                isRead  = !isRead
                WHERE PkSendNotificationId  = <cfqueryparam value = "#url.updatePkNotificationId#" cfsqltype = "cf_sql_integer">
                AND receiver_id = <cfqueryparam value="#session.user.isLoggedIn#" cfsqltype = "cf_sql_integer">
        </cfquery>
        <cfquery name="getNotification">
            SELECT 
                (
                    SELECT COUNT(PkSendNotificationId) 
                    FROM send_notification  
                    WHERE send_notification.isRead = <cfqueryparam value="0" cfsqltype="cf_sql_bit"> 
                    AND send_notification.receiver_id = <cfqueryparam value="#session.user.isLoggedIn#" cfsqltype = "cf_sql_integer"> 
                ) AS notificationCount, 
                N.FkOrderId, N.subject, N.PkNotificationId, N.message, N.createdBy, N.createdDate, SN.isRead, SN.FkNotificationId, SN.receiver_id, SN.PkSendNotificationId
            FROM send_notification SN 
            LEFT JOIN notifications N  ON SN.FkNotificationId = N.PkNotificationId
            WHERE SN.isRead = <cfqueryparam value="0" cfsqltype="cf_sql_bit">
            AND SN.receiver_id = <cfqueryparam value="#session.user.isLoggedIn#" cfsqltype = "cf_sql_integer">
            ORDER BY N.createdDate DESC
            LIMIT 2
        </cfquery>
        <cfset data['notifyCount'] = getNotification.notificationCount>
        <cfsavecontent  variable="data['html']">
            <cfoutput>
                <cfloop query="getNotification">
                    <li class="dropdown-item notification-item" id="notificationItem-#getNotification.PkSendNotificationId#">
                        <a class="d-flex align-items-center viewNotificationDetail" data-id="#getNotification.PkSendNotificationId#" role="button">
                            <div class="notification-icon bg-primary">
                                <i class="bi bi-cart-check"></i>
                            </div>
                            <div class="notification-text ms-4">
                                <p class="notification-title font-bold" id="notification-title-#getNotification.PkSendNotificationId#">
                                    #getNotification.subject#
                                </p>
                                <p class="notification-subtitle font-thin text-sm" id="notification-subtitle-#getNotification.PkSendNotificationId#">
                                    Order ID ###getNotification.FkOrderId#
                                </p>
                            </div>
                        </a>
                    </li>
                </cfloop>
            </cfoutput>
        </cfsavecontent>
    </cfif>
    
    <cfcatch>
        <cfset data['success'] = false>
        <cfset data['error'] = cfcatch>
    </cfcatch>
</cftry>
<cfset output =  serializeJSON(data)/>
<cfoutput>#output#</cfoutput>


