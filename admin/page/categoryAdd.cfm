<cfoutput>
    <cfparam name="PkCategoryId" default="" />
    <cfparam name="categoryName" default="" />
    <cfparam name="categoryImage" default="" />
    <cfdump var="#form#">
    <cfdump var="#url.PkCategoryId#">

    <cfif structKeyExists(url, "PkCategoryId") AND url.PkCategoryId GT 0>
        <cfquery name="editCategoryData">
            SELECT PkCategoryId, categoryName, categoryImage FROM category WHERE PkCategoryId = <cfqueryparam value="#PkCategoryId#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfset PkCategoryId = editCategoryData.PkCategoryId>
        <cfset categoryName = editCategoryData.categoryName>
        <cfset categoryImage = editCategoryData.categoryImage>
    </cfif>

    <cfif structKeyExists(form, "categoryName") AND len(form.categoryName )GT 0>

        <cfif structKeyExists(form, "categoryImage") AND len(form.categoryImage) GT 0>
            <cfset txtcategoryImage = "">
            <cfset categoryImagePath = ExpandPath('./assets/categoryImage/')>

            <cffile action="upload" destination="#categoryImagePath#" fileField="form.categoryImage" nameconflict="makeunique" result="dataImage">
            <cfset txtcategoryImage = dataImage.serverfile>

            <cfif fileExists("#categoryImagePath##categoryImage#")>
                <cffile action="delete" file="#categoryImagePath##categoryImage#">
            </cfif>
        <cfelse>
            <cfset txtcategoryImage = "">
        </cfif>
        
        <cfif structKeyExists(url, "PkCategoryId") AND url.PkCategoryId GT 0>
            <cfquery name="updateCategoryData">
                UPDATE category SET                            
                PkCategoryId = <cfqueryparam value = "#form.PkCategoryId#" cfsqltype = "cf_sql_integer">
                , categoryName = <cfqueryparam value = "#form.categoryName#" cfsqltype = "cf_sql_varchar">
                , categoryImage = <cfqueryparam value = "#txtcategoryImage#" cfsqltype = "cf_sql_varchar">
                , updatedBy =  <cfqueryparam value = "#session.user.isLoggedIn#" cfsqltype = "cf_sql_integer">
                WHERE PkCategoryId = <cfqueryparam value = "#form.PkCategoryId#" cfsqltype = "cf_sql_integer">
            </cfquery> 
            <cfset session.user.categoryUpdate = 1>
            <cflocation url="index.cfm?pg=category&s=categoryList" addtoken="false">
        <cfelse>
            <cfquery result="addCategoryData">
                INSERT INTO category (
                    PkCategoryId
                    , categoryName
                    , categoryImage
                    , createdBy
                ) VALUES (
                    <cfqueryparam value = "#form.PkCategoryId#" cfsqltype = "cf_sql_integer">
                    , <cfqueryparam value = "#form.categoryName#" cfsqltype = "cf_sql_varchar">
                    , <cfqueryparam value = "#txtcategoryImage#" cfsqltype = "cf_sql_varchar">
                    , <cfqueryparam value = "#session.user.isLoggedIn#" cfsqltype = "cf_sql_integer">
                )
            </cfquery>
            <cfset session.user.categorySave = 1>
            <cflocation url="index.cfm?pg=category&s=categoryList" addtoken="false">
        </cfif> 
    </cfif>

    <div class="page-heading">
        <div class="page-title">
            <div class="row">
                <div class="col-12 col-md-6 order-md-1 order-last">
                    <h1>Add Category</h1>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="index.cfm?pg=category&s=categoryList">Category</a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">
                                Add Category
                            </li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
        <!-- Data Tables start -->
        <section class="section">
            <div class="card">
                <div class="card-header d-flex justify-content-end">
                    <a href="index.cfm?pg=category&s=categoryList" class="" >
                        <button class="btn btn-primary" name="addProduct" id="addProduct">
                            <i class="bi bi-arrow-left fs-5"></i>
                        </button>
                    </a>
                </div>
                <div class="card-body">
                    <form class="form" id="addCategoryForm" method="POST" action="" enctype="multipart/form-data">
                        <input type="hidden" value="#PkCategoryId#" name="PkCategoryId">
                        <div class="row">
                            <div class="col-md-6">
                                <lable class="fw-bold form-label" for="categoryName">Category Name</lable>
                                <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                    <input type="text" class="form-control form-control-xl" id="categoryName" value="#categoryName#" name="categoryName"  placeholder="Category Name"/>
                                    <div class="form-control-icon">
                                        <i class="bi bi-person"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <lable class="fw-bold form-label text-center" for="categoryImage">Category Image</lable>
                                <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                    <input type="file" class="form-control form-control-xl" name="categoryImage" id="categoryImage"  aria-describedby="inputGroupPrepend" onchange="readURL(this)">
                                    <!-- File uploader with image preview -->
                                    <!---  <input type="file" class="image-preview-filepond" name="categoryImage" id="categoryImage"/> --->
                                </div>
                                <cfif len(categoryImage) GT 0>
                                    <img id="imgPreview" src="./assets/categoryImage/#categoryImage#" class="w-25 mt-2 mb-3"> 
                                <cfelse>
                                    <img id="imgPreview" src="" class="w-25 mt-2 mb-3">
                                </cfif> 
                            </div>
                        </div>
                        <div class="col-2 mx-auto">
                            <button type="submit" class="btn btn-primary btn-block btn-lg shadow-lg mx-auto">
                                Save
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </section>
        <!-- Data Tables end -->
    </div>
</cfoutput>
<script> 
    $( document ).ready(function() {
        $("#addCategoryForm").validate({
            rules: {
                categoryName: {
                    required: true
                },/* 
                categoryImage: {
                    required: true,
                } */
            },
            errorPlacement: function (error, element) {
                error.insertAfter($(element).parent('div')); 
            },
            messages: {
                categoryName: {
                    required: "Please enter category name",                    
                },   /* 
                categoryImage: {
                    required: "Please select category image",                    
                },  */
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
            } 
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
    });
</script>