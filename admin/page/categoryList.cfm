<cfoutput>
    <cfparam name="PkCategoryId" default="" />
    <cfparam name="categoryName" default="" />
    <cfparam name="categoryImage" default="" />
<!---     <cfdump var="#form#"> --->
    <!--- <cfdump var="#url.PkCategoryId#"> --->
    <cfquery name="getCategoryData">
        SELECT C.PkCategoryId, C.categoryName, C.categoryImage, C.isActive, C.createdBy, C.updatedBy, C.dateCreated, C.dateUpdated, C.isDeleted, U.PkUserId, CONCAT_WS(" ", U.firstName, U.lastName) AS userName
        FROM category C
        LEFT JOIN users U ON C.createdBy = U.PkUserId  
        WHERE isDeleted = <cfqueryparam value="0" cfsqltype = "cf_sql_integer">
    </cfquery>
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
                    <!---  <a href="<!--- index.cfm?pg=category&s=categoryAdd&PkCategoryId=0 --->" class="" > --->
                        <button class="btn btn-primary" name="addCategory" data-bs-toggle="model" id="addCategory">
                            <i class="bi bi-plus-lg"></i>
                        </button>
                    <!---    </a> --->
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
                                        <cfif structKeyExists(form, categoryImage) AND len(categoryImage) GT 0>
                                            <img id="imgPreview" src="./assets/categoryImage/#categoryImage#" class="w-25 mt-2 mb-3"> 
                                        <cfelse>
                                            <img id="imgPreview" src="" class="w-25 mt-2 mb-3">
                                        </cfif> 
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
                                <cfloop query="getCategoryData">
                                    <cfset statusId = getCategoryData.isActive>
                                    <cfif statusId EQ 1>
                                        <cfset statusColor = "bg-success">
                                        <cfset status = "Active">
                                    <cfelse>
                                        <cfset statusColor = "bg-danger">
                                        <cfset status = "Inactive">
                                    </cfif>
                                    <tr>
                                        <td>#getCategoryData.categoryName#</td>
                                        <td>
                                            <img id="" src="../assets/categoryImage/#getCategoryData.categoryImage#" width="50">
                                        </td>
                                        <td>#getCategoryData.userName#</td>
                                        <td>#dateTimeFormat(getCategoryData.dateCreated, 'dd-mm-yyyy')#</td>
                                        <td>
                                            <cfif getCategoryData.updatedBy GT 0>
                                                #getCategoryData.userName#
                                            </cfif>
                                        </td>
                                        <td>#dateTimeFormat(getCategoryData.dateUpdated, 'dd-mm-yyyy')#</td>
                                        <td>
                                            <span class="badge #statusColor#">#status#</span>
                                        </td>
                                        <td class="d-flex justify-content-between">
                                            <a <!--- onclick="editCategory()" ---> data-id="#getCategoryData.PkCategoryId#" id="editCategory" class="border-none btn btn-sm btn-success text-white mt-1 editCategory" > 
                                                <i class="bi bi-pen-fill"></i>
                                            </a>
                                            <a onclick="return confirm('Are you sure to delete category ?');" href="index.cfm?pg=category&s=categoryList&DelPkCategoryId=#getCategoryData.PkCategoryId#">
                                                <button type="button" id="delete" class="border-none btn btn-sm btn-danger text-white ms-1 mt-1">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </a>
                                        </td>
                                    </tr>
                                </cfloop>
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
        /* $('#categoryDataTable').DataTable(); */
        $('#categoryDataTable').DataTable({
            processing: true,
            pageLength: 10,
            pagination: 'datatablePagination',
            order: [[0, 'asc']],
            responsive: true,
        });
        $("#addCategory").on("click", function () {
            $("#addCategoryData").modal('show')
            $('#PkCategoryId').val(0);
        });
        // open add category model
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
                var formData = new FormData($('#addCategoryForm')[0]);
                $.ajax({
                    type: "POST",
                    url: "../ajaxAddCategory.cfm?PkCategoryId=0",
                    data: formData,
                    // data: $('#addCategoryForm').serialize(),
                    contentType: false, //this is required please see answers above
                    processData: false, //this is required please see answers above
                    success: function(result) {
                        successToast("Category Add!");
                        setTimeout(() => {
                            location.href = 'index.cfm?pg=category&s=categoryList';
                        }, 1000);
                        $('#categoryDataTable').DataTable().ajax.reload();
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
        $("#categoryDataTable").on("click", "#editCategory", function () { 
            var id = $(this).attr("data-id");
            $("#addCategoryData").modal('show');
            $('#PkCategoryId').val($(this).attr("data-id"));
            console.log('getId', id);
            $(".modal-title").html("Update Category");
            $.ajax({  
                url:  "../ajaxAddCategory.cfm?PkCategoryId="+ id,
                type: 'GET',
                success: function(result) {
                    console.log(result);
                    if(result){
                        $("#PkCategoryId").val(result.PkCategoryId);
                        $('#categoryName').val(result.categoryName);
                        $('#categoryImage').val(result.categoryImage);
                    }
                    $('#addCategoryData').on('hidden.bs.modal', function () {
                        $("#addCategoryForm").trigger('reset');
                        $(".modal-title").html("Add Permission");
                    });
                } 
            });
        });
    });
    /* function editCategory() {
        var id = $(this).attr("data-id");
        $("#addCategoryData").modal('show');
        $('#PkCategoryId').val($(this).attr("data-id"));
        console.log('getId', id);
        $(".modal-title").html("Update Category");
        $.ajax({  
            url:  "../ajaxAddCategory.cfm?PkCategoryId="+ id  ,
            type: 'GET',
            success: function(result) {
                console.log(result);
                if(result){
                    $("#PkCategoryId").val(result.PkCategoryId);
                    $('#categoryName').val(result.categoryName);
                    $('#categoryImage').val(result.categoryImage);
                }
                $('#addCategoryData').on('hidden.bs.modal', function () {
                    $("#addCategoryForm").trigger('reset');
                    $(".modal-title").html("Add Permission");
                });
            } 
        });
    } */
</script>