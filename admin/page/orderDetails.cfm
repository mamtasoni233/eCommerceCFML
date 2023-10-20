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
    <!--- <div class="page-heading">
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
                            <li class="breadcrumb-item active" aria-current="page">
                                Order Details
                            </li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div> --->
    <section class="section">
        <div class="row">
            <div class="col-12 col-md-7">
                <div class="card border">
                    <div class="card-header border-bottom pb-0">
                        <h4 class="card-title">Order Details</h4>
                    </div>
                    <div class="card-body mt-4">
                        <div class="table-responsive">
                            <table class="table nowrap" id="orderItemeDataTable">
                                <thead>
                                    <tr>
                                        <th>SI No.</th>
                                        <th>Image</th>
                                        <th>Product Name</th>
                                        <th>Quantity</th>
                                        <th>Price</th>
                                        <th>Unit Price</th>
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
                <div class="card border">
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
                <div class="card border">
                    <div class="card-header border-bottom pb-0">
                        <h4 class="card-title">Change Status</h4>
                    </div>
                    <div class="card-body mt-4">
                        <div class="mt-3">
                            <form id="changeStatusForm" method="POST">
                                <div>
                                    <lable class="fw-bold form-label" for="orderStatus">Order Status</lable>
                                    <div class="form-group">
                                        <select name="orderStatus" id="orderStatus" class="form-control">
                                            <option value="">Select Order Status..</option>
                                            <option value="0">Pending</option>
                                            <option value="1">In-Progress</option>
                                            <option value="2">Dispatched</option>
                                            <option value="3">Delivered</option>
                                        </select>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script>
        var #toScript('#id#', 'id')#
        $(document).ready( function () {  
            
            $('##orderItemeDataTable').DataTable({
                processing: true,
                destroy: true,
                pageLength: 10,
                pagination: 'datatablePagination',
                serverSide:true,
                responsive: true,
                autoWidth: false,
                searching: false,
                columnDefs: [
                    { "width": "20%", "targets": [0,1,2,3,4,5] }
                ],
                pagingType: "simple_numbers",
                // pagingType: "full_numbers",
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
                        m["FkOrderId"] = id;
                        return m;
                    }
                },
                columns: [
                    { data: 'sNo'},
                    { data: 'image',
                        render: function(data, display, row) {
                            var returnStr = '';
                            if (data !== "") {
                                returnStr+=  '<a data-fancybox="imgPreview" data-src="'+data+'"><img data-fancybox="group" class="image" src="../assets/productImage/'+data+'" width="50" height="50">' 
                            } 
                            return returnStr;
                        }
                    },
                    { data: 'productName',
                        render: function(data, display, row) {
                            return '<span class="text-wrap">'+data+'</span>';
                        }
                    },
                    { data: 'totalQuantity' },
                    { data: 'totalCost'},
                    { data: 'productPrice' },
                ],
                rowCallback : function(nRow, aData, iDisplayIndex){
                    $("td:first", nRow).html(iDisplayIndex + 1);
                    return nRow;
                },
            });
        });
        
    </script>
</cfoutput>
