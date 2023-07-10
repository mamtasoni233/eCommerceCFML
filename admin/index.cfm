<cfoutput>
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
            <!--- <!-- jquery -->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script> --->
        </head>
        <body>
            <!--- js --->
            <script src="assets/static/js/initTheme.js"></script>
            <div id="app">
                <!--- start sidebar --->
                <cfinclude template="common/sidebar.cfm">
                <!--- end sidebar --->
                <div id="main" class="layout-navbar navbar-fixed">
                    <!--- start header --->
                    <cfinclude template="common/header.cfm">
                    <!--- end header --->
                    <div id="main-content">
                        <div class="page-heading">
                            <div class="page-title">
                                <div class="row">
                                    <div class="col-12 col-md-6 order-md-1 order-last">
                                        <h3>Vertical Layout with Navbar</h3>
                                        <p class="text-subtitle text-muted">
                                            Navbar will appear on the top of the page.
                                        </p>
                                    </div>
                                    <div class="col-12 col-md-6 order-md-2 order-first">
                                        <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                                            <ol class="breadcrumb">
                                                <li class="breadcrumb-item">
                                                    <a href="index.cfm">Dashboard</a>
                                                </li>
                                                <li class="breadcrumb-item active" aria-current="page">
                                                    Layout Vertical Navbar
                                                </li>
                                            </ol>
                                        </nav>
                                    </div>
                                </div>
                            </div>
                            <section class="section">
                            
                            </section>
                        </div>
                    </div>
                    <!--- start footer --->
                    <cfinclude template="common/footer.cfm">
                    <!--- end footer --->
                </div>
            </div>

            <!--- JS Script --->
            <script src="assets/static/js/components/dark.js"></script>
            <script src="assets/extensions/perfect-scrollbar/perfect-scrollbar.min.js"></script>
            <script src="assets/compiled/js/app.js"></script>
            <!-- Need: Apexcharts -->
            <script src="assets/extensions/apexcharts/apexcharts.min.js"></script>
            <script src="assets/static/js/pages/dashboard.js"></script>
        </body>
    </html>
</cfoutput>
