<cfoutput>
    <cfparam name="id" default="#url.id#" />
    <cfparam name="PkItemId" default="" />
    <cfparam name="FkCustomerId" default="" />
    <cfparam name="FkProductId" default="" />
    <cfparam name="FkOrderId" default="" />
    <cfparam name="totalQuantity" default="" />
    <cfparam name="totalCost" default="" />
    <cfparam name="status" default="" />
    <cfquery name="getOrderDetails">
        SELECT PkOrderId, firstName, lastName, email, mobile, zipCode, state, billingZipCode, billingState, FkCustomerId, shipping, status, CONCAT_WS(" ", firstName, lastName) AS customerName, address, billingAddress
        FROM orders O 
        WHERE PkOrderId = <cfqueryparam value = "#url.id#" cfsqltype = "cf_sql_integer">
    </cfquery>
   <!---  <cfquery name="getOrderPriceData">
        SELECT (
                CASE WHEN OD.shipping = 'free' THEN SUM(O.totalCost)
                    WHEN OD.shipping = 'nextDay' THEN SUM(O.totalCost) + 50.00
                    WHEN OD.shipping = 'courier' THEN SUM(O.totalCost) + 100.00
                END
            ) AS 'totalAmt',
        O.PkItemId, O.FkCustomerId, O.FkOrderId, O.FkProductId, O.totalQuantity, O.totalCost, O.createdBy, O.updatedBy, O.dateCreated, O.dateUpdated, P.productName, P.productPrice, OD.shipping
        FROM order_item O
        LEFT JOIN product P ON O.FkProductId = P.PkProductId 
        LEFT JOIN orders OD ON O.FkProductId = OD.PkOrderId 
        LEFT JOIN product_image PI ON O.FkProductId = PI.FkProductId AND PI.isDefault = 1
        WHERE  O.FkOrderId = <cfqueryparam value="#url.id#" cfsqltype = "cf_sql_integer">
    </cfquery> --->
    <cfquery name="getOrderPriceData">
        SELECT
            (
                SELECT
                    CASE WHEN o.shipping = 'free' THEN SUM(oisub.totalCost)
                        WHEN o.shipping = 'nextDay' THEN SUM(oisub.totalCost) + 50.00
                        WHEN o.shipping = 'courier' THEN SUM(oisub.totalCost) + 100.00
                    END
                FROM order_item oisub
                WHERE oisub.FkOrderId = O.PkOrderId
            ) AS 'totalAmt',
            CASE
                WHEN o.shipping = 'free' THEN 00.00
                WHEN o.shipping = 'nextDay' THEN 50.00
                WHEN o.shipping = 'courier' THEN 100.00
            END AS 'shippingAmount',
            O.PkOrderId, O.firstName, O.lastName, O.FkCustomerId, O.shipping, O.status, O.createdBy, O.updatedBy, O.createdDate, O.updatedDate, O.isDeleted, C.PkCustomerId, CONCAT_WS(" ", O.firstName, O.lastName) AS customerName
            FROM
                orders O
            LEFT JOIN customer C ON
                O.createdBy = C.PkCustomerId
            WHERE O.PkOrderId = <cfqueryparam value="#url.id#" cfsqltype = "cf_sql_integer">
            AND O.isDeleted = <cfqueryparam value="0" cfsqltype = "cf_sql_bit">
    </cfquery>
    <div class="page-heading">
        <div class="page-title">
            <div class="row">
                <div class="col-12 col-md-6 order-md-1 order-last">
                    <h1>Order Details</h1>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="index.cfm?pg=dashboard">Dashboard</a>
                            </li>
                            <li class="breadcrumb-item">
                                <a href="index.cfm?pg=order&s=orderList">Orders</a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">
                                Order Details
                            </li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <section class="section">
        <div class="row">
            <div class="col-12 col-md-7">
                <div class="card border shadow-lg">
                    <div class="card-header border-bottom pb-0">
                        <h4 class="card-title">Order Details</h4>
                    </div>
                    <div class="card-body mt-4">
                        <div class="table-responsive border-bottom">
                            <table class="table nowrap" id="orderItemeDataTable">
                                <thead>
                                    <tr>
                                        <th>Image</th>
                                        <th>Product Name</th>
                                        <th>Quantity</th>
                                        <th>Unit Price</th>
                                        <th>Price</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                        <div class="d-flex justify-content-end align-items-center mt-3">

                            <div class="row">
                                <div class="col-6">
                                    <h6>Sub Total:</h6>
                                </div>
                                <div class="col-6">
                                    <h6>#getOrderPriceData.shippingAmount#</h6>
                                </div>
                                <div class="col-6">
                                    <h6>Total:</h6>
                                </div>
                                <div class="col-6">
                                    <h6>#getOrderPriceData.totalAmt#</h6>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="card border shadow-lg">
                    <div class="card-header border-bottom pb-0">
                        <h4 class="card-title">Shipping Activity</h4>
                    </div>
                    <div class="card-body mt-4">
                        <div class="table-responsive">
                            <table class="table nowrap" id="shippingActivityDataTable">
                                <thead>
                                    <tr>
                                        <th>Date Added</th>
                                        <th>Comment</th>
                                        <th>Status</th>
                                        <th>Created By</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-5">
                <div class="card border shadow-lg">
                    <div class="card-header border-bottom pb-0">
                        <h4 class="card-title">Customer</h4>
                    </div>
                    <div class="card-body mt-4">
                        <div class="user-menu d-flex align-items-center pb-2 border-bottom">
                            <div class="user-img  d-flex align-items-center">
                                <div class="avatar avatar-md">
                                    <img src="../assets/static/images/faces/2.jpg" style="width:50px !important; height:50px !important;">
                                </div>
                            </div>
                            <div class="user-name text-end ms-3">
                                <h6 class="mb-0 text-gray-600"> #getOrderDetails.customerName#</h6>
                            </div>
                        </div>
                        <div class="mt-3 pb-2 border-bottom">
                            <h5>Contact Info</h5>
                            <div>
                                <i class="fa fa-envelope"></i> #getOrderDetails.email#
                            </div>
                            <div class="mt-2">
                                <i class="fa fa-mobile-alt"></i> #getOrderDetails.mobile#
                            </div>
                        </div>
                        <div class="mt-3 pb-2 border-bottom">
                            <h5>Shipping Address</h5>
                            #getOrderDetails.address#
                            <div class="mt-3">
                                #getOrderDetails.zipCode#
                            </div>
                            <div>
                                #getOrderDetails.state#
                            </div>
                        </div>
                        <div class="mt-3 ">
                            <h5>Billing Address</h5>
                            #getOrderDetails.billingAddress#
                            <div class="mt-3">
                                #getOrderDetails.billingZipCode#
                            </div>
                            <div>
                                #getOrderDetails.billingState#
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card border shadow-lg">
                    <div class="card-header border-bottom pb-0">
                        <h4 class="card-title mt-0 pt-0">Change Status</h4>
                    </div>
                    <div class="card-body mt-3">
                        <form id="changeOrderStatusForm" method="POST">
                            <div class="row">
                                <input type="hidden" id="PkOrderId" value="#url.id#" name="PkOrderId">
                                <div class="col-12">
                                    <lable class="fw-bold form-label" for="orderStatus">Order Status</lable>
                                    <div class="form-group">
                                        <select name="orderStatus" id="orderStatus" class="form-control form-select">
                                            <option value="">Select Order Status..</option>
                                            <option value="0">Pending</option>
                                            <option value="1">In-Progress</option>
                                            <option value="2">Dispatched</option>
                                            <option value="3">Delivered</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <lable class="fw-bold form-label" for="comment">Comment</lable>
                                    <textarea id="comment" class="form-control" name="comment"></textarea>
                                </div>
                                <div class="d-flex justify-content-end align-items-center mt-3">
                                    <button type="submit" id="changeStatusSubmit" class="btn btn-sm btn-primary" >
                                        Change Status
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script>
        var #toScript('#id#', 'id')#
        $(document).ready( function () {  
            Fancybox.bind("[data-fancybox]", {
                fillRatio: 0.9,
            });
            $('##orderItemeDataTable').DataTable({
                processing: true,
                destroy: true,
                // pageLength: 10,
                // pagination: 'datatablePagination',
                serverSide:true,
                responsive: true,
                autoWidth: false,
                searching: false,
                columnDefs: [
                    { "width": "20%", "targets": [0,1,2,3,4,] }
                ],
                paging: false,
                info: false,
                // pagingType: "simple_numbers",
                // pagingType: "full_numbers",
                ajax: {
                    url: "../ajaxOrder.cfm?formAction=getOrderItemRecord",
                    type :'post',
                    data: function(d){
                        var sIdx = d.order[0].column;
                        var m = {};
                        /* m['draw'] = d.draw;
                        m["start"] = d.start;
                        m["length"] = d.length; */
                        m["search"] = d.search.value;
                        m["FkOrderId"] = id;
                        return m;
                    }
                },
                columns: [
                    { data: 'image',
                        render: function(data, display, row) {
                            var returnStr = '';
                            if (data !== "") {
                                returnStr+=  '<a data-fancybox="imgPreview" data-src="'+data+'"><img data-fancybox="group" class="image" src="../assets/productImage/'+data+'" width="50" height="50"></a>' 
                            } 
                            return returnStr;
                        }
                    },
                    { data: 'productName',
                        render: function(data, display, row) {
                            return '<span class="text-wrap">'+data+'</span>';
                        }
                    },
                    { data: 'totalQuantity'},
                    { data: 'productPrice',
                        render: function(data, display, row) {
                            return '<span><i class="bi bi-currency-rupee fs-5"></i></span> <span>'+data+'</span>';
                        }
                    },
                    { data: 'totalCost',
                        render: function(data, display, row) {
                            return '<span><i class="bi bi-currency-rupee fs-5"></i></span> <span>'+data+'</span>';
                        }
                    },
                ],
            });
            var validator = $("##changeOrderStatusForm").validate({
                rules: {
                    orderStatus: {
                        required: true
                    },
                },
                messages: {
                    orderStatus: {
                        required: "Please select status.",                    
                    },
                },
                ignore: [],
                errorElement: 'span',
                errorPlacement: function (error, element) {
                    error.addClass('invalid-feedback');
                },
                highlight: function (element, errorClass, validClass) {
                    $(element).addClass('is-invalid');
                },
                unhighlight: function (element, errorClass, validClass) {
                    $(element).removeClass('is-invalid');
                },
                submitHandler: function (form) {
                    event.preventDefault();
                    var formData = new FormData($('##changeOrderStatusForm')[0]);
                    $.ajax({
                        url: '../ajaxOrder.cfm?statusId='+id, 
                        data: formData,
                        type: 'POST',  
                        contentType: false,
                        processData: false,
                        success: function(data) {
                            infoToast("Changed!","status Changed Be Sucessfully!");
                            $('##shippingActivityDataTable').DataTable().ajax.reload();               
                        }, 
                    });
                }, 
            });
            $('##shippingActivityDataTable').DataTable({
                processing: true,
                destroy: true,
                // pageLength: 10,
                // pagination: 'datatablePagination',
                serverSide:true,
                responsive: true,
                autoWidth: false,
                searching: false,
                order: [[0, 'desc']],
                paging: false,
                info: false,
                columnDefs: [
                    { "width": "20%", "targets": [0] }
                ],
                // pagingType: "simple_numbers",
                // pagingType: "full_numbers",
                ajax: {
                    url: "../ajaxOrder.cfm?formAction=getShippingStatusRecord",
                    type :'post',
                    data: function(d){
                        var sIdx = d.order[0].column;
                        var m = {};
                        /*  m['draw'] = d.draw;
                        m["start"] = d.start;
                        m["length"] = d.length; */
                        m["search"] = d.search.value;
                        m["order"] = d.columns[sIdx].data + ' ' + d.order[0].dir;
                        m["FkOrderId"] = id;
                        return m;
                    }
                },
                columns: [
                    { data: 'dateCreated'},
                    { data: 'comment',
                        render: function(data, display, row) {
                            return '<span class="text-wrap">'+data+'</span>';
                        }
                    },
                    { data: 'status',
                        render: function (data,type,row) {
                            if(row.status  == 0){
                                return '<span class="badge bg-primary">Pending</span>';
                            }else if(row.status  == 1){
                                return '<span class="badge bg-warning">In Process</span>';
                            }else if(row.status  == 2){
                                return '<span class="badge bg-info">Dispatched</span>';
                            }else if(row.status  == 3){
                                return '<span class="badge bg-success">Delivered</span>';
                            } else{
                                return '<span class="badge bg-primary">Pending</span>'
                            }
                        }
                    },
                    { data: 'userName',
                        render: function (data,type,row) {
                            var returnStr = '';
                            if(row.PkUserId){
                                returnStr+= '<span class="text-wrap">'+data+'</span>'
                            } else {
                                returnStr+= '<span class="text-wrap">'+row.customerName+'</span>'
                            }
                            return returnStr;
                        }
                    },
                ],
            });
        });
        
    </script>
</cfoutput>
