<cfoutput>
    <cfparam name="PkCategoryId" default="" />
    <cfparam name="categoryName" default="" />
    <cfparam name="categoryImage" default="" />
    <cfif structKeyExists(url, 'DelPkCategoryId') AND url.DelPkCategoryId GT 0>
        <cfquery name="removeImage" dbtype="query">
            SELECT PkCategoryId, categoryImage FROM getCategoryData 
            WHERE PkCategoryId = <cfqueryparam value="#url.DelPkCategoryId#" cfsqltype = "cf_sql_integer">
        </cfquery>
        <cfif fileExists("#ExpandPath('./assets/categoryImage/')##removeImage.categoryImage#")>
            <cffile action="delete" file="#ExpandPath('./assets/categoryImage/')##removeImage.categoryImage#">
        </cfif>
        <cfquery result="deleteCategoryData">
            UPDATE category SET
            isDeleted = <cfqueryparam value="1" cfsqltype = "cf_sql_integer">
            WHERE PkCategoryId = <cfqueryparam value="#url.DelPkCategoryId#" cfsqltype = "cf_sql_integer">
        </cfquery>
        <cfset session.user.deleteCategory = 1>
        <cflocation url="index.cfm?pg=category&s=categoryList" addtoken="false">
    </cfif>
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
                        <i class="bi bi-plus-lg"></i>
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
                            <form class="form p-3" id="addCategoryForm" method="POST" action="" enctype="multipart/form-data">
                                <input type="hidden" id="PkCategoryId" value="" name="PkCategoryId">
                                <div class="row g-3">
                                    <div class="col-md-12">
                                        <lable class="fw-bold form-label" for="categoryName">Category Name</lable>
                                        <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                            <input type="text" class="form-control form-control-xl" id="categoryName" value="" name="categoryName"  placeholder="Category Name"/>
                                            <div class="form-control-icon">
                                                <i class="bi bi-person"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <lable class="fw-bold form-label text-center" for="categoryImage">Category Image</lable>
                                        <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                            <input type="file" class="form-control form-control-xl" name="categoryImage" id="categoryImage"  aria-describedby="inputGroupPrepend">
                                            <!-- File uploader with image preview -->
                                            <!---  <input type="file" class="image-preview-filepond" name="categoryImage" id="categoryImage"/> --->
                                        </div>
                                        <img id="imgPreview" src="" class="w-25 mt-2 mb-3">
                                        <!--- <cfif structKeyExists(form, categoryImage) AND len(categoryImage) GT 0>
                                            <img id="imgPreview" src="./assets/categoryImage/#categoryImage#" class="w-25 mt-2 mb-3">
                                        <cfelse>
                                            <img id="imgPreview" src="" class="w-25 mt-2 mb-3">
                                        </cfif> --->
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
                                    <button type="submit" id="defaultUploadSubmit" class="btn btn-primary ms-1" >
                                        <i class="bx bx-check d-block d-sm-none"></i>
                                        <span class="d-none d-sm-block">Upload</span>
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table" id="categoryDataTable">
                            <thead>
                                <tr>
                                    <th>Name</th>
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
        $('#categoryDataTable').DataTable({
            processing: true,
            pageLength: 10,
            pagination: 'datatablePagination',
            order: [[0, 'asc']],
            responsive: true,
            serverSide:true,
            pagingType: "full_numbers",
            ajax: {
                url: "../ajaxAddCategory.cfm?formAction=getRecord",
                type :'post',
                data: function(d){
                    console.log(d);
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
                { data: 'categoryName' },
                { data: 'categoryImage',
                    render: function(data, display, row) {
                        return '<img class="image" src="../assets/categoryImage/'+data+'" width="80">' 
                    }
                },
                { data: 'userName' },
                { data: 'dateCreated' },
                { data: 'userNameUpdate' },
                { data: 'dateUpdated' },
                { data: 'isActive',
                    render: function (data,type,row) {
                        if(row.isActive == 1){
                           /*  return '<span id="active" class="badge bg-success text-white" >Active</span>'; */
                            return '<span id="deactive" data-id="'+row.PkCategoryId+'" data-status="Active" data-name="'+row.categoryName+'" class=" badge bg-success text-white changeStatus"  data-toggle="tooltip" data-html="true" title="Click to Deactive Category" data-placement="bottom">Active</span>';
                        }else{
                            return '<span id="active" data-id="'+row.PkCategoryId+'" data-status="Deactive" data-name="'+row.categoryName+'" class="badge bg-danger text-white changeStatus" data-toggle="tooltip" data-html="true" title="Click to Active category" data-placement="bottom">Inactive</span>';
                            /* return '<span id="inActive" class="badge bg-danger text-white" >Inactive</span>'; */
                        }
                    }
                },
                { data: 'PkCategoryId',
                    render: function(data, type, row, meta)
                    {
                        return '<a data-id="'+row.PkCategoryId+'"  id="editCategory" class="border-none btn btn-sm btn-success text-white mt-1 editCategory" > <i class="bi bi-pen-fill"></i></a>  <a data-id="'+row.PkCategoryId+'" " id="deleteCategory" class="border-none btn btn-sm btn-danger text-white mt-1 deleteCategory" > <i class="bi bi-trash"></i></a>'				
                    }
                },
            ],
            
        });
        // open add category model
        $("#addCategory").on("click", function () {
            $("#addCategoryData").modal('show');
            $('#PkCategoryId').val(0);
        });
        $("#addCategoryForm").validate({
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
                /* form.preventDefault(); */
                var formData = new FormData($('#addCategoryForm')[0]);
                $.ajax({
                    type: "POST",
                    url: "../ajaxAddCategory.cfm?PkCategoryId=" + $('#PkCategoryId').val(),
                    data: formData,
                    contentType: false, //this is required please see answers above
                    processData: false, //this is required please see answers above
                    success: function(result) {
                        successToast("Category Add!","Category Successfully Added");
                        setTimeout(() => {
                            location.href = 'index.cfm?pg=category&s=categoryList';
                        }, 1000);
                    }
                });
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
    
        /* $('.editCategory').click(function() {
            var id = $(this).attr("data-id");
            console.log(id);
            $("#addCategoryData").modal('show');
            $('#PkCategoryId').val(id);
            if (id == 0) {
                $(".modal-title").html("Add Category");
                $("#addCategoryForm").trigger('reset');
                $('#imgPreview').attr('src', '');
            } else {
                $(".modal-title").html("Update Category");
                $.ajax({
                    url:  "../ajaxAddCategory.cfm?PkCategoryId="+ id,
                    type: 'GET',
                    success: function(result) {
                        if (result.success) {
                            $("#PkCategoryId").val(result.json.PkCategoryId);
                            $('#categoryName').val(result.json.categoryName);
                            let imgSrc = '../assets/categoryImage/' + result.json.categoryImage;
                            $('#imgPreview').attr('src', imgSrc);
                            if(result.json.isActive == 1){ 
                                $('#isActive').prop('checked', true);
                            } else{
                                $('#isActive').prop('checked', false);
                            }
                        }
                    } 
                });
                //successToast("Category Updated!");
            }
        }); */
        $("#categoryDataTable").on("click", ".editCategory", function () { 
            var id = $(this).attr("data-id");
            $("#addCategoryData").modal('show');
            $('#PkCategoryId').val(id);
            $(".modal-title").html("Update Category");
            $.ajax({
                type: "GET",
                url: "../ajaxAddCategory.cfm?PkCategoryId="+ id,
                success: function(result) {
                    $("#PkCategoryId").val(result.json.PkCategoryId);
                    $('#categoryName').val(result.json.categoryName);
                    let imgSrc = '../assets/categoryImage/' + result.json.categoryImage;
                    $('#imgPreview').attr('src', imgSrc);
                    if(result.json.isActive == 1){ 
                        $('#isActive').prop('checked', true);
                    } else{
                        $('#isActive').prop('checked', false);
                    }
                    $('#addCategoryData').on('hidden.bs.modal', function () {
                        $("#addCategoryForm").trigger('reset');
                        $('#imgPreview').attr('src', '');
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
                               /*  toast("Deactivated", "Permission Deactivated Successfully", "error"); */
                                infoToast("Deactivated!","Category Deactivated Successfully");
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
                                //toast("Activated", "Permission Activated Successfully", "success");
                                $('#categoryDataTable').DataTable().ajax.reload();                       
                            }  
                        });
                    }
                });
            }
        });
    });
    
</script>