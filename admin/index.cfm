<cfoutput>
    <!--- <cfif NOT StructKeyExists(session, "user")>
        <cflocation url="login.cfm" addtoken="false">
    </cfif> --->
    <cfparam name="pg" default="">
    <!DOCTYPE html>
    <html lang="en">
        <head>
            <meta charset="UTF-8"/>
            <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
            <title>Dashboard - Mazer Admin Dashboard</title>

            <link rel="shortcut icon" href="/assets/compiled/svg/favicon.svg" type="image/x-icon"/>

            <link rel="stylesheet" href="/assets/compiled/css/app.css"/>
            <link rel="stylesheet" href="/assets/compiled/css/app-dark.css"/>
            <link rel="stylesheet" href="/assets/compiled/css/iconly.css"/>
            <!--- jquery --->
            <script src="/assets/extensions/jquery/jquery.min.js"></script>
            <!--- js --->
            <script src="/assets/static/js/initTheme.js"></script>
        </head>
        <body>

            <div id="app">
                <!--- start sidebar --->
                <cfinclude template="/common/sidebar.cfm">
                <!--- end sidebar --->
                <div id="main" class="layout-navbar navbar-fixed">
                    <!--- start header --->
                    <cfinclude template="/common/header.cfm">
                    <cfdump var='#pg#'>
                    <!--- end header --->
                    <div id="main-content">
                        <cfswitch expression="#pg#">
                            <cfcase value="dashboard">
                                <cfinclude template="/page/dashboard.cfm">
                            </cfcase>
                        </cfswitch>
                    </div>
                    <!--- start footer --->
                    <cfinclude template="/common/footer.cfm">
                    <!--- end footer --->     
                </div>
            </div>

            <!--- JS Script --->
            <script src="/assets/static/js/components/dark.js"></script>
            <script src="/assets/extensions/perfect-scrollbar/perfect-scrollbar.min.js"></script>
            <script src="/assets/compiled/js/app.js"></script>

            <!-- Need: Apexcharts -->
            <!--- <script src="/assets/extensions/apexcharts/apexcharts.min.js"></script>
            <script src="/assets/static/js/pages/dashboard.js"></script> --->
        </body>
    </html>
</cfoutput>
