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
            <link rel="stylesheet" href="./assets/extensions/@fortawesome/fontawesome-free/css/fontawesome.min.css" />
            <!--fancybox css -->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fancyapps/ui@5.0/dist/fancybox/fancybox.css" />
            <!--- select 2 css --->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/css/select2.min.css" />
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/select2-bootstrap-5-theme@1.3.0/dist/select2-bootstrap-5-theme.min.css" />
            <!--- toast css --->
            <link rel="stylesheet" href="../assets/extensions/toastify-js/src/toastify.css" />
            <!--- sweetalert2 css --->
            <link rel="stylesheet" href="./assets/extensions/sweetalert2/sweetalert2.min.css"/>
            <!--- <link href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.min.css" rel="stylesheet"/> --->
            <!-- Datatables -->
            <link rel="stylesheet" href="./assets/compiled/css/table-datatable-jquery.css"/>
            <link rel="stylesheet" href="./assets/extensions/datatables.net-bs5/css/dataTables.bootstrap5.min.css"/>
            <link rel="stylesheet" href="./assets/extensions/datatables.net-bs5/css/buttons.dataTables.min.css"/>
            <link href="./assets/css/fixedHeader.dataTables.min.css" rel="stylesheet">
            <link href="./assets/css/responsive.dataTables.min.css" rel="stylesheet"> 
            <!--- image preview css --->
            <link rel="stylesheet" href="./assets/extensions/filepond/filepond.css" />
            <link rel="stylesheet" href="./assets/extensions/filepond-plugin-image-preview/filepond-plugin-image-preview.css"/>

            <!---  flat picker css --->
            <link rel="stylesheet" href="./assets/extensions/flatpickr/flatpickr.min.css"/>
            <!--- jquery --->
            <script src="./assets/extensions/jquery/jquery.min.js"></script>
            <!--- js --->
            <script src="./assets/static/js/initTheme.js"></script>
            <!--- file uploader js --->
            <script src="./assets/extensions/filepond-plugin-file-validate-size/filepond-plugin-file-validate-size.min.js"></script>
            <script src="./assets/extensions/filepond-plugin-file-validate-type/filepond-plugin-file-validate-type.min.js"></script>
            <script src="./assets/extensions/filepond-plugin-image-crop/filepond-plugin-image-crop.min.js"></script>
            <script src="./assets/extensions/filepond-plugin-image-exif-orientation/filepond-plugin-image-exif-orientation.min.js"></script>
            <script src="./assets/extensions/filepond-plugin-image-filter/filepond-plugin-image-filter.min.js"></script>
            <script src="./assets/extensions/filepond-plugin-image-preview/filepond-plugin-image-preview.min.js"></script>
            <script src="./assets/extensions/filepond-plugin-image-resize/filepond-plugin-image-resize.min.js"></script>
            <script src="./assets/extensions/filepond/filepond.js"></script>
            <style>
                .table.dataTable{
                    width: 100% !important;
                }
                div.dataTables_length{
                    float: left !important;
                    margin-right: 17px;
                }
                div.dataTables_wrapper div.dataTables_filter {
                    float: right;
                }
                .invalidCs{
                    border:1px solid red !important;
                }
            </style>
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
                                <cfinclude template="./page/dashboard.cfm">
                            </cfcase>
                            <cfcase value="profile">
                                <cfinclude template="./page/profile.cfm">
                            </cfcase>
                            <cfcase value="category">
                                <cfinclude template="./page/category.cfm">
                            </cfcase>
                            <cfcase value="add_category">
                                <cfinclude template="./page/add_category.cfm">
                            </cfcase>
                            <cfcase value="product">
                                <cfinclude template="./page/product.cfm">
                            </cfcase>
                            <cfcase value="customer">
                                <cfinclude template="./page/customer.cfm">
                            </cfcase>
                            <cfcase value="productTag">
                                <cfinclude template="./page/productTag.cfm">
                            </cfcase>
                            <cfcase value="order">
                                <cfinclude template="./page/order.cfm">
                            </cfcase>
                            <cfcase value="coupon">
                                <cfinclude template="./page/coupon.cfm">
                            </cfcase>
                            <cfcase value="user">
                                <cfinclude template="./page/user.cfm">
                            </cfcase>
                            <cfcase value="notification">
                                <cfinclude template="./page/notification.cfm">
                            </cfcase>
                        </cfswitch>
                        
                    </div>
                    <!--- start footer --->
                    <cfinclude template="./common/footer.cfm">
                    <!--- end footer --->     
                </div>
            </div>

            <script>
                $(document).ready( function () {    
                    // open add view model
                    $('##viewnotificationModel').on('hidden.bs.modal', function () {
                        let readValue = $('##readSubmit').attr('data-value');
                        if (readValue > 0) {
                            $("##readSubmit").html("Mark As Unread").addClass('btn-danger');
                        }
                    });
                    $("##notificationDataTable").on("click", ".viewNotificationDetail", function () { 
                        var readValue = $('##readSubmit').attr('data-value');
                        var id = $(this).attr("data-id");
                        $("##viewnotificationModel").modal('show');
                        $('##PkSendNotificationId').val(id);
                        $.ajax({
                            type: "GET",
                            url: "../ajaxNotification.cfm?PkSendNotificationId="+ id,
                            success: function(result) {
                                if (result.success) {
                                    console.log("Notification Ajax Call", result.json);
                                    $("##PkSendNotificationId").val(result.json.PkSendNotificationId);
                                    $('##senderName').html(result.json.customerName);
                                    $('##notificationDate').html(result.json.createdDate);
                                    $('##notificationSubject').html(result.json.subject);
                                    $('##notificationMsg').html(result.json.message);
                                    $('##readSubmit').attr('data-value', result.json.isRead);
                                    if (result.json.isRead === 1) {
                                        $("##readSubmit").html("Mark As Unread").removeClass('btn-primary').addClass('btn-danger');
                                    } else{
                                        $("##readSubmit").html("Mark As Read").removeClass('btn-danger').addClass('btn-primary');
                                    }
                                    /* $('##viewnotificationModel').on('hidden.bs.modal', function () {
                                        if (readValue == 0) {
                                            $("##readSubmit").html("Mark As Read").addClass('btn-primary');
                                        } else{
                                            $("##readSubmit").html("Mark As Unread").addClass('btn-danger');
                                        }
                                    }); */
                                }
                            }   
                        });
                    });
                    $("##updateNotificationForm").validate({
                        submitHandler: function (form) {
                            let readValue = $('##readSubmit').attr('data-value');
                            var formData = new FormData($('##updateNotificationForm')[0]);
                            $.ajax({
                                type: "POST",
                                url: "../ajaxNotification.cfm?updatePkNotificationId=" + $('##PkSendNotificationId').val(),
                                data: formData,
                                contentType: false,
                                processData: false,
                                success: function(result) {
                                    if (result.success) {
                                        $('##notifyCount').html(result.notifyCount);
                                        $("##viewnotificationModel").modal('hide');
                                        $('##notificationDataTable').DataTable().ajax.reload();
                                    }
                                }
                            });
                        }, 
                    }); 
                });
            </script>
            <!--- JS Script --->   
            <script src="./assets/compiled/js/app.js"></script>
            <script src="./assets/static/js/components/dark.js"></script>
            <script src="./assets/extensions/perfect-scrollbar/perfect-scrollbar.min.js"></script>

            <!--- jquery validation js --->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js" integrity="sha512-rstIgDs0xPgmG6RX1Aba4KV5cWJbAMcvRCVmglpam9SoHZiUCyQVDdH2LPlxoHtrv17XWblE/V/PP+Tr04hbtA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
            <!--- select2 js --->
            <script src="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/js/select2.full.min.js"></script>
            <!-- fancy box  Scripts -->
            <script src="https://cdn.jsdelivr.net/npm/@fancyapps/ui@5.0/dist/fancybox/fancybox.umd.js"></script>

            <!--- password meter --->
            <script async defer src="https://buttons.github.io/buttons.js"></script>
            <script src="./assets/js/pswmeter.min.js"></script>

            <script src="https://cdn.datatables.net/v/bs5/dt-1.12.1/datatables.min.js"></script>
            <script src="./assets/extensions/datatables.net-bs5/js/dataTables.buttons.min.js"></script>
            <script src="./assets/static/js/pages/datatables.js"></script>
            <script src="./assets/js/dataTables.responsive.min.js"></script>
            <script src="./assets/js/dataTables.fixedHeader.min.js"></script>
            <script src="./assets/js/common.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/dayjs@1/dayjs.min.js"></script>
            <script src="./assets/extensions/dayjs/plugin/advancedFormat.js"></script>
            <!--- tostify js --->
            <script src="./assets/extensions/toastify-js/src/toastify.js"></script>
            <!--- sweet alert js --->
            <script src="./assets/extensions/sweetalert2/sweetalert2.min.js"></script>
            <!--- flat picker --->
            <script src="./assets/extensions/flatpickr/flatpickr.min.js"></script>
        </body>
    </html>
</cfoutput>
