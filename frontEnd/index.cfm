<cfoutput>
    <!---  <cfif NOT StructKeyExists(session, "user")>
        <cflocation url="login.cfm" addtoken="false">
    </cfif> --->
    <!--- <cfparam name="pg" default=""> --->
    <!DOCTYPE html>
    <html lang="en">
        <head>
            <meta charset="utf-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
            <meta name="description" content="" />
            <meta name="author" content="" />
            <title>Shop Homepage - Start Bootstrap Template</title>
            <!-- Favicon-->
            <link rel="icon" type="image/x-icon" href="./assets/favicon.ico" />
            <!-- Bootstrap icons-->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
            <!-- Core theme CSS (includes Bootstrap)-->
            <link href="./css/styles.css" rel="stylesheet" />
        </head>
        <body>
            <div id="app">
                <!--- start sidebar --->
                <cfinclude template="./common/sidebar.cfm">
                <!--- end sidebar --->
                <div id="main" class="layout-navbar navbar-fixed">
                    <!--- start header --->
                    <cfinclude template="./common/header.cfm">
                    <!--- end header --->
                    <div id="main-content">
                        <cfswitch expression="#pg#">
                            <cfcase value="dashboard">
                                <cfinclude template="/page/dashboard.cfm">
                            </cfcase>
                            <cfcase value="profile">
                                <cfinclude template="/page/profile.cfm">
                            </cfcase>
                            <cfcase value="category">
                                <cfinclude template="/page/category.cfm">
                            </cfcase>
                            <cfcase value="add_category">
                                <cfinclude template="/page/add_category.cfm">
                            </cfcase>
                            <cfcase value="product">
                                <cfinclude template="/page/product.cfm">
                            </cfcase>
                        </cfswitch>
                    </div>
                    <!--- start footer --->
                    <cfinclude template="./common/footer.cfm">
                    <!--- end footer --->     
                </div>
            </div>

        </body>
    </html>
</cfoutput>
