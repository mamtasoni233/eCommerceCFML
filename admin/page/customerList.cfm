<cfoutput>
    <cfparam name="PkCustomerId" default="" />
    <cfparam name="firstName" default="" />
    <cfparam name="lastName" default="" />
    <cfparam name="email" default="" />
    <cfparam name="password" default="" />
    <cfparam name="dob" default="" />
    <cfparam name="gender" default="" />
    <cfparam name="profile" default="" />
    <cfparam name="isActive" default="" /> 
    <div class="page-heading">
        <div class="page-title">
            <div class="row">
                <div class="col-12 col-md-6 order-md-1 order-last">
                    <h1>Customer</h1>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="index.cfm?pg=dashboard">Dashboard</a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">
                                Customers
                            </li>
                        </ol>
                    </nav>
                </div>
                <cfif structKeyExists(session, 'customer')>
                    <cfif structKeyExists(session.customer, 'customerSave') AND session.customer.customerSave EQ 1>
                        <div class="alert alert-light-success alert-dismissible show fade">
                            <i class="bi bi-check-circle"></i> Customer Data successfully inserted..!!!
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <cfset StructDelete(session.customer,'customerSave')>
                    <cfelseif structKeyExists(session.customer, 'customerUpdate') AND session.customer.customerUpdate EQ 1>
                        <div class="alert alert-light-success alert-dismissible show fade">
                            <i class="bi bi-check-circle"></i> Customer Data successfully updated..!!!
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <cfset StructDelete(session.customer,'customerUpdate')>
                    </cfif>
                </cfif>
            </div>
        </div>
        <!-- Data Tables start -->
        <section class="section">
            <div class="card">
                <div class="card-header d-flex justify-content-end">
                    <a href="../index.cfm?pg=customer&s=addCustomer" class="btn btn-primary editCustomer"  name="addCustomer" id="addCustomer" data-id="0">
                        <i class="bi bi-plus-lg "></i><span class="ms-2 pt-1">Add Customer</span>
                    </a>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table nowrap" id="customerDataTable" >
                            <thead>
                                <tr>
                                    <th>Customer Id</th>
                                    <th>First Name</th>
                                    <th>Last Name</th>
                                    <th>Email</th>
                                    <th>Mobile</th>
                                    <th>Gender</th>
                                    <th>Dob</th>
                                    <th>Create By</th>
                                    <th>Create Date</th>
                                    <th>Update By</th>
                                    <th>Update Date</th>
                                    <th>Is Active</th>
                                    <th>Is Block</th>
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
        var table = $('#customerDataTable').DataTable({
            processing: true,
            pageLength: 10,
            pagination: 'datatablePagination',
            order: [[0, 'asc']],
            serverSide: true,
            pagingType: "full_numbers",
            dom: 'Blfrtip',
            responsive: true,
            scrollX: true,
            scrollCollapse: true,
            autoWidth: true,
            columnDefs: [
                { "width": "30%", "targets": [0,1,2,3,4,5,6,7,8,9,10,11] }
            ],
            ajax: {
                url: "../ajaxAddCustomer.cfm?formAction=getRecord",
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
                { data: 'PkCustomerId', },
                { data: 'firstName', },
                { data: 'lastName',  },
                { data: 'email',  width:480 },
                { data: 'mobile',  width:480 },
                { data: 'gender', 
                    render: function(data, display, row) {
                        if (data > 0) {
                            return '<span>Male</span>' 
                        } else {
                            return '<span>Female</span>' 
                        }
                    },  width:500, 
                },
                { data: 'dob', width:500, },
                { data: 'userName',
                    render: function(data, display, row) {
                        if (row.createdBy > 0) {
                            return '<span>'+row.userName+'</span>' 
                        } else {
                            return '<span>'+row.firstName+'</span>' 
                        }
                    }   
                },
                { data: 'createdDate', width:280 },
                { data: 'userNameUpdate',
                    render: function(data, display, row) {
                        if (row.createdBy > 0) {
                            return '<span>'+row.userNameUpdate+'</span>' 
                        } else {
                            return '<span>'+row.firstName+'</span>' 
                        }
                    }   
                },
                { data: 'updatedDate'},
                { data: 'isActive',
                    render: function (data,type,row) {
                        if(row.isActive == 1){
                            return '<span id="deactive" data-id="'+row.PkCustomerId+'" data-status="Active" data-name="'+row.firstName+'" class=" badge bg-success text-white changeStatus"  data-toggle="tooltip" data-html="true" title="Click to Deactive Customer" data-placement="bottom">Active</span>';
                        }else{
                            return '<span id="active" data-id="'+row.PkCustomerId+'" data-status="Deactive" data-name="'+row.firstName+'" class="badge bg-danger text-white changeStatus" data-toggle="tooltip" data-html="true" title="Click to Active Customer" data-placement="bottom">Inactive</span>';
                        }
                    }
                },
                { data: 'isBlcoked',
                    render: function (data,type,row) {
                        if(row.isBlcoked == 1){
                            return '<span id="block" data-id="'+row.PkCustomerId+'" data-status="Block" data-name="'+row.firstName+'" class=" badge bg-danger text-white changeBlockStatus"  data-toggle="tooltip" data-html="true" title="Click to Un Block Customer" data-placement="bottom">Block</span>';
                        }else{
                            return '<span id="unBlock" data-id="'+row.PkCustomerId+'" data-status="unBlock" data-name="'+row.firstName+'" class="badge bg-success text-white changeBlockStatus" data-toggle="tooltip" data-html="true" title="Click to Block Customer" data-placement="bottom">Un Block</span>';
                        }
                    }
                },
                { data: 'PkCustomerId',
                    render: function(data, type, row, meta)
                    {
                        return '<a href="../index.cfm?pg=customer&s=addCustomer&PkCustomerId='+row.PkCustomerId+'" data-id="'+row.PkCustomerId+'"  id="editCustomer" class="border-none btn btn-sm btn-success text-white mt-1 editCustomer" > <i class="bi bi-pen-fill"></i></a>  <a data-id="'+row.PkCustomerId+'" data-name="'+row.firstName+'" id="deleteCustomer" class="border-none btn btn-sm btn-danger text-white mt-1 deleteCustomer" > <i class="bi bi-trash"></i></a>'				
                    }
                },
            ],
        });
        $("#customerDataTable").on("click", ".deleteCustomer", function () { 
            var id = $(this).attr("data-id");
            var name = $(this).data("name");
            Swal.fire({
                title: 'Are you sure?',
                text: 'You want to delete customer record for ' + '"' +  name + '"',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#dc3545',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({  
                        url: '../ajaxAddCustomer.cfm?delPkCustomerId='+id, 
                        type: 'GET',  
                        success: function(data) {
                            dangerToast("Deleted!","Customer Deleted Successfully");
                            $('#customerDataTable').DataTable().ajax.reload();               
                        }  
                    });
                }
            });
        }); 
        $("#customerDataTable").on("click", ".changeStatus", function () {
            var id = $(this).attr("data-id");
            var name = $(this).attr("data-name");
            var status = $(this).attr('data-status');
            if (status == "Active") {
                Swal.fire({
                    title: 'Are you sure?',
                    text: 'You want to deactive ' + '"' +  name + '"',
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonColor: '#dc3545',
                    confirmButtonText: 'Yes, Deactivate it!'
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({  
                            url: '../ajaxAddCustomer.cfm?statusId='+id,  
                            type: 'POST',  
                            success: function(data) {
                                dangerToast("Deactivated!","Customer Deactivated Successfully");
                                $('#customerDataTable').DataTable().ajax.reload();                       
                            }  
                        });
                    }
                });
            }
            else{
                Swal.fire({
                    title: 'Are you sure?',
                    text: 'You want to Active ' + '"' +  name + '"',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonText: 'Yes, Active it!'
                    }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({  
                            url: '../ajaxAddCustomer.cfm?statusId='+id,  
                            type: 'POST',  
                            success: function(data) {
                                successToast("Activated!","Customer Activated Successfully");
                                $('#customerDataTable').DataTable().ajax.reload();                       
                            }  
                        });
                    }
                });
            }
        });
        $("#customerDataTable").on("click", ".changeBlockStatus", function () {
            var id = $(this).attr("data-id");
            var name = $(this).attr("data-name");
            var status = $(this).attr('data-status');
            if (status == "Block") {
                Swal.fire({
                    title: 'Are you sure?',
                    text: 'You want to unblock ' + '"' +  name + '"',
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonColor: '#dc3545',
                    confirmButtonText: 'Yes, Unblocked it!'
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({  
                            url: '../ajaxAddCustomer.cfm?blockId='+id,  
                            type: 'POST',  
                            success: function(data) {
                                successToast("Unblocked!","Customer Unblocked Successfully");
                                $('#customerDataTable').DataTable().ajax.reload();                       
                            }  
                        });
                    }
                });
            }
            else{
                Swal.fire({
                    title: 'Are you sure?',
                    text: 'You want to Block ' + '"' +  name + '"',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonText: 'Yes, Block it!'
                    }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({  
                            url: '../ajaxAddCustomer.cfm?blockId='+id,  
                            type: 'POST',  
                            success: function(data) {
                                dangerToast("Blocked!","Customer Blocked Successfully");
                                $('#customerDataTable').DataTable().ajax.reload();                       
                            }  
                        });
                    }
                });
            }
        });
    });
</script>