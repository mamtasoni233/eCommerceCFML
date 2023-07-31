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
                        <i class="bi bi-plus-lg"></i>
                    </button>
                </div>
                <div class="modal fade" id="addProductData" tabindex="-1" role="dialog" aria-labelledby="addProductData" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered  modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header bg-primary">
                                <h5 class="modal-title white">
                                    Add Product
                                </h5>
                                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                    <i data-feather="x"></i>
                                </button>
                            </div>
                            <form class="form p-3" id="addProductForm" method="POST" action="" enctype="multipart/form-data">
                                <input type="hidden" id="PkProductId" value="" name="PkProductId">
                                <div class="row g-3">
                                    <div class="col-md-12">
                                        <lable class="fw-bold form-label" for="category">Category Name</lable>
                                        <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                            <select name="category" id="category" class="form-control-xl" change="category()">
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <lable class="fw-bold form-label" for="productName">Product Name</lable>
                                        <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                            <input type="text" class="form-control form-control-xl" id="productName" value="" name="productName"  placeholder="Enter Product Name"/>
                                            <div class="form-control-icon">
                                                <i class="bi bi-tag-fill"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <lable class="fw-bold form-label" for="productPrice">Product Price</lable>
                                        <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                            <input type="text" class="form-control form-control-xl" id="productPrice" value="" name="productPrice"  placeholder="Enter Product Price"/>
                                            <div class="form-control-icon">
                                                <i class="bi bi-currency-rupee"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <lable class="fw-bold form-label" for="productQty">Product Qtuantity</lable>
                                        <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                            <input type="number" class="form-control form-control-xl" id="productQty" value="" name="productQty"  placeholder="Enter Product Qty"/>
                                            <div class="form-control-icon">
                                                <i class="bi bi-plus-circle"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <lable class="fw-bold form-label text-center" for="productImage">Product Image</lable>
                                        <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                            <input type="file" class="form-control form-control-xl" name="productImage" id="productImage"  aria-describedby="inputGroupPrepend">
                                        </div>
                                        <img id="imgPreview" src="" class="w-25 mt-2 mb-3">
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
                        <table class="table" id="productDataTable">
                            <thead>
                                <tr>
                                    <th>Product Name</th>
                                    <th>Category Name</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
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
        $('#category').select2({
            //placeholder: "Select a parent category",
            width: '100%' 
        });
        $('#productDataTable').DataTable({
            processing: true,
            pageLength: 10,
            pagination: 'datatablePagination',
            order: [[1, 'desc']],
            responsive: true,
            serverSide:true,
            pagingType: "full_numbers",
            ajax: {
                url: "../ajaxAddProduct.cfm?formAction=getRecord",
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
                { data: 'productName'},
                { data: 'categoryName' },
                { data: 'productQty' },
                { data: 'producPrice' },
                { data: 'productImage',
                    render: function(data, display, row) {
                        var returnStr = '';
                        if (data !== "") {
                            returnStr+=  '<img class="image" src="../assets/productImage/'+data+'" width="80">' 
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
                            return '<span id="deactive" data-id="'+row.PkProductId+'" data-status="Active" data-name="'+row.productName+'" class=" badge bg-success text-white changeStatus"  data-toggle="tooltip" data-html="true" title="Click to Deactive Category" data-placement="bottom">Active</span>';
                        }else{
                            return '<span id="active" data-id="'+row.PkProductId+'" data-status="Deactive" data-name="'+row.productName+'" class="badge bg-danger text-white changeStatus" data-toggle="tooltip" data-html="true" title="Click to Active category" data-placement="bottom">Inactive</span>';
                        }
                    }
                },
                { data: 'PkProductId',
                    render: function(data, type, row, meta)
                    {
                        return '<a data-id="'+row.PkProductId+'"  id="editProduct" class="border-none btn btn-sm btn-success text-white mt-1 editProduct" > <i class="bi bi-pen-fill"></i></a>  <a data-id="'+row.PkProductId+'" data-name="'+row.productName+'" id="deleteProduct" class="border-none btn btn-sm btn-danger text-white mt-1 deleteProduct" > <i class="bi bi-trash"></i></a>'				
                    }
                },
            ],
            
        });
        // open add category model
        $("#addProduct").on("click", function () {
            $("#addProductData").modal('show');
            $('#PkProductId').val(0);
            getProduct();
        });
        $("#addProductForm").validate({
            rules: {
                productName: {
                    required: true
                }
            },
            errorPlacement: function (error, element) {
                error.insertAfter($(element).parent('div')); 
            },
            messages: {
                productName: {
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
                var formData = new FormData($('#addProductForm')[0]);
                $.ajax({
                    type: "POST",
                    url: "../ajaxAddProduct.cfm?PkProductId=" + $('#PkProductId').val(),
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
        $('#productImage').change(function(){
            const file = this.files[0];
            if (file){
                let reader = new FileReader();
                reader.onload = function(event){
                    $('#imgPreview').attr('src', event.target.result);
                }
                reader.readAsDataURL(file);
            }
        });
        $("#productDataTable").on("click", ".editProduct", function () { 
            var id = $(this).attr("data-id");
            $("#addProductData").modal('show');
            $('#PkProductId').val(id);
            $(".modal-title").html("Update Category");
            $.ajax({
                type: "GET",
                url: "../ajaxAddProduct.cfm?PkProductId="+ id,
                success: function(result) {
                
                    if (result.success) {
                        $("#PkProductId").val(result.json.PkProductId);
                        $('#productName').val(result.json.productName);
                        let imgSrc = '../assets/productImage/' + result.json.productImage;
                        $('#imgPreview').attr('src', imgSrc);
                        if(result.json.isActive == 1){ 
                            $('#isActive').prop('checked', true);
                        } else{
                            $('#isActive').prop('checked', false);
                        }
                        if(result.json.categoryId > 0){ 
                            getProduct(result.json.categoryId);
                        }
                        $('#addProductData').on('hidden.bs.modal', function () {
                            $("#addProductForm").trigger('reset');
                            $('#imgPreview').attr('src', '');
                            $("#category").val(''); 
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
                            infoToast("Deleted!","Product Deleted Successfully");
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
                               /*  toast("Deactivated", "Permission Deactivated Successfully", "error"); */
                                infoToast("Deactivated!","Product Deactivated Successfully");
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
                                successToast("Activated!","Category Activated Successfully");
                                //toast("Activated", "Permission Activated Successfully", "success");
                                $('#productDataTable').DataTable().ajax.reload();                       
                            }  
                        });
                    }
                });
            }
        });
    });
    function getProduct() {
        $.ajax({    
                type: "GET",
                url: "../ajaxAddProduct.cfm?formAction=getCategory", 
                dataType: "html",           
                success: function(result){
                    console.log("result", result);
                    // let dataRecord = JSON.parse(result);
                    if (result.success) {
                        $('#category').html('');
                        var html = "";
                        var html = "<option value='0'>Select Category</option>";
                        for (var i = 0; i < result.length; i++) {
                            html += "<option value="+result[i].PkCategoryId+" >"+result[i].categoryName+"</option>";
                        }
                        $('#category').append(html);
                        /* if (parentCatId > 0) {
                            $('#category').val(parentCatId);
                        } else {
                            $('#category').val(0);

                        } */
                    }
                    
                }
            }); 
    }
    
</script>