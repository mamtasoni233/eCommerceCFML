<cfoutput>
    <div class="page-heading">
        <div class="page-title">
            <div class="row">
                <div class="col-12 col-md-6 order-md-1 order-last">
                    <h1>Notification Message List</h1>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="index.cfm?pg=dashboard">Dashboard</a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">
                                Notification
                            </li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
        <!-- Data Tables start -->
        <section class="section">
            <div class="card">
                <div class="modal fade" id="viewnotificationModel" tabindex="-1" role="dialog" aria-labelledby="viewnotificationModel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header bg-primary">
                                <h5 class="modal-title white">
                                    Message Details
                                </h5>
                                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                    <i data-feather="x"></i>
                                </button>
                            </div>
                            <form class="form p-3" id="updateNotificationForm" method="POST">
                                <input type="hidden" id="PkNotificationId" value="" name="PkNotificationId">
                                <div class="modal-body">
                                    <div class="row g-2">
                                        <div class="col-12 d-flex justify-content-between">
                                            <div id="senderNameContainer">
                                                <div class="d-flex">
                                                    <h6 class="fw-bold form-label" >From : </h6>
                                                    <h6 class="fw-bold form-label text-info ms-2" id="senderName">mamta</h6>
                                                </div>
                                            </div>
                                            <div id="dateContainer">
                                                <span class="badge bg-dark text-white rounded-3" id="notificationDate">132</span>
                                            </div>
                                        </div>
                                        <div class="col-12" id="subjectContainer">
                                            <div class="d-flex">
                                                <h6 class="fw-bold form-label" >Subject : </h6>
                                                <h6 class="fw-bold form-label ms-2" id="notificationSubject">mamta</h6>
                                            </div>
                                        </div>
                                        <div class="col-12" id="msgContainer">
                                            <div class="d-flex">
                                                <h6 class="fw-bold form-label" >Message : </h6>
                                                <h6 class="fw-bold form-label ms-2" id="notificationMsg">mamta</h6>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="submit" id="defaultSubmit" class="btn btn-primary" >
                                        <span class="d-block">Mark As Read</span>
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table nowrap" id="notificationDataTable">
                            <thead>
                                <tr>
                                    <th>Sender Name</th>
                                    <th>Subject</th>
                                    <th>status</th>
                                    <th>Date</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </section>
        <!-- Data Tables end -->
    </div>
</cfoutput>
<script>

    $(document).ready( function () {    

        $('#notificationDataTable').DataTable({
            processing: true,
            destroy: true,
            pageLength: 10,
            pagination: 'datatablePagination',
            order: [[2, 'desc']],
            serverSide:true,
            responsive: true,
            autoWidth: false,
            columnDefs: [
                { "width": "30%", "targets": [0,1,2,3,] },
            ],
            pagingType: "full_numbers",
            dom: 'l<"toolbar">frtip',
            ajax: {
                url: "../ajaxNotification.cfm?formAction=getRecord",
                type :'post',
                data: function(d){
                    var sIdx = d.order[0].column;
                    var m = {};
                    m['draw'] = d.draw;
                    m["start"] = d.start;
                    m["length"] = d.length;
                    m["search"] = d.search.value;
                    m["order"] = d.columns[sIdx].data + ' ' + d.order[0].dir;
                    return m;
                }
            },
            columns: [
                { data: 'customerName' },
                { data: 'subject'},
                { data: 'status',
                    render: function (data,type,row) {
                        if(row.status  == 0){
                            return '<span class="badge bg-primary">Pending</span>';
                        } else if(row.status  == 1){
                            return '<span class="badge bg-warning">In Process</span>';
                        } else if(row.status  == 2){
                            return '<span class="badge bg-info">Dispatched</span>';
                        } else if(row.status  == 3){
                            return '<span class="badge bg-primary">Shipped</span>';
                        } else if(row.status  == 4){
                            return '<span class="badge bg-danger">Cancelled</span>';
                        } else if(row.status  == 5){
                            return '<span class="badge bg-success">Delivered</span>';
                        } else{
                            return '<span class="badge bg-primary">Pending</span>'
                        }
                    }
                },
                { data: 'createdDate' },
                { data: 'PkNotificationId',
                    render: function(data, type, row, meta)
                    {
                        return '<a  data-id="'+ row.PkNotificationId + '" id="viewNotificationDetail" class="border-none btn btn-sm btn-primary text-white mt-1 viewNotificationDetail"><i class="fas fa-eye"></i></a>'	
                    }
                },
            ],
        });
        // open add view model
        $("#notificationDataTable").on("click", ".viewNotificationDetail", function () { 
            var id = $(this).attr("data-id");
            $("#viewnotificationModel").modal('show');
            $('#PkNotificationId').val(id);
            $.ajax({
                type: "GET",
                url: "../ajaxNotification.cfm?PkNotificationId="+ id,
                success: function(result) {
                    if (result.success) {
                        $("#PkNotificationId").val(result.json.PkNotificationId);
                        $('#senderName').html(result.json.customerName);
                        $('#notificationDate').html(result.json.createdDate);
                        $('#notificationSubject').html(result.json.subject);
                        $('#notificationMsg').html(result.json.message); 
                    }
                }   
            });
        });
        $("#updateNotificationForm").validate({
            submitHandler: function (form) {
                var formData = new FormData($('#updateNotificationForm')[0]);
                $.ajax({
                    type: "POST",
                    url: "../ajaxNotification.cfm?updatePkNotificationId=" + $('#PkNotificationId').val(),
                    data: formData,
                    contentType: false,
                    processData: false,
                    success: function(result) {
                        if (result.success) {
                            $("#viewnotificationModel").modal('hide');
                            $('#notificationDataTable').DataTable().ajax.reload();
                        }
                    }
                });
            }, 
        });
    });
    
</script>
