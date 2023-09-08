<cfoutput>
    <cfparam name="PkTagId" default="" />
    <cfparam name="FkCategoryId" default="" />
    <cfparam name="tagName" default="" />
    <div class="page-heading">
        <div class="page-title">
            <div class="row">
                <div class="col-12 col-md-6 order-md-1 order-last">
                    <h1>Product Tag</h1>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="index.cfm?pg=dashboard">Dashboard</a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">
                                Product Tags
                            </li>
                        </ol>
                    </nav>
                </div>
                <cfif structKeyExists(session.user, 'productTagSave') AND session.user.productTagSave EQ 1>
                    <div class="alert alert-light-success alert-dismissible show fade">
                        <i class="bi bi-check-circle"></i> Product Tag Data successfully inserted..!!!
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <cfset StructDelete(session.user,'productTagSave')>
                <cfelseif structKeyExists(session.user, 'productTagUpdate') AND session.user.productTagUpdate EQ 1>
                    <div class="alert alert-light-success alert-dismissible show fade">
                        <i class="bi bi-check-circle"></i> Product Tag Data successfully updated..!!!
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <cfset StructDelete(session.user,'productTagUpdate')>
                </cfif>
            </div>
        </div>
        <!-- Data Tables start -->
        <section class="section">
            <div class="card">
                <div class="card-header d-flex justify-content-end">
                    <button class="btn btn-primary editProduct"  name="addProductTag" data-bs-toggle="model" id="addProductTag" data-id="0">
                        <i class="bi bi-plus-lg "></i><span class="ms-2 pt-1">Add Product Tag</span>
                    </button>
                </div>
                <div class="modal fade" id="addProductTagData" tabindex="-1" role="dialog" aria-labelledby="addProductTagData" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered  modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header bg-primary">
                                <h5 class="modal-title white">
                                    Add Product Tag
                                </h5>
                                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                    <i data-feather="x"></i>
                                </button>
                            </div>
                            <form class="form p-3" id="addProductTagForm" method="POST" action="" enctype="multipart/form-data">
                                <input type="hidden" id="PkTagId" value="" name="PkTagId">
                                <div class="row g-3">
                                    <div class="col-md-12">
                                        <lable class="fw-bold form-label" for="category">Category Name</lable>
                                        <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                            <select name="category" id="category" class="form-control-xl" >
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <lable class="fw-bold form-label" for="tagName">Product Tag Name</lable>
                                        <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                            <input type="text" class="form-control form-control-xl" id="tagName" value="" name="tagName"  placeholder="Enter Product Tag Name"/>
                                            <div class="form-control-icon">
                                                <i class="bi bi-tag-fill"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12 mb-2">
                                        <label class="form-label text-dark font-weight-bold" for="isActive">Is Active :
                                        </label>
                                        <span class="mt-1">
                                            <input type="checkbox" class="ms-2" id="isActive" checked name="isActive" value="1">
                                        </span>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-light-secondary" data-bs-dismiss="modal">
                                        <i class="bx bx-x d-block d-sm-none"></i>
                                        <span class="d-none d-sm-block">Close</span>
                                    </button>
                                    <button type="submit" id="defaultSubmit" class="btn btn-primary ms-1" >
                                        <i class="bx bx-check d-block d-sm-none"></i>
                                        <span class="d-none d-sm-block">Submit</span>
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped nowrap table-dark" id="productTagDataTable">
                            <thead>
                                <tr>
                                    <th>Product Tag Name</th>
                                    <th>Category Name</th>
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
        $('#category').select2({
            width: '100%' 
        });
        $('#productTagDataTable').DataTable({
            processing: true,
            pageLength: 10,
            pagination: 'datatablePagination',
            order: [[1, 'desc']],
            serverSide:true,
            responsive: true,
            autoWidth: false,
            columnDefs: [
                { "width": "40%", "targets": [0,1,2,3,4,5,6,7,8,9,10] }
            ],
            pagingType: "full_numbers",
            dom: 'l<"toolbar">frtip',
            ajax: {
                url: "../ajaxAddProductTag.cfm?formAction=getRecord",
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
                { data: 'tagName'},
                { data: 'categoryName' },
                { data: 'userName' },
                { data: 'dateCreated' },
                { data: 'userNameUpdate' },
                { data: 'dateUpdated' },
                { data: 'isActive',
                    render: function (data,type,row) {
                        if(row.isActive == 1){
                            return '<span id="deactive" data-id="'+row.PkTagId+'" data-status="Active" data-name="'+row.tagName+'" class=" badge bg-success text-white changeStatus"  data-toggle="tooltip" data-html="true" title="Click to Deactive Category" data-placement="bottom">Active</span>';
                        }else{
                            return '<span id="active" data-id="'+row.PkTagId+'" data-status="Deactive" data-name="'+row.tagName+'" class="badge bg-danger text-white changeStatus" data-toggle="tooltip" data-html="true" title="Click to Active category" data-placement="bottom">Inactive</span>';
                        }
                    }
                },
                { data: 'PkTagId',
                    render: function(data, type, row, meta)
                    {
                        return '<a data-id="'+row.PkTagId+'"  id="editProduct" class="border-none btn btn-sm btn-success text-white mt-1 editProduct" > <i class="bi bi-pen-fill"></i></a>  <a data-id="'+row.PkTagId+'" data-name="'+row.tagName+'" id="deleteProduct" class="border-none btn btn-sm btn-danger text-white mt-1 deleteProduct" > <i class="bi bi-trash"></i></a>'				
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
            $('#productTagDataTable').DataTable().ajax.reload();
        });
        // open add category model
        $("#addProductTag").on("click", function () {
            $("#addProductTagData").modal('show');
            $('#PkTagId').val(0);
            getCategory();
        });
        $("#addProductTagForm").validate({
            rules: {
                tagName: {
                    required: true
                },
                category: {
                    required: true
                }
            },
            errorPlacement: function (error, element) {
                error.insertAfter($(element).parent('div')); 
            },
            messages: {
                tagName: {
                    required: "Please enter tag name",                    
                },
                category: {
                    required: "Please select category",                    
                }
            },
            ignore: [],
            errorElement: 'span',
            errorPlacement: function (error, element) {
                var elem = $(element);
                if (elem.hasClass("select2-hidden-accessible")) {
                    element = element.siblings(".select2");
                    error.insertAfter(element);
                } else {
                    error.insertAfter(element);
                }
                error.addClass('invalid-feedback'); 
            },
            highlight: function (element, errorClass, validClass) {
                if ($(element).hasClass('select2-hidden-accessible')) {
                    $(element).siblings('.select2').children('span').children('span.select2-selection').addClass("invalidCs")
                } 
    
                $(element).addClass('is-invalid');
            },
            unhighlight: function (element, errorClass, validClass) {
                $(element).removeClass('is-invalid');
                if ($(element).hasClass('select2-hidden-accessible')) {
                    $(element).siblings('.select2').children('span').children('span.select2-selection').removeClass("invalidCs");
                }
            },
            submitHandler: function (form) {
                var formData = new FormData($('#addProductTagForm')[0]);
                $.ajax({
                    type: "POST",
                    url: "../ajaxAddProductTag.cfm?PkTagId=" + $('#PkTagId').val(),
                    data: formData,
                    contentType: false,
                    processData: false,
                    success: function(result) {
                        if ($('#PkTagId').val() > 0) {
                            successToast("Product Tag Updated!","Product Tag Successfully Updated");
                        } else{
                            successToast("Product Tag Add!","Product Tag Successfully Added");
                        }
                        $("#addProductTagData").modal('hide');
                        $('#addProductTagData').on('hidden.bs.modal', function () {
                            $("#addProductTagForm").trigger('reset');
                            $("#category").val(''); 
                        });
                        $('#productTagDataTable').DataTable().ajax.reload();   
                    }
                });
            }, 
        });
        $("select").on("select2:close", function (e) {  
            $(this).valid(); 
        });
        $("#productTagDataTable").on("click", ".editProduct", function () { 
            var id = $(this).attr("data-id");
            $("#addProductTagData").modal('show');
            $('#PkTagId').val(id);
            $(".modal-title").html("Update Category");
            $.ajax({
                type: "GET",
                url: "../ajaxAddProductTag.cfm?PkTagId="+ id,
                success: function(result) {
                    if (result.success) {
                        $("#PkTagId").val(result.json.PkTagId);
                        $('#tagName').val(result.json.tagName);
                        
                        getCategory(result.json.FkCategoryId);
                        
                        if(result.json.isActive == 1){ 
                            $('#isActive').prop('checked', true);
                        } else{
                            $('#isActive').prop('checked', false);
                        }
                        $('#addProductTagData').on('hidden.bs.modal', function () {
                            $("#addProductTagForm").trigger('reset');
                            $("#category").val(''); 
                        });
                    }
                }   
            });
        }); 
        $("#productTagDataTable").on("click", ".deleteProduct", function () { 
            var id = $(this).attr("data-id");
            var name = $(this).data("name");
            Swal.fire({
                title: 'Are you sure?',
                text: 'You want to delete product record for ' + '"' +  name + '"',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#dc3545',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({  
                        url: '../ajaxAddProductTag.cfm?delPkTagId='+id, 
                        type: 'GET',  
                        success: function(data) {
                            dangerToast("Deleted!","Product Tag Deleted Successfully");
                            $('#productTagDataTable').DataTable().ajax.reload();               
                        }  
                    });
                }
            });
        }); 
        $("#productTagDataTable").on("click", ".changeStatus", function () {
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
                            url: '../ajaxAddProductTag.cfm?statusId='+id,  
                            type: 'POST',  
                            success: function(data) {
                                dangerToast("Deactivated!","Product Tag Deactivated Successfully");
                                $('#productTagDataTable').DataTable().ajax.reload();                       
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
                            url: '../ajaxAddProductTag.cfm?statusId='+id,  
                            type: 'POST',  
                            success: function(data) {
                                successToast("Activated!","Product Tag Activated Successfully");
                                $('#productTagDataTable').DataTable().ajax.reload();                       
                            }  
                        });
                    }
                });
            }
        });
    });
    /* function getCategory(catId=0) {
        $.ajax({    
            type: "GET",
            url: "../ajaxAddProductTag.cfm?formAction=getCategory", 
            dataType: "html",  
            data: catId,         
            success: function(data){
                let dataRecord = JSON.parse(data);
                if (dataRecord.success) {
                    $('#category').html('');
                    var html = "";
                    var html = "<option>Select Category</option>";
                    for (var i = 0; i < dataRecord.categoryList.length; i++) {
                        console.log(dataRecord.categoryList);
                        html += "<option value="+dataRecord.categoryList[i].PKCATEGORYID+" >"+dataRecord.categoryList[i].CATNAME+"</option>";
                    }
                    $('#category').append(html);
                    if (catId > 0) {
                        $('#category').val(catId);
                    } else {
                        $('#category').val();
                    }
                }
                
            }
        }); 
    } */
    function getCategory(catId=0) {
        $.ajax({    
            type: "GET",
            url: "../ajaxAddProductTag.cfm?formAction=getCategory", 
            dataType: "html",  
            data: catId,         
            success: function(data){
                let dataRecord = JSON.parse(data);
                if (dataRecord.success) {
                    $('#category').html('');
                    var html = "";
                    var html = "<option>Select Category</option>";
                    for (var i = 0; i < dataRecord.categoryList.length; i++) {
                       /*  console.log(dataRecord.categoryList);
                        console.log(dataRecord.categoryList[i].child); */
                        /* for (var j = 0; j < dataRecord.categoryList[i].child.length; j++) {
                            
                            html += "<option value="+dataRecord.categoryList[i].child[j].PkCategoryId+" >"+dataRecord.categoryList[i].child[j].catName+"</option>";
                            
                        } */
                        html += "<option value="+dataRecord.categoryList[i].PKCATEGORYID+" >"+dataRecord.categoryList[i].CATNAME+"</option>";
                    }
                    $('#category').append(html);
                    if (catId > 0) {
                        $('#category').val(catId);
                    } else {
                        $('#category').val();
                    }
                }
                
            }
        }); 
    }
    
</script>