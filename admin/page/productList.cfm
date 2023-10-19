<cfoutput>
    <cfparam name="PkProductId" default="" />
    <cfparam name="FkCategoryId" default="" />
    <cfparam name="productName" default="" />
    <cfparam name="productQty" default="" />
    <cfparam name="productImage" default="" />
    <cfparam name="productPrice" default="" />
    <div class="page-heading">
        <div class="page-title">
            <div class="row">
                <div class="col-12 col-md-6 order-md-1 order-last">
                    <h1>Product</h1>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="index.cfm?pg=dashboard">Dashboard</a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">
                                Products
                            </li>
                        </ol>
                    </nav>
                </div>
                <cfif structKeyExists(session.user, 'productSave') AND session.user.productSave EQ 1>
                    <div class="alert alert-light-success alert-dismissible show fade">
                        <i class="bi bi-check-circle"></i> Product Data successfully inserted..!!!
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <cfset StructDelete(session.user,'productSave')>
                <cfelseif structKeyExists(session.user, 'productUpdate') AND session.user.productUpdate EQ 1>
                    <div class="alert alert-light-success alert-dismissible show fade">
                        <i class="bi bi-check-circle"></i> Product Data successfully updated..!!!
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <cfset StructDelete(session.user,'productUpdate')>
                </cfif>
            </div>
        </div>
        <!-- Data Tables start -->
        <section class="section">
            <div class="card">
                <div class="card-header d-flex justify-content-end">
                    <button class="btn btn-primary editProduct"  name="addProduct" data-bs-toggle="model" id="addProduct" data-id="0">
                        <i class="bi bi-plus-lg "></i><span class="ms-2 pt-1">Add Product</span>
                    </button>
                </div>
                <div class="modal fade" id="addProductData" tabindex="-1" role="dialog" aria-labelledby="addProductData" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header bg-primary">
                                <h5 class="modal-title white">
                                    Add Product
                                </h5>
                                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                    <i data-feather="x"></i>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form class="form p-3" id="addProductForm" method="POST" action="" enctype="multipart/form-data">
                                    <input type="hidden" id="PkProductId" value="" name="PkProductId">
                                    <div class="row g-3">
                                        <div class="col-md-12">
                                            <lable class="fw-bold form-label" for="category">Category Name</lable>
                                            <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                                <select name="category" id="category" class="form-control" data-placeholder="Select Category">
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <lable class="fw-bold form-label" for="productName">Product Name</lable>
                                            <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                                <input type="text" class="form-control " id="productName" value="" name="productName"  placeholder="Enter Product Name"/>
                                                <div class="form-control-icon">
                                                    <i class="bi bi-tag-fill"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <lable class="fw-bold form-label" for="productPrice">Product Price</lable>
                                            <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                                <input type="number" class="form-control " id="productPrice" value="" name="productPrice"  placeholder="Enter Product Price"/>
                                                <div class="form-control-icon">
                                                    <i class="bi bi-currency-rupee"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <lable class="fw-bold form-label" for="productQty">Product Qtuantity</lable>
                                            <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                                <input type="number" class="form-control " id="productQty" value="" name="productQty"  placeholder="Enter Product Qty"/>
                                                <div class="form-control-icon">
                                                    <i class="bi bi-plus-circle"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <lable class="fw-bold form-label" for="productDescription">Product Description</lable>
                                            <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                                <textarea rows="1" cols="" class="form-control" id="productDescription" name="productDescription"></textarea>
                                                <div class="form-control-icon">
                                                    <i class="bi bi-pen"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <lable class="fw-bold form-label" for="productTags">Product Tags</lable>
                                            <div class="form-group">
                                                <select name="productTags" id="productTags" class="form-control productTagMultiple" data-placeholder="Select Product Tags" multiple>
                                                    <option></option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <lable class="fw-bold form-label text-center" for="productImage">Product Image</lable>
                                            <div class="form-group position-relative mb-4 mt-2">
                                                <input type="file" class="form-control form-control-xl image-preview-filepond" multiple id="productImage" >
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
                                <div class="table-responsive productImageContainer d-none">
                                    <table class="table" id="productImageDataTable">
                                        <thead>
                                            <tr>
                                                <th>SI No.</th>
                                                <th>Image</th>
                                                <th>Create By</th>
                                                <th>Create Date</th>
                                                <th>Default Image</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table nowrap" id="productDataTable">
                            <thead>
                                <tr>
                                    <th>Product Name</th>
                                    <th>Category Name</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
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
        FilePond.registerPlugin(
            FilePondPluginImagePreview,
            FilePondPluginImageCrop,
            FilePondPluginImageExifOrientation,
            FilePondPluginImageFilter,
            FilePondPluginImageResize,
            FilePondPluginFileValidateSize,
            FilePondPluginFileValidateType
        )
        let filepondImageObj = {};
        function createFilePond() {
            const filepondInput = document.querySelector(".image-preview-filepond");
            const filePondName  = filepondInput.setAttribute("name", "filepond[]");
            const filePondMultiple  = filepondInput.setAttribute("multiple", true);
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
            filepondImageObj = filepondImage;
        }
        Fancybox.bind("[data-fancybox]", {
            fillRatio: 0.9,
        });
        $('#category').select2({
            /* placeholder: "Please Select Category",
            width: '100%',
            allowClear: true, */
            theme: "bootstrap-5",
            width: $( this ).data( 'width' ) ? $( this ).data( 'width' ) : $( this ).hasClass( 'w-100' ) ? '100%' : 'style',
            placeholder: $( this ).data( 'placeholder' ),
            dropdownParent: $('#addProductData'),
            allowClear: true,
        });
        $('#productTags').select2({
            theme: "bootstrap-5",
            width: $( this ).data( 'width' ) ? $( this ).data( 'width' ) : $( this ).hasClass( 'w-100' ) ? '100%' : 'style',
            placeholder: $( this ).data( 'placeholder' ),
            closeOnSelect: false,
            allowClear: true,
            dropdownParent: $('#addProductData'),
        });
        $('#productDataTable').DataTable({
            processing: true,
            destroy: true,
            pageLength: 10,
            pagination: 'datatablePagination',
            order: [[1, 'desc']],
            serverSide:true,
            responsive: true,
            autoWidth: false,
            columnDefs: [
                { "width": "40%", "targets": [0,1,2,3,4,5,6,7,8,9] }
            ],
            pagingType: "full_numbers",
            dom: 'l<"toolbar">frtip',
            ajax: {
                url: "../ajaxAddProduct.cfm?formAction=getRecord",
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
                { data: 'productName'},
                { data: 'categoryName' },
                { data: 'productQty' },
                { data: 'productPrice' },
                { data: 'userName' },
                { data: 'dateCreated' },
                { data: 'userNameUpdate' },
                { data: 'dateUpdated' },
                { data: 'isActive',
                    render: function (data,type,row) {
                        if(row.isActive == 1){
                            return '<span id="deactive" data-id="'+row.PkProductId+'" data-status="Active" data-name="'+row.productName+'" class=" badge bg-success text-white changeStatus"  data-toggle="tooltip" data-html="true" title="Click to Deactive Product" data-placement="bottom">Active</span>';
                        }else{
                            return '<span id="active" data-id="'+row.PkProductId+'" data-status="Deactive" data-name="'+row.productName+'" class="badge bg-danger text-white changeStatus" data-toggle="tooltip" data-html="true" title="Click to Active product" data-placement="bottom">Inactive</span>';
                        }
                    }
                },
                { data: 'PkProductId',
                    render: function(data, type, row, meta)
                    {
                        var returnStr = '';
                        if(row.isDeleted == 1){
                            returnStr += '<a data-id="'+ row.PkProductId + '" data-name="'+row.productName+'" id="restoreProduct" class="border-none btn btn-sm btn-warning text-white mt-1 restoreProduct"><i class="fas fa-undo"></i></a>'	
                        } else{
                            returnStr += '<a data-id="'+row.PkProductId+'"  id="editProduct" class="border-none btn btn-sm btn-success text-white mt-1 editProduct" > <i class="bi bi-pen-fill"></i></a>  <a data-id="'+row.PkProductId+'" data-name="'+row.productName+'" id="deleteProduct" class="border-none btn btn-sm btn-danger text-white mt-1 deleteProduct" > <i class="bi bi-trash"></i></a>'				
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
            $('#productDataTable').DataTable().ajax.reload();
        });
        // open add product model
        $("#addProduct").on("click", function () {
            $("#addProductData").modal('show');
            $('#PkProductId').val(0);
            createFilePond();
            getCategory();
        });
        var validator = $("#addProductForm").validate({
            rules: {
                productName: {
                    required: true
                },
                productPrice: {
                    required: true,
                    digits:true
                },
                productQty: {
                    required: true,
                    digits:true
                },
                category: {
                    required: true
                },
                productDescription: {
                    required: true
                }
            },
            errorPlacement: function (error, element) {
                error.insertAfter($(element).parent('div')); 
            },
            messages: {
                productName: {
                    required: "Please enter product name",                    
                },
                category: {
                    required: "Please select category",                    
                },
                productPrice: {
                    required: "Please enter product price",                    
                },
                productQty: {
                    required: "Please enter product quantity",                    
                },
                productDescription: {
                    required: "Please enter product description",                    
                },
            },
            ignore: [],
            errorElement: 'span',
            errorPlacement: function (error, element) {
                console.log(element);
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
                event.preventDefault();
                if ($('#PkProductId').val() == 0) {
                    if (filepondImageObj.getFiles().length === 0) {
                        dangerToast("Issue!","Please upload Atleast 1 image!!!");
                    } else {
                        submitProductData();
                    }
                } else {
                    submitProductData();
                }
            }, 
        });

        $('#addProductData').on('hidden.bs.modal', function () {
            $("#addProductForm").trigger('reset');
            validator.resetForm();
            $('.productImageContainer').addClass('d-none');
            $("#category").val(); 
            $("#productTags").val('').trigger("change");
            FilePond.destroy(); 
        });
        $("select").on("select2:close", function (e) {  
            $(this).valid(); 
        });
        $("#category").change(function(){
            var categoryId = $("#category option:selected").val();
            getTag(parseInt(categoryId));
        }); 
        $("#productDataTable").on("click", ".editProduct", function () { 
            var id = $(this).attr("data-id");
            createFilePond();
            $("#addProductData").modal('show');
            $('#PkProductId').val(id);
            $(".modal-title").html("Update Product");
            $.ajax({
                type: "GET",
                url: "../ajaxAddProduct.cfm?PkProductId="+ id,
                success: function(result) {
                    if (result.success) {
                        $("#PkProductId").val(result.json.PkProductId);
                        $('#productName').val(result.json.productName);
                        $('#productPrice').val(result.json.productPrice);
                        $('#productQty').val(result.json.productQty);
                        $('#productDescription').val(result.json.productDescription);
                        getCategory(result.json.FkCategoryId,result.json.product_tags);
                        $('#productTags').val(result.json.product_tags).trigger('change');
                        if (result.json.PkProductId > 0) {
                            $('.productImageContainer').removeClass('d-none');
                            $('#productImageDataTable').DataTable({
                                processing: true,
                                destroy: true,
                                pageLength: 10,
                                pagination: 'datatablePagination',
                                order: [[1, 'desc']],
                                serverSide:true,
                                responsive: true,
                                autoWidth: false,
                                columnDefs: [
                                    { "width": "40%", "targets": [0,1,2,3,4,5] }
                                ],
                                pagingType: "full_numbers",
                                ajax: {
                                    url: "../ajaxAddProduct.cfm?formAction=getProductImageRecord",
                                    type :'post',
                                    data: function(d){
                                        var sIdx = d.order[0].column;
                                        var m = {};
                                        m['draw'] = d.draw;
                                        m["start"] = d.start;
                                        m["length"] = d.length;
                                        m["search"] = d.search.value;
                                        m["FkProductId"] = $("#PkProductId").val()
                                        m["order"] = d.columns[sIdx].data + ' ' + d.order[0].dir;
                                        return m;
                                    }
                                },
                                columns: [
                                    { data: 'sNo' },
                                    { data: 'image',
                                        render: function(data, display, row) {
                                            var returnStr = '';
                                            if (data !== "") {
                                                returnStr+=  '<a data-fancybox="imgPreview" data-src="'+data+'"><img data-fancybox="group" class="image" src="/assets/productImage/'+data+'" width="80" height="80">' 
                                            } 
                                            return returnStr;
                                        }
                                    },
                                    { data: 'userName' },
                                    { data: 'dateCreated' },
                                    { data: 'isDefault',
                                        render: function (data,type,row) {
                                            if (row.isDefault == 1) {
                                                return '<div class="form-check form-switch"><input class="form-check-input changeDefault" name="isDefault" type="radio" role="switch" id="default" checked data-default = "'+row.isDefault+'" data-id="'+row.PkImageId+'" data-pId="'+row.PkProductId+'"  data-name="'+row.productName+'" data-bs-toggle="tooltip" data-bs-html="true" title="Click to Un Default Product Image" data-bs-placement="bottom"></div>'
                                            } else{
                                                return '<div class="form-check form-switch"><input class="form-check-input changeDefault" name="isDefault" type="radio" role="switch" id="default" data-default = "'+row.isDefault+'" data-id="'+row.PkImageId+'" data-pId="'+row.PkProductId+'"  data-name="'+row.productName+'" data-bs-toggle="tooltip" data-bs-html="true" title="Click to Un Default Product Image" data-bs-placement="bottom"></div>'
                                            }
                                            
                                        }
                                    },
                                    { data: 'PkImageId',
                                        render: function(data, type, row, meta)
                                        {
                                            return '<a data-id="'+row.PkImageId+'" data-name="'+row.productName+'" id="deleteProductImage" class="border-none btn btn-sm btn-danger text-white mt-1 deleteProductImage" data-bs-toggle="tooltip" data-bs-html="true" title="Click to Delete Product Image" data-bs-placement="bottom" > <i class="bi bi-trash"></i></a>'				
                                        }
                                    },
                                ],
                                rowCallback : function(nRow, aData, iDisplayIndex){
                                    $("td:first", nRow).html(iDisplayIndex + 1);
                                    return nRow;
                                },
                            });
                            $("#productImageDataTable").on("click", ".deleteProductImage", function () { 
                                var id = $(this).attr("data-id");
                                var name = $(this).data("name");
                                Swal.fire({
                                    title: 'Are you sure?',
                                    text: 'You want to delete product image record for ' + '"' +  name + '"',
                                    icon: 'warning',
                                    showCancelButton: true,
                                    confirmButtonColor: '#dc3545',
                                    confirmButtonText: 'Yes, delete it!'
                                }).then((result) => {
                                    if (result.isConfirmed) {
                                        $.ajax({  
                                            url: '../ajaxAddProduct.cfm?delPkImageId='+id, 
                                            type: 'GET',  
                                            success: function(data) {
                                                dangerToast("Deleted!","Product Image Deleted Successfully");
                                                $('#productImageDataTable').DataTable().ajax.reload();               
                                            }  
                                        });
                                    }
                                });
                            });
                            $("#productImageDataTable").on("change", ".changeDefault", function () {
                                var id = $(this).attr("data-id");
                                var pId = $(this).attr("data-pId");
                                var name = $(this).attr("data-name");
                                var defaultId = $(this).attr("data-default");
                                var checked = $(this).prop('checked');
                                if (checked == false) {
                                    $.ajax({  
                                        url: '../ajaxAddProduct.cfm?&productId='+pId+'&defaultImageId='+id,  
                                        type: 'POST', 
                                        success: function(data) {
                                            successToast("Activated!","Product Image Is Default Set Successfully");
                                            $('#productImageDataTable').DataTable().ajax.reload();                       
                                        }  
                                    });
                                } else {
                                    Swal.fire({
                                        title: 'Are you sure?',
                                        text: 'You want to select default image for ' + '"' +  name + '"',
                                        icon: 'warning',
                                        showCancelButton: true,
                                        confirmButtonText: 'Yes, Default Set it!'
                                        }).then((result) => {
                                        if (result.isConfirmed) {
                                            $.ajax({  
                                                url: '../ajaxAddProduct.cfm?&productId='+pId+'&defaultImageId='+id,  
                                                type: 'POST', 
                                                success: function(data) {
                                                    successToast("Activated!","Product Image Is Default Set Successfully");
                                                    $('#productImageDataTable').DataTable().ajax.reload();                       
                                                }  
                                            });
                                        }
                                    });
                                }
                            }); 
                        }
                        if(result.json.isActive == 1){ 
                            $('#isActive').prop('checked', true);
                        } else{
                            $('#isActive').prop('checked', false);
                        }
                        $('#addProductData').on('hidden.bs.modal', function () {
                            $("#addProductForm").trigger('reset');
                            validator.resetForm();
                            $('.productImageContainer').addClass('d-none');
                            $(".modal-title").html("Add Product");
                            $("#category").val();  
                            $("#productTags").val('').trigger("change");
                        });
                    }
                }   
            });
        }); 
        $("#productDataTable").on("click", ".deleteProduct", function () { 
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
                        url: '../ajaxAddProduct.cfm?delPkProductId='+id, 
                        type: 'GET',  
                        success: function(data) {
                            dangerToast("Deleted!","Product Deleted Successfully");
                            $('#productDataTable').DataTable().ajax.reload();               
                        }  
                    });
                }
            });
        }); 
        $("#productDataTable").on("click", ".changeStatus", function () {
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
                            url: '../ajaxAddProduct.cfm?statusId='+id,  
                            type: 'POST',  
                            success: function(data) {
                                dangerToast("Deactivated!","Product Deactivated Successfully");
                                $('#productDataTable').DataTable().ajax.reload();                       
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
                            url: '../ajaxAddProduct.cfm?statusId='+id,  
                            type: 'POST',  
                            success: function(data) {
                                successToast("Activated!","Product Activated Successfully");
                                $('#productDataTable').DataTable().ajax.reload();                       
                            }  
                        });
                    }
                });
            }
        });
        $("#productDataTable").on("click", ".restoreProduct", function () { 
            var id = $(this).attr("data-id");
            var name = $(this).data("name");
            Swal.fire({
                title: 'Are you sure?',
                text: 'You want to restore product record for ' + '"' +  name + '"',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Yes, Restore it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({  
                        url: '../ajaxAddProduct.cfm?restorePkProductId='+id, 
                        type: 'GET',  
                        success: function(data) {
                            successToast("Restore!","Product Restore Successfully");
                            $('#productDataTable').DataTable().ajax.reload();               
                        }  
                    });
                }
            });
        }); 
    });
    function getCategory(catId=0, productTag='') {
        $.ajax({    
            type: "GET",
            url: "../ajaxAddProduct.cfm?formAction=getCategory", 
            dataType: "html",  
            data: catId,         
            success: function(data){
                let dataRecord = JSON.parse(data);
                if (dataRecord.success) {
                    var html = "";
                   /*  var htm2 = ""; */
                    $('#category').html('');
                    /* $('#productTags').html(''); */
                    /* var html = "<option>Select Category</option>"; */
                    /* for (var i = 0; i < dataRecord.categoryList.length; i++) {
                        html += "<option value="+dataRecord.categoryList[i].PKCATEGORYID+" >"+dataRecord.categoryList[i].CATNAME+"</option>";
                    } */
                    html = "<option value=''></option> ";
                    $.each(dataRecord.categoryList, function( data, value, i ) {
                        html += "<option value="+value.PkCategoryId+">" + value.catName +"</option>";
                    });
                    $('#category').append(html);
                    if (catId > 0) {
                        $('#category').val(catId);
                    } else {
                        $('#category').val();
                    }
                    getTag(parseInt(catId), productTag);
                }
            }
        }); 
    }
    function getTag(catid = 0, productTag = '') {
        if (catid > 0) {
            $.ajax({
                url: "../ajaxAddProduct.cfm?formAction=getProductTag&category_Id="+ catid,         
                type: "GET", 
                success: function(data) {
                    var html2 = "";
                    $('#productTags').html("");
                    html2 = "<option value=''></option>";
                    $.each(data.data, function( data, value ) {
                        html2 += "<option value="+value.PkTagId+">"+value.tagName+"</option>";
                    });
                    $('#productTags').append(html2);
                    
                    if (productTag.length > 0) {
                        $("#productTags").val(productTag).trigger("change");
                    }
                }
            });
        } else {
            $("#productTags").val('').trigger("change");
        }
    }
    function submitProductData() {
        var formData = new FormData($('#addProductForm')[0]);
        for (var [key, value] of formData.entries()) {
            if (key === "filepond[]" && value.name === "") {
                formData.delete(key);
            }
        }
        $.ajax({
            type: "POST",
            url: "../ajaxAddProduct.cfm?PkProductId=" + $('#PkProductId').val(),
            data: formData,
            contentType: false,
            processData: false,
            success: function(result) {
                if ($('#PkProductId').val() > 0) {
                    successToast("Product Updated!","Product Successfully Updated");
                    if (result.json.defaultCounter == 0) {
                        warnToast("Issue!","Default image is not selected!!!");
                    }
                } else{
                    successToast("Product Add!","Product Successfully Added");
                    warnToast("Issue!","Default image is not selected!!!");
                }
                $("#addProductData").modal('hide');
                $('#productDataTable').DataTable().ajax.reload();   
            }
        });
    }
</script>
