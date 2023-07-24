<cfoutput>
    <cfif NOT StructKeyExists(session, "user")>
        <cflocation url="login.cfm" addtoken="false">
    </cfif>
    <cfparam name="pg" default="">
    <!DOCTYPE html>
    <html lang="en">
        <head>
            <meta charset="UTF-8"/>
            <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
            <title>Dashboard - Mazer Admin Dashboard</title>

            <link rel="shortcut icon" href="./assets/compiled/svg/favicon.svg" type="image/x-icon"/>

            <link rel="stylesheet" href="./assets/compiled/css/app.css"/>
            <link rel="stylesheet" href="./assets/compiled/css/app-dark.css"/>
            <link rel="stylesheet" href="./assets/compiled/css/iconly.css"/>
            <link rel="stylesheet" href="./assets/extensions/@fortawesome/fontawesome-free/css/all.min.css" />
            <!--- toast css --->
            <!--- <link href="./assets/css/jquery.toast.min.css" rel="stylesheet"> --->
            <link rel="stylesheet" href="assets/extensions/toastify-js/src/toastify.css" />
            <!-- Datatables -->
            <!---  <link href="./assets/dataTable/css/jquery.dataTables.min.css">
            <link href="./assets/dataTable/css/dataTables.bootstrap5.min.css" rel="stylesheet"> --->
            <!--- data table css --->
            <link rel="stylesheet" href="./assets/compiled/css/table-datatable-jquery.css"/>
            <link rel="stylesheet" href="./assets/extensions/datatables.net-bs5/css/dataTables.bootstrap5.min.css"/>
            <!--- image preview css --->
            <link rel="stylesheet" href="./assets/extensions/filepond/filepond.css" />
            <link rel="stylesheet" href="./assets/extensions/filepond-plugin-image-preview/filepond-plugin-image-preview.css"/>
            <!--- jquery --->
            <script src="./assets/extensions/jquery/jquery.min.js"></script>
            <!--- js --->
            <script src="./assets/static/js/initTheme.js"></script>
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

            <!--- JS Script --->   
            <script src="./assets/compiled/js/app.js"></script>
            <script src="./assets/static/js/components/dark.js"></script>
            <script src="./assets/extensions/perfect-scrollbar/perfect-scrollbar.min.js"></script>

            <!--Datatables -->
            <!---   <script src="./assets/dataTable/js/jquery.dataTables.min.js"></script>
            <script src="./assets/dataTable/js/dataTables.bootstrap5.min.js"></script> --->

            <!--- jquery validation js --->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js" integrity="sha512-rstIgDs0xPgmG6RX1Aba4KV5cWJbAMcvRCVmglpam9SoHZiUCyQVDdH2LPlxoHtrv17XWblE/V/PP+Tr04hbtA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
            
            <script src="./assets/extensions/choices.js/public/assets/scripts/choices.js"></script>
            <script src="./assets/static/js/pages/form-element-select.js"></script>
            <!--- password meter --->
            <script async defer src="https://buttons.github.io/buttons.js"></script>
            <script src="./assets/js/pswmeter.min.js"></script>

            <script src="https://cdn.datatables.net/v/bs5/dt-1.12.1/datatables.min.js"></script>
            <script src="./assets/static/js/pages/datatables.js"></script>
            <!--- <script src="./assets/js/jquery.toast.min.js"></script> --->
            <script src="./assets/js/common.js"></script>
            <!--- file uploader js --->
            <script src="./assets/extensions/filepond-plugin-file-validate-size/filepond-plugin-file-validate-size.min.js"></script>
            <script src="./assets/extensions/filepond-plugin-file-validate-type/filepond-plugin-file-validate-type.min.js"></script>
            <script src="./assets/extensions/filepond-plugin-image-crop/filepond-plugin-image-crop.min.js"></script>
            <script src="./assets/extensions/filepond-plugin-image-exif-orientation/filepond-plugin-image-exif-orientation.min.js"></script>
            <script src="./assets/extensions/filepond-plugin-image-filter/filepond-plugin-image-filter.min.js"></script>
            <script src="./assets/extensions/filepond-plugin-image-preview/filepond-plugin-image-preview.min.js"></script>
            <script src="./assets/extensions/filepond-plugin-image-resize/filepond-plugin-image-resize.min.js"></script>
            <script src="./assets/extensions/filepond/filepond.js"></script>
            <script src="./assets/static/js/pages/filepond.js"></script>\
            <script src="https://cdn.jsdelivr.net/npm/dayjs@1/dayjs.min.js"></script>
            <script src="./assets/extensions/dayjs/plugin/advancedFormat.js"></script>
            <!--- tostify js --->
            <script src="./assets/extensions/toastify-js/src/toastify.js"></script>

            <!-- Need: Apexcharts -->
            <!--- <script src="/assets/extensions/apexcharts/apexcharts.min.js"></script>
            <script src="/assets/static/js/pages/dashboard.js"></script> --->
        </body>
    </html>
</cfoutput>
