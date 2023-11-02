<cfoutput>
    <cfparam name="PkUserId" default="" />
    <cfparam name="firstName" default="" />
    <cfparam name="lastName" default="" />
    <cfparam name="email" default="" />
    <cfparam name="password" default="" />
    <cfparam name="mobile" default="" />
    <cfparam name="dob" default="" />
    <cfparam name="gender" default="" />
    <cfparam name="image" default="" />
    <cfparam name="isActive" default="" /> 
    <div class="page-heading">
        <div class="page-title">
            <div class="row">
                <div class="col-12 col-md-6 order-md-1 order-last">
                    <h1>User</h1>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="index.cfm?pg=dashboard">Dashboard</a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">
                                Users
                            </li>
                        </ol>
                    </nav>
                </div>
                <cfif structKeyExists(session, 'user')>
                    <cfif structKeyExists(session.user, 'userSave') AND session.user.userSave EQ 1>
                        <div class="alert alert-light-success alert-dismissible show fade">
                            <i class="bi bi-check-circle"></i> User Data successfully inserted..!!!
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <cfset StructDelete(session.user,'userSave')>
                    <cfelseif structKeyExists(session.user, 'userUpdate') AND session.user.userUpdate EQ 1>
                        <div class="alert alert-light-success alert-dismissible show fade">
                            <i class="bi bi-check-circle"></i> User Data successfully updated..!!!
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <cfset StructDelete(session.user,'userUpdate')>
                    </cfif>
                </cfif>
            </div>
        </div>
        <!-- Data Tables start -->
        <section class="section">
            <div class="card">
                <div class="card-header d-flex justify-content-end">
                    <a href="../index.cfm?pg=user&s=addUser" class="btn btn-primary editUser"  name="addUser" id="addUser" data-id="0">
                        <i class="bi bi-plus-lg "></i><span class="ms-2 pt-1">Add User</span>
                    </a>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table nowrap" id="userDataTable" >
                            <thead>
                                <tr>
                                    <th>User Id</th>
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
        var table = $('#userDataTable').DataTable({
            processing: true,
            pageLength: 10,
            pagination: 'datatablePagination',
            order: [[0, 'asc']],
            serverSide: true,
            pagingType: "full_numbers",
            dom: 'l<"toolbar">frtip',
            responsive: true,
            scrollX: true,
            scrollCollapse: true,
            autoWidth: true,
            columnDefs: [
                { "width": "30%", "targets": [0,1,2,3,4,5,6,7,8,9,10] }
            ],
            ajax: {
                url: "../ajaxAddUser.cfm?formAction=getRecord",
                type :'post',
                data: function(d){
                    var sIdx = d.order[0].column;
                    var m = {};
                    m['draw'] = d.draw;
                    m["start"] = d.start;
                    m["length"] = d.length;
                    m["search"] = d.search.value;
                    m["order"] = d.columns[sIdx].data + ' ' + d.order[0].dir;
                    if ($("#isDeleted").val() !== undefined) {
                        m["isDeleted"] = $("#isDeleted").val();
                    } else {
                        m["isDeleted"] = 0;
                    }
                    return m;
                }
            },
            columns: [
                { data: 'PkUserId', },
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
                { data: 'userName',
                    render: function(data, display, row) {
                        if (row.createdBy > 0) {
                            return '<span>'+row.userName+'</span>' 
                        } else {
                            return '<span>'+row.firstName+'</span>' 
                        }
                    }   
                },
                { data: 'updatedDate'},
                { data: 'isActive',
                    render: function (data,type,row) {
                        if(row.isActive == 1){
                            return '<span id="deactive" data-id="'+row.PkUserId+'" data-status="Active" data-name="'+row.firstName+'" class=" badge bg-success text-white changeStatus"  data-toggle="tooltip" data-html="true" title="Click to Deactive User" data-placement="bottom">Active</span>';
                        }else{
                            return '<span id="active" data-id="'+row.PkUserId+'" data-status="Deactive" data-name="'+row.firstName+'" class="badge bg-danger text-white changeStatus" data-toggle="tooltip" data-html="true" title="Click to Active User" data-placement="bottom">Inactive</span>';
                        }
                    }
                },
                { data: 'PkUserId',
                    /* render: function(data, type, row, meta)
                    {
                        return '<a href="../index.cfm?pg=user&s=addUser&PkUserId='+row.PkUserId+'" data-id="'+row.PkUserId+'"  id="editUser" class="border-none btn btn-sm btn-success text-white mt-1 editUser" > <i class="bi bi-pen-fill"></i></a>  <a data-id="'+row.PkUserId+'" data-name="'+row.firstName+'" id="deleteUser" class="border-none btn btn-sm btn-danger text-white mt-1 deleteUser" > <i class="bi bi-trash"></i></a>'				
                    } */
                    render: function(data, type, row, meta)
                    {
                        var returnStr = '';
                        if(row.isDeleted == 1){
                            returnStr += '<a data-id="'+ row.PkUserId + '" data-name="'+row.firstName+'" id="restoreUser" class="border-none btn btn-sm btn-warning text-white mt-1 restoreUser"><i class="fas fa-undo"></i></a>'	
                        } else{
                            returnStr += '<a href="../index.cfm?pg=user&s=addUser&PkUserId='+row.PkUserId+'" data-id="'+row.PkUserId+'"  id="editUser" class="border-none btn btn-sm btn-success text-white mt-1 editUser" > <i class="bi bi-pen-fill"></i></a>  <a data-id="'+row.PkUserId+'" data-name="'+row.firstName+'" id="deleteUser" class="border-none btn btn-sm btn-danger text-white mt-1 deleteUser" > <i class="bi bi-trash"></i></a>'				
                        }
                        return returnStr;
                    }
                },
            ],
            rowCallback: function( row, data ) {
                if ( data.isDeleted === 1 ) {
                    $(row).addClass('table-danger');
                }
            }
        });
        $('div.toolbar').after('<select id="isDeleted" class="form-select d-inline-block w-25 pl-1 form-select-sm"><option value="2">Select All</option><option value="0" selected>Not Deleted</option><option value="1">Deleted</option></select>');
        
        $('#isDeleted').change(function () {
            $('#userDataTable').DataTable().ajax.reload();
        });
        $("#userDataTable").on("click", ".deleteUser", function () { 
            var id = $(this).attr("data-id");
            var name = $(this).data("name");
            Swal.fire({
                title: 'Are you sure?',
                text: 'You want to delete user record for ' + '"' +  name + '"',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#dc3545',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({  
                        url: '../ajaxAddUser.cfm?delPkUserId='+id, 
                        type: 'GET',  
                        success: function(data) {
                            dangerToast("Deleted!","User Deleted Successfully");
                            $('#userDataTable').DataTable().ajax.reload();               
                        }  
                    });
                }
            });
        }); 
        $("#userDataTable").on("click", ".changeStatus", function () {
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
                            url: '../ajaxAddUser.cfm?statusId='+id,  
                            type: 'POST',  
                            success: function(data) {
                                dangerToast("Deactivated!","User Deactivated Successfully");
                                $('#userDataTable').DataTable().ajax.reload();                       
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
                            url: '../ajaxAddUser.cfm?statusId='+id,  
                            type: 'POST',  
                            success: function(data) {
                                successToast("Activated!","User Activated Successfully");
                                $('#userDataTable').DataTable().ajax.reload();                       
                            }  
                        });
                    }
                });
            }
        });
        $("#userDataTable").on("click", ".restoreUser", function () { 
            var id = $(this).attr("data-id");
            var name = $(this).data("name");
            Swal.fire({
                title: 'Are you sure?',
                text: 'You want to restore user record for ' + '"' +  name + '"',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Yes, Restore it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({  
                        url: '../ajaxAddUser.cfm?restorePkUserId='+id, 
                        type: 'GET',  
                        success: function(data) {
                            successToast("Restore!","User Restore Successfully");
                            $('#userDataTable').DataTable().ajax.reload();               
                        }  
                    });
                }
            });
        }); 
    });
</script>