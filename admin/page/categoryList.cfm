<cfoutput>
    <cfparam name="PkCategoryId" default="" />
    <cfparam name="categoryName" default="" />
    <cfparam name="categoryImage" default="" />
    <div class="page-heading">
        <div class="page-title">
            <div class="row">
                <div class="col-12 col-md-6 order-md-1 order-last">
                    <h1>Category</h1>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="index.cfm?pg=dashboard">Dashboard</a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">
                                Categories
                            </li>
                        </ol>
                    </nav>
                </div>
                <cfif structKeyExists(session.user, 'categorySave') AND session.user.categorySave EQ 1>
                    <div class="alert alert-light-success alert-dismissible show fade">
                        <i class="bi bi-check-circle"></i> Category Data successfully inserted..!!!
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <cfset StructDelete(session.user,'categorySave')>
                <cfelseif structKeyExists(session.user, 'categoryUpdate') AND session.user.categoryUpdate EQ 1>
                    <div class="alert alert-light-success alert-dismissible show fade">
                        <i class="bi bi-check-circle"></i> Category Data successfully updated..!!!
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <cfset StructDelete(session.user,'categoryUpdate')>
                <cfelseif structKeyExists(session.user, 'deleteCategory') AND session.user.deleteCategory EQ 1>
                    <div class="alert alert-light-success alert-dismissible show fade">
                        <i class="bi bi-check-circle"></i> Category Data successfully deleted..!!!
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <cfset StructDelete(session.user,'deleteCategory')>
                </cfif>
            </div>
        </div>
        <!-- Data Tables start -->
        <section class="section">
            <div class="card">
                <div class="card-header d-flex justify-content-end">
                    <button class="btn btn-primary editCategory"  name="addCategory" data-bs-toggle="model" id="addCategory" data-id="0">
                        <i class="bi bi-plus-lg "></i><span class="ms-2 pt-1">Add Category</span>
                    </button>
                </div>
                <div class="modal fade" id="addCategoryData" tabindex="-1" role="dialog" aria-labelledby="addCategoryData" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered  modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header bg-primary">
                                <h5 class="modal-title white">
                                    Add Category
                                </h5>
                                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                    <i data-feather="x"></i>
                                </button>
                            </div>
                            <form class="form p-3" id="addCategoryForm" method="POST" enctype="multipart/form-data">
                                <input type="hidden" id="PkCategoryId" value="" name="PkCategoryId">
                                <div class="row g-3">
                                    <div class="col-md-12">
                                        <lable class="fw-bold form-label" for="parentCategory">Parent Category Name</lable>
                                        <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                            <select name="parentCategory" id="parentCategory" class="form-control-xl">
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <lable class="fw-bold form-label" for="categoryName">Category Name</lable>
                                        <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                            <input type="text" class="form-control form-control-xl" id="categoryName" value="" name="categoryName"  placeholder="Category Name"/>
                                            <div class="form-control-icon">
                                                <i class="bi bi-bag-heart-fill"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <lable class="fw-bold form-label text-center" for="categoryImage">Category Image</lable>
                                        <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                            <input type="file" class="form-control form-control-xl image-preview-filepond" id="categoryImage">
                                        </div>
                                        <img id="imgPreview" src="" class="w-25 mt-2 mb-3">
                                        <div class="form-check removeImageContainer d-none">
                                            <div class="checkbox">
                                                <input type="checkbox" id="removeImage" name="removeImage" class="form-check-input" value="1" />
                                                <label class="form-label text-dark font-weight-bold" for="removeImage">
                                                    Remove Image
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12 mb-2">
                                        <div class="form-check">
                                            <div class="checkbox">
                                                <label class="form-label text-dark font-weight-bold" for="isActive">Is Active
                                                </label>
                                                <input type="checkbox" class="form-check-input" id="isActive" checked name="isActive" value="1">
                                            </div>
                                        </div>
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
                        <table class="table table-striped nowrap table-dark" id="categoryDataTable">
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
    FilePond.registerPlugin(
        FilePondPluginImagePreview,
        FilePondPluginImageCrop,
        FilePondPluginImageExifOrientation,
        FilePondPluginImageFilter,
        FilePondPluginImageResize,
        FilePondPluginFileValidateSize,
        FilePondPluginFileValidateType
    )
    function createFilePond() {
        const filepondInput = document.querySelector(".image-preview-filepond");
        const filepondImage = FilePond.create(filepondInput, {
            credits: null,
            allowImagePreview: true,
            allowImageFilter: false,
            allowImageExifOrientation: false,
            allowImageCrop: false,
            acceptedFileTypes: ["image/png", "image/jpg", "image/jpeg", "image/webp"],
            storeAsFile: true,
            fileValidateTypeDetectType: (source, type) =>
            new Promise((resolve, reject) => {
                // Do custom type detection here and return with promise
                resolve(type);
            }),
        });
    }
    $(document).ready( function () {
        
        /* $('#parentCategory').select2({
            width: '100%',
            allowClear: true,
            dropdownParent: $('#addCategoryData')
            
        }); */
        $('#parentCategory').select2({
            theme: "bootstrap-5",
            width: $( this ).data( 'width' ) ? $( this ).data( 'width' ) : $( this ).hasClass( 'w-100' ) ? '100%' : 'style',
            dropdownParent: $('#addCategoryData'),
            allowClear: true,
        });
        var table = $('#categoryDataTable').DataTable({
            serverSide: true,
            processing: true,
            pageLength: 10,
            pagination: 'datatablePagination',
            order: [[0, 'desc']],
            responsive: true,
            columnDefs: [
                { "width": "40%", "targets": [0,1,2,3,4,5,6,7,8] }
            ],
            pagingType: "full_numbers",
            dom: 'l<"toolbar">frtip',
            ajax: {
                url: "../ajaxAddCategory.cfm?formAction=getRecord",
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
                            returnStr+=  '<img class="image" src="/assets/categoryImage/'+data+'" width="80">' 
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
                            return '<span id="deactive" data-id="'+row.PkCategoryId+'" data-status="Active" data-name="'+row.categoryName+'" class=" badge bg-success text-white changeStatus"  data-toggle="tooltip" data-html="true" title="Click to Deactive Category" data-placement="bottom">Active</span>';
                        }else{
                            return '<span id="active" data-id="'+row.PkCategoryId+'" data-status="Deactive" data-name="'+row.categoryName+'" class="badge bg-danger text-white changeStatus" data-toggle="tooltip" data-html="true" title="Click to Active category" data-placement="bottom">Inactive</span>';
                        }
                    }
                },
                { data: 'PkCategoryId',
                    render: function(data, type, row, meta)
                    {
                        return '<a data-id="'+row.PkCategoryId+'" data-parentid="' + row.parentCategoryId + '" id="editCategory" class="border-none btn btn-sm btn-success text-white mt-1 editCategory" > <i class="bi bi-pen-fill"></i></a>  <a data-id="'+ row.PkCategoryId + '" data-name="'+row.categoryName+'" id="deleteCategory" class="border-none btn btn-sm btn-danger text-white mt-1 deleteCategory" > <i class="bi bi-trash"></i></a>'				
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
        $("#addCategory").on("click", function () {
            $("#addCategoryData").modal('show');
            $('#PkCategoryId').val(0);
            createFilePond();
            getParentCategory();
        });
        var validator =$("#addCategoryForm").validate({
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
    
        $("#categoryDataTable").on("click", ".editCategory", function () { 
            var id = $(this).attr("data-id");
            var parentId =  $(this).attr("data-parentid");
            createFilePond();
            $("#addCategoryData").modal('show');
            $('#PkCategoryId').val(id);
            $(".modal-title").html("Update Category");
            if (parentId == 0) {
                getParentCategory(id);
            } else {
                getParentCategory();
            }
            $.ajax({
                type: "GET",
                url: "../ajaxAddCategory.cfm?PkCategoryId="+ id,
                success: function(result) {
                    if (result.success) {
                        var image = result.json.categoryImage;
                        if (parentId > 0 ) {
                            setTimeout(() => {
                                $('#parentCategory').val(parentId).trigger("change");
                            }, 150);
                        }
                        $("#PkCategoryId").val(result.json.PkCategoryId);
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
                        
                    }
                }   
            });
        });
        $('#addCategoryData').on('hidden.bs.modal', function () {
            $("#addCategoryForm").trigger('reset');
            validator.resetForm();
            $('#imgPreview').attr('src', ''); 
            $("#parentCategory").val(0).trigger("change");  
            $('.removeImageContainer').addClass('d-none')
            $(".modal-title").html("Add Category");
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
                        url: '../ajaxAddCategory.cfm?delPkCategoryId='+id, 
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
                            url: '../ajaxAddCategory.cfm?statusId='+id,  
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
                            url: '../ajaxAddCategory.cfm?statusId='+id,  
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
    function getParentCategory(PkCategoryId=0) {
        var EditCategoryId = $('#PkCategoryId').val();

        $.ajax({    
            type: "GET",
            url: "../ajaxAddCategory.cfm?formAction=getCategory", 
            dataType: "html",   
            data: {PkCategoryId: PkCategoryId, EditCategoryId :EditCategoryId},          
            success: function(result){
                let dataRecord = JSON.parse(result);
                if (dataRecord.success) {
                    $('#parentCategory').html('');
                    var html = "";
                    html = "<option value='0'>Select As A Parent</option>";
                    /* for (var i = 0; i < dataRecord.categoryList.length; i++) {
                        html += "<option value="+dataRecord.categoryList[i].PKCATEGORYID+" >"+dataRecord.categoryList[i].CATNAME+"</option>";
                    } */
                    $.each(dataRecord.categoryList, function( data, value, i ) {
                        html += "<option value="+value.PKCATEGORYID+">" + value.CATNAME +"</option>";
                    });
                    $('#parentCategory').append(html);
                }
                
            }
        }); 
    }
    function submitCategoryData() {
        var formData = new FormData($('#addCategoryForm')[0]);
        $.ajax({
            type: "POST",
            url: "../ajaxAddCategory.cfm?PkCategoryId=" + $('#PkCategoryId').val(),
            data: formData,
            contentType: false,
            processData: false,
            success: function(result) {
                if ($('#PkCategoryId').val() > 0) {
                    successToast("Category Updated!","Category Successfully Updated");
                } else{
                    successToast("Category Add!","Category Successfully Added");
                }
                
                $("#addCategoryData").modal('hide');
                $('#addCategoryData').on('hidden.bs.modal', function () {
                    $("#addCategoryForm").trigger('reset');
                    $('#imgPreview').attr('src', '');
                    $("#parentCategory").val('');
                    FilePond.destroy();
                });
                $('#categoryDataTable').DataTable().ajax.reload();
            }
        });
    }
    
</script>