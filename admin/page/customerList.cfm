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
                <cfif structKeyExists(session.user, 'customerSave') AND session.user.customerSave EQ 1>
                    <div class="alert alert-light-success alert-dismissible show fade">
                        <i class="bi bi-check-circle"></i> Customer Data successfully inserted..!!!
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <cfset StructDelete(session.user,'customerSave')>
                <cfelseif structKeyExists(session.user, 'customerUpdate') AND session.user.customerUpdate EQ 1>
                    <div class="alert alert-light-success alert-dismissible show fade">
                        <i class="bi bi-check-circle"></i> Customer Data successfully updated..!!!
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <cfset StructDelete(session.user,'customerUpdate')>
                <cfelseif structKeyExists(session.user, 'deleteCustomer') AND session.user.deleteCustomer EQ 1>
                    <div class="alert alert-light-success alert-dismissible show fade">
                        <i class="bi bi-check-circle"></i> Customer Data successfully deleted..!!!
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <cfset StructDelete(session.user,'deleteCustomer')>
                </cfif>
            </div>
        </div>
        <!-- Data Tables start -->
        <section class="section">
            <div class="card">
                <div class="card-header d-flex justify-content-end">
                    <a href="index.cfm?pg=customer&s=addCustomer" class="btn btn-primary editCustomer"  name="addCustomer" id="addCustomer" data-id="0">
                        <i class="bi bi-plus-lg "></i><span class="ms-2 pt-1">Add Customer</span>
                    </a>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table" id="categoryDataTable">
                            <thead>
                                <tr>
                                    <th>Category Name</th>
                                    <th>Parent Category</th>
                                    <th>Image</th>
                                    <th>Create By</th>
                                    <th>Create Date</th>
                                    <th>Update By</th>
                                    <th>Update Date</th>
                                    <th>Status</th>
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
        $('#parentCategory').select2({
            //placeholder: "Select a parent category",
            width: '100%' 
        });
        var table = $('#categoryDataTable').DataTable({
            processing: true,
            pageLength: 10,
            pagination: 'datatablePagination',
            order: [[1, 'desc']],
            responsive: true,
            serverSide: true,
            pagingType: "full_numbers",
            // dom: 'Blfrtip',
            dom: 'l<"toolbar">frtip',
            /* buttons: [
                // 'deleted', 'notDeleted'
                {
                    extend: 'collection',
                    text: 'View Deleted',
                    // className: 'showCatecgory',
                    buttons: [
                        'deleted', 'notDeleted'
                        {
                            text: 'Not Deleted',
                            action: function ( e, dt, node, config ) {
                                dt.ajax.reload();
                            }
                        },
                        {
                            text: 'Deleted',
                            action: function ( e, dt, node, config ) {
                                $('#categoryDataTable').DataTable().ajax.reload();    
                            }
                        },
                    ]
                }
            ], */
    
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
                    if ($("#isDeleted").val() !== undefined) {
                        m["isDeleted"] = $("#isDeleted").val();
                    } else {
                        m["isDeleted"] = 0;
                    }
                    return m;
                }
            },
            columns: [
                { data: 'categoryName'},
                { data: 'parentCategoryName' },
                { data: 'categoryImage',
                    render: function(data, display, row) {
                        var returnStr = '';
                        if (data !== "") {
                            returnStr+=  '<img class="image" src=".../../assets/categoryImage/'+data+'" width="80">' 
                        }
                        return returnStr;
                    }
                },
                { data: 'userName' },
                { data: 'dateCreated' },
                { data: 'userNameUpdate' },
                { data: 'dateUpdated' },
                { data: 'isActive',
                    render: function (data,type,row) {
                        if(row.isActive == 1){
                            return '<span id="deactive" data-id="'+row.PkCustomerId+'" data-status="Active" data-name="'+row.categoryName+'" class=" badge bg-success text-white changeStatus"  data-toggle="tooltip" data-html="true" title="Click to Deactive Category" data-placement="bottom">Active</span>';
                        }else{
                            return '<span id="active" data-id="'+row.PkCustomerId+'" data-status="Deactive" data-name="'+row.categoryName+'" class="badge bg-danger text-white changeStatus" data-toggle="tooltip" data-html="true" title="Click to Active category" data-placement="bottom">Inactive</span>';
                        }
                    }
                },
                { data: 'PkCustomerId',
                    render: function(data, type, row, meta)
                    {
                        return '<a data-id="'+row.PkCustomerId+'"  id="editCustomer" class="border-none btn btn-sm btn-success text-white mt-1 editCustomer" > <i class="bi bi-pen-fill"></i></a>  <a data-id="'+row.PkCustomerId+'" data-name="'+row.categoryName+'" id="deleteCategory" class="border-none btn btn-sm btn-danger text-white mt-1 deleteCategory" > <i class="bi bi-trash"></i></a>'				
                    }
                },
            ],
            rowCallback: function( row, data ) {
                if ( data.isDeleted === 1 ) {
                    $(row).addClass('text-danger');
                }
            }
        });

        $('div.toolbar').after('<select id="isDeleted" class="form-select d-inline-block w-25 pl-1 form-select-sm"><option value="2">Select All</option><option value="0" selected>Not Deleted</option><option value="1">Deleted</option></select>');
        
        $('#isDeleted').change(function () {
            $('#categoryDataTable').DataTable().ajax.reload();
        });
        // open add category model
        $("#addCustomer").on("click", function () {
            $("#addCustomerData").modal('show');
            $('#PkCustomerId').val(0);
            getParentCategory();
        });
        $("#addCustomerForm").validate({
            rules: {
                categoryName: {
                    required: true
                }
            },
            errorPlacement: function (error, element) {
                error.insertAfter($(element).parent('div')); 
            },
            messages: {
                categoryName: {
                    required: "Please enter category name",                    
                }
            },
            ignore: [],
            errorElement: 'span',
            errorPlacement: function (error, element) {
                error.addClass('invalid-feedback');
                element.after(error);
            },
            highlight: function (element, errorClass, validClass) {
                $(element).addClass('is-invalid');
            },
            unhighlight: function (element, errorClass, validClass) {
                $(element).removeClass('is-invalid');
            },
            submitHandler: function (form) {
                event. preventDefault();
                var removeImageChecked = $('input:checkbox[name=removeImage]:checked');
                if (removeImageChecked.length > 0) {
                    Swal.fire({
                        title: 'Are you sure?',
                        text: 'You want to delete image ' ,
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#dc3545',
                        confirmButtonText: 'Yes, delete it!'
                    }).then((result) => {
                        if (!result.isConfirmed == true) {
                            $('#removeImage').prop('checked', false);
                            submitCategoryData();
                        } else{
                            $('#removeImage').prop('checked', true);
                            submitCategoryData();
                        }
                    });
                } else{
                    submitCategoryData();
                }
            }, 
        });
        $('#categoryImage').change(function(){
            const file = this.files[0];
            if (file){
                let reader = new FileReader();
                reader.onload = function(event){
                    $('#imgPreview').attr('src', event.target.result);
                }
                reader.readAsDataURL(file);
            }
        });
    
        $("#categoryDataTable").on("click", ".editCustomer", function () { 
            var id = $(this).attr("data-id");
            $("#addCustomerData").modal('show');
            $('#PkCustomerId').val(id);
            $(".modal-title").html("Update Category");
            $.ajax({
                type: "GET",
                url: "../ajaxAddCustomer.cfm?PkCustomerId="+ id,
                success: function(result) {
                    if (result.success) {
                        console.log(result);
                        var image = result.json.categoryImage;
                        /* if (result.json.parentCategoryId > 0) {
                            getParentCategory(result.json.parentCategoryId);
                        } else{
                            getParentCategory(result.json.PkCustomerId);
                        } */
                        getParentCategory(result.json.parentCategoryId);
                        $("#PkCustomerId").val(result.json.PkCustomerId);
                        $('#categoryName').val(result.json.categoryName);
                        let imgSrc = '.../../assets/categoryImage/' + result.json.categoryImage;
                        if (image.length > 0) {
                            $('#imgPreview').attr('src', imgSrc);
                            $('.removeImageContainer').removeClass('d-none')
                        }
                        if(result.json.isActive == 1){ 
                            $('#isActive').prop('checked', true);
                        } else{
                            $('#isActive').prop('checked', false);
                        }
                        $('#addCustomerData').on('hidden.bs.modal', function () {
                            $("#addCustomerForm").trigger('reset');
                            $('#imgPreview').attr('src', '');
                            $("#parentCategory").val(''); 
                            $('.removeImageContainer').addClass('d-none')
                        });
                    }
                }   
            });
        }); 
        $("#categoryDataTable").on("click", ".deleteCategory", function () { 
            var id = $(this).attr("data-id");
            var name = $(this).data("name");
            Swal.fire({
                title: 'Are you sure?',
                text: 'You want to delete category record for ' + '"' +  name + '"',
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
                            dangerToast("Deleted!","Category Deleted Successfully");
                            $('#categoryDataTable').DataTable().ajax.reload();               
                        }  
                    });
                }
            });
        }); 
        $("#categoryDataTable").on("click", ".changeStatus", function () {
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
                                dangerToast("Deactivated!","Category Deactivated Successfully");
                                $('#categoryDataTable').DataTable().ajax.reload();                       
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
                                successToast("Activated!","Category Activated Successfully");
                                $('#categoryDataTable').DataTable().ajax.reload();                       
                            }  
                        });
                    }
                });
            }
        });
    });
    function getParentCategory(parentCatId=0) {
        $.ajax({    
                type: "GET",
                url: "../ajaxAddCustomer.cfm?formAction=getCategory", 
                dataType: "html",   
                data: parentCatId,          
                success: function(result){
                    let dataRecord = JSON.parse(result);
                    if (dataRecord.success) {
                        console.log(dataRecord);
                        $('#parentCategory').html('');
                        var html = "";
                        var html = "<option value='0'>Select As A Parent</option>";
                        for (var i = 0; i < dataRecord.data.length; i++) {
                            html += "<option value="+dataRecord.data[i].PkCustomerId+" >"+dataRecord.data[i].categoryName+"</option>";
                        }
                        $('#parentCategory').append(html);
                        if (parentCatId > 0) {
                            $('#parentCategory').val(parentCatId);
                        } else {
                            $('#parentCategory').val(0);
                        }
                    }
                    
                }
            }); 
    }
    function submitCategoryData() {
        var formData = new FormData($('#addCustomerForm')[0]);
        $.ajax({
            type: "POST",
            url: "../ajaxAddCustomer.cfm?PkCustomerId=" + $('#PkCustomerId').val(),
            data: formData,
            contentType: false,
            processData: false,
            success: function(result) {
                if ($('#PkCustomerId').val() > 0) {
                    successToast("Category Updated!","Category Successfully Updated");
                } else{
                    successToast("Category Add!","Category Successfully Added");
                }
                
                $("#addCustomerData").modal('hide');
                $('#addCustomerData').on('hidden.bs.modal', function () {
                    $("#addCustomerForm").trigger('reset');
                    $('#imgPreview').attr('src', '');
                    $("#parentCategory").val(''); 
                });
                $('#categoryDataTable').DataTable().ajax.reload();
            }
        });
    }
    
</script>