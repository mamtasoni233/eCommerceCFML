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
<cfoutput>
    <header>
        <nav class="navbar navbar-expand navbar-light navbar-top">
            <div class="container-fluid">
                <a href="##" class="burger-btn d-block">
                    <i class="bi bi-justify fs-3"></i>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="##navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mb-lg-0">
                        <li class="nav-item dropdown me-1">
                            <a class="nav-link active dropdown-toggle text-gray-600" href="##" data-bs-toggle="dropdown"aria-expanded="false">
                                <i class="bi bi-envelope bi-sub fs-4"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuButton">
                                <li>
                                    <h6 class="dropdown-header">Mail</h6>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="##">No new mail</a>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item dropdown me-3" >
                            <a class="nav-link active dropdown-toggle text-gray-600" href="##" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false" >
                                <i class="bi bi-bell bi-sub fs-4"></i>
                                <span class="badge badge-notification bg-danger" id="notifyCount">#getNotification.notificationCount#</span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end notification-dropdown" aria-labelledby="dropdownMenuButton">
                                <li class="dropdown-header">
                                    <h6>Notifications</h6>
                                </li>
                                <div id="notification">
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
                                </div>
                                <li>
                                    <p class="text-center py-2 mb-0">
                                        <a href="index.cfm?pg=notification&s=notificationList">See all notification</a>
                                    </p>
                                </li>
                            </ul>
                        </li>
                    </ul>
                    <div class="dropdown">
                        <a href="##" data-bs-toggle="dropdown" aria-expanded="false">
                            <div class="user-menu d-flex align-items-center">
                                <div class="user-name text-end me-3">
                                    <h6 class="mb-0 text-gray-600">#session.user.firstName# #session.user.lastName#</h6>
                                </div>
                                <div class="user-img d-flex align-items-center">
                                    <div class="avatar avatar-md">
                                        <cfif listFind("1.jpg,2.jpg,3.jpg,4.jpg,5.jpg,6.jpg", session.user.profile)>
                                            <img src="./assets/compiled/jpg/#session.user.profile#" alt="Profile">
                                        <cfelseif NOT listFind("1.jpg,2.jpg,3.jpg,4.jpg,5.jpg,6.jpg", session.user.profile) AND structKeyExists(session.user, 'profile') AND len(session.user.profile) GT 0>
                                            <img src="./assets/profileImage/#session.user.profile#" alt="Profile">
                                        <cfelse>
                                            <img src="../assets/compiled/jpg/1.jpg" class="rounded-circle profileImg" alt="Profile">
                                        </cfif> 
                                    </div>
                                </div>
                            </div>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuButton" style="min-width: 11rem">
                            <li>
                                <h6 class="dropdown-header">Hello, #session.user.firstName#</h6>
                            </li>
                            <li>
                                <a class="dropdown-item" href="index.cfm?pg=profile">
                                    <i class="icon-mid bi bi-person me-2"></i> My
                                    Profile
                                </a>
                            </li>
                            <li>
                                <hr class="dropdown-divider"/>
                            </li>
                            <li>
                                <a class="dropdown-item" href="../validate.cfm?formAction=logOut">
                                    <i class="icon-mid bi bi-box-arrow-left me-2"></i>
                                    Logout
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>
    </header>
</cfoutput>
