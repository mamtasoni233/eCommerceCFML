<cfoutput>
    <cfparam name="PkItemId" default="" />
    <cfparam name="FkCustomerId" default="" />
    <cfparam name="FkProductId" default="" />
    <cfparam name="FkOrderId" default="" />
    <cfparam name="totalQuantity" default="" />
    <cfparam name="totalCost" default="" />
    <cfparam name="statusId" default="" />
    <div class="page-heading">
        <div class="page-title">
            <div class="row">
                <div class="col-12 col-md-6 order-md-1 order-last">
                    <h1>Orders</h1>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="index.cfm?pg=dashboard">Dashboard</a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">
                                Orders
                            </li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
        <!-- Data Tables start -->
        <section class="section">
            <div class="card">
                <div class="modal fade" id="viewOrderData" tabindex="-1" role="dialog" aria-labelledby="viewOrderData" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header bg-primary">
                                <h5 class="modal-title white">
                                    View Order Details
                                </h5>
                                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                    <i data-feather="x"></i>
                                </button>
                            </div>
                            <div class="modal-body">
                                <input type="hidden" id="FkOrderId" value="" name="FkOrderId">
                                <div class="row g-3">
                                    <div class="col-md-6" id="shippingAddressContainer">
                                        <h4 class="fw-bold form-label" for="category">Shipping Address</h4>
                                        <div class="mb-4 mt-2" id="shippingAddress"></div>
                                    </div>
                                    <div class="col-md-6" id="billingAddressContainer">
                                        <h4 class="fw-bold form-label" for="category">Billing Address</h4>
                                        <div class="mb-4 mt-2" id="billingAddress"></div>
                                    </div>
                                </div>
                                <div class="table-responsive orderItemContainer mt-5">
                                    <table class="table" id="orderItemeDataTable">
                                        <thead>
                                            <tr>
                                                <th>SI No.</th>
                                                <th>Image</th>
                                                <th>Product Name</th>
                                                <th>Quantity</th>
                                                <th>Price</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-light-secondary" data-bs-dismiss="modal">
                                    <i class="bx bx-x d-block d-sm-none"></i>
                                    <span class="d-none d-sm-block">Close</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <!--- <div class="modal fade" id="statusModal" tabindex="-1" role="dialog" aria-labelledby="statusModal" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-sm" role="document">
                        <div class="modal-content">
                            <div class="modal-header bg-primary">
                                <h5 class="modal-title white">
                                    Order Status
                                </h5>
                                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                    <i data-feather="x"></i>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form class="form p-3" id="addStatusForm" method="POST" action="" enctype="multipart/form-data">
                                    <input type="hidden" id="PkItemId" value="" name="PkItemId">
                                    <div class="col-12 mb-3">
                                        <label for="status" class="form-label text-dark fw-bold">Status</label>
                                        <select name="complainStatus" id="complainStatus" class="form-select">
                                            <option selected disabled value="">Select Status</option>
                                            <!--- <cfloop query="prc.complainStatus">
                                                <OPTION VALUE="#prc.complainStatus.PkStatusId#">
                                                    #prc.complainStatus.name#</OPTION>
                                            </cfloop> --->
                                        </select>
                                    </div>
                                    <div class="d-flex justify-content-end">
                                        <button type="submit" class="btn btn-primary" id="complaintHistory" >Save</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div> --->
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table nowrap" id="orderDataTable">
                            <thead>
                                <tr>
                                    <th>Order Id</th>
                                    <th>Customer Name</th>
                                    <th>Status</th>
                                    <th>Create Date</th>
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

        $('#orderDataTable').DataTable({
            processing: true,
            destroy: true,
            pageLength: 10,
            pagination: 'datatablePagination',
            order: [[3, 'desc']],
            serverSide:true,
            responsive: true,
            autoWidth: false,
            columnDefs: [
                { "width": "30%", "targets": [3,0,] },
            ],
            pagingType: "full_numbers",
            dom: 'l<"toolbar">frtip',
            ajax: {
                url: "../ajaxOrder.cfm?formAction=getRecord",
                type :'post',
                data: function(d){
                    var sIdx = d.order[0].column;
                    var m = {};
                    m['draw'] = d.draw;
                    m["start"] = d.start;
                    m["length"] = d.length;
                    m["search"] = d.search.value;
                    m["order"] = d.columns[sIdx].data + ' ' + d.order[0].dir;
                    if ($("#statusId").val() !== undefined) {
                        m["statusId"] = $("#statusId").val();
                    } else {
                        m["statusId"] = 0;
                    }
                    return m;
                }
            },
            columns: [
                { data: 'FkOrderId' },
                { data: 'customerName'},
                { data: 'statusId',
                    render: function (data,type,row) {
                        if(row.statusId  == 0){
                            return '<span class="badge bg-primary">Pending</span>';
                        }else if(row.statusId  == 1){
                            return '<span class="badge bg-warning">In Process</span>';
                        }else if(row.statusId  == 2){
                            return '<span class="badge bg-info">Dispatched</span>';
                        }else if(row.statusId  == 3){
                            return '<span class="badge bg-success">Delivered</span>';
                        } else{
                            return '<span class="badge bg-primary">Pending</span>'
                        }
                    }
                },
                { data: 'dateCreated' },
                { data: 'PkItemId',
                    render: function(data, type, row, meta)
                    {
                        return '<a data-id="'+ row.FkOrderId + '" id="viewOrderDetail" class="border-none btn btn-sm btn-primary text-white mt-1 viewOrderDetail"><i class="fas fa-eye"></i></a>'	
                    }
                },
            ],
            rowCallback: function( row, data ) {
                if ( data.statusId === 1 ) {
                    $(row).addClass('table-warning');
                } else if (data.statusId === 2) {
                    $(row).addClass('table-info');
                } else if (data.statusId === 3) {
                    $(row).addClass('table-success');
                } else {
                    $(row).addClass('table-transparent');
                }
            }
        });
        $('div.toolbar').after('<select id="statusId" class="form-select d-inline-block w-25 pl-1 form-select-sm"><option value="4">Select All</option><option value="0" selected>Pending</option><option value="1">In-Progress</option><option value="2">Dispatched</option><option value="3">Delivered</option></select>');
        
        $('#statusId').change(function () {
            $('#orderDataTable').DataTable().ajax.reload();
        });
        $("#orderDataTable").on("click", ".viewOrderDetail", function () { 
            var id = $(this).attr("data-id");
            $("#viewOrderData").modal('show');
            $('#FkOrderId').val(id);
            $.ajax({
                type: "GET",
                url: "../ajaxOrder.cfm?FkOrderId="+ id,
                success: function(result) {
                    if (result.success) {
                        $("#FkOrderId").val(result.json.FkOrderId);
                        $('#shippingAddress').html(result.json.address);
                        $('#billingAddress').html(result.json.billingAddress);
                        if (result.json.FkOrderId > 0) {
                            $('#orderItemeDataTable').DataTable({
                                processing: true,
                                destroy: true,
                                pageLength: 10,
                                pagination: 'datatablePagination',
                                serverSide:true,
                                responsive: true,
                                autoWidth: false,
                                columnDefs: [
                                    { "width": "40%", "targets": [0,1,2,3,4,5] }
                                ],
                                pagingType: "full_numbers",
                                ajax: {
                                    url: "../ajaxOrder.cfm?formAction=getOrderItemRecord",
                                    type :'post',
                                    data: function(d){
                                        var sIdx = d.order[0].column;
                                        var m = {};
                                        m['draw'] = d.draw;
                                        m["start"] = d.start;
                                        m["length"] = d.length;
                                        m["search"] = d.search.value;
                                        m["FkOrderId"] = $("#FkOrderId").val();
                                        return m;
                                    }
                                },
                                columns: [
                                    { data: 'sNo'},
                                    { data: 'image',
                                        render: function(data, display, row) {
                                            var returnStr = '';
                                            if (data !== "") {
                                                returnStr+=  '<a data-fancybox="imgPreview" data-src="'+data+'"><img data-fancybox="group" class="image" src="../assets/productImage/'+data+'" width="80" height="80">' 
                                            } 
                                            return returnStr;
                                        }
                                    },
                                    { data: 'productName' },
                                    { data: 'totalQuantity' },
                                    { data: 'totalCost'},
                                    { data: 'PkItemId',
                                        render: function(data, type, row, meta)
                                        {
                                            return '<a class="border-none btn btn-sm btn-primary text-white mt-1 status" data-toggle="modal" data-id="'+row.PkItemId+'" data-name="'+row.productName+'" id="status" data-bs-toggle="tooltip" data-bs-html="true" title="Change Status" data-bs-placement="bottom"><i class="fa fa-edit fs-5"></i></a>'			
                                        }
                                    },
                                ],
                                rowCallback : function(nRow, aData, iDisplayIndex){
                                    $("td:first", nRow).html(iDisplayIndex + 1);
                                    return nRow;
                                },
                            });
                            $("#orderItemeDataTable").on("click", ".status", function () {
                                // $("#statusModal").modal('show');
                                // $("#PkItemId").val($(this).data("id"));
                                var id = $(this).data("id");
                                var name = $(this).data("name");
                                Swal.fire({
                                    title: "Status",
                                    input: "select",
                                    inputOptions: {
                                        0: "Pending",
                                        1: "In-Progress",
                                        2: "Dispatched",
                                        3: "Delivered",
                                    },
                                    inputPlaceholder: "Select Status",
                                    showCancelButton: true,
                                    confirmButtonText: 'Change Status',
                                    inputValidator: function (value) {
                                        return new Promise(function (resolve, reject) {
                                            if (value === "") {
                                                resolve("You need to select status")
                                            } else{
                                                resolve()
                                            }
                                        })
                                    }
                                }).then(function (result) {
                                    console.log(result);
                                    /* Swal.fire({
                                        type: 'success',
                                        html: 'You selected: ' + result.value
                                    }) */
                                    if (result.isConfirmed) {
                                        $.ajax({  
                                            url: '../ajaxOrder.cfm?statusId='+id, 
                                            data: {value:result.value},
                                            type: 'POST',  
                                            success: function(data) {
                                                infoToast("Changed!","status Changed Be Sucessfully!");
                                                $('#orderItemeDataTable').DataTable().ajax.reload();               
                                            }  
                                        });
                                    }
                                })
                            });
                        }
                    }
                }   
            });
        });
    });
    
</script>
