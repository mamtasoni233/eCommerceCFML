<cfoutput>
    <cfparam name="PkCouponId" default="" />
    <cfparam name="couponName" default="" />
    <cfparam name="couponCode" default="" />
    <cfparam name="discountValue" default="" />
    <cfparam name="discountType" default="" />
    <cfparam name="couponStartDate" default="" />
    <cfparam name="couponExpDate" default="" />
    <cfparam name="repeatRestriction" default="" />
    <div class="page-heading">
        <div class="page-title">
            <div class="row">
                <div class="col-12 col-md-6 order-md-1 order-last">
                    <h1>Coupons</h1>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="index.cfm?pg=dashboard">Dashboard</a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">
                                Coupons
                            </li>
                        </ol>
                    </nav>
                </div>
                <cfif structKeyExists(session.user, 'couponSave') AND session.user.couponSave EQ 1>
                    <div class="alert alert-light-success alert-dismissible show fade">
                        <i class="bi bi-check-circle"></i> Coupon Data successfully inserted..!!!
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <cfset StructDelete(session.user,'couponSave')>
                <cfelseif structKeyExists(session.user, 'couponUpdate') AND session.user.couponUpdate EQ 1>
                    <div class="alert alert-light-success alert-dismissible show fade">
                        <i class="bi bi-check-circle"></i> Coupon Data successfully updated..!!!
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <cfset StructDelete(session.user,'couponUpdate')>
                </cfif>
            </div>
        </div>
        <!-- Data Tables start -->
        <section class="section">
            <div class="card">
                <div class="card-header d-flex justify-content-end">
                    <button class="btn btn-primary editCoupon"  name="addCoupon" data-bs-toggle="model" id="addCoupon" data-id="0">
                        <i class="bi bi-plus-lg "></i><span class="ms-2 pt-1">Add Coupon</span>
                    </button>
                </div>
                <div class="modal fade" id="addCouponModal" tabindex="-1" role="dialog" aria-labelledby="addCouponModal" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header bg-primary">
                                <h5 class="modal-title white">
                                    Add Coupon
                                </h5>
                                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                    <i data-feather="x"></i>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form class="form p-3" id="addCouponForm" method="POST" action="" enctype="multipart/form-data">
                                    <input type="hidden" id="PkCouponId" value="" name="PkCouponId">
                                    <div class="row g-3">
                                        <div class="col-md-12">
                                            <lable class="fw-bold form-label" for="product">Products</lable>
                                            <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                                <select name="product" id="product" class="form-control" data-placeholder="Select Product..">
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <lable class="fw-bold form-label" for="couponName">Coupon Name</lable>
                                            <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                                <input type="text" class="form-control " id="couponName" value="" name="couponName"  placeholder="Enter Coupon Name"/>
                                                <div class="form-control-icon">
                                                    <i class="bi bi-tag-fill"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <lable class="fw-bold form-label" for="couponCode">Coupon Code</lable>
                                            <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                                <input type="text" class="form-control " id="couponCode" value="" name="couponCode"  placeholder="Enter Coupon Code"/>
                                                <div class="form-control-icon">
                                                    <i class="bi bi-percent"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <lable class="fw-bold form-label" for="discountValue">Discount Value</lable>
                                            <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                                <input type="number" class="form-control " id="discountValue" value="" name="discountValue"  placeholder="Enter Discount Value"/>
                                                <div class="form-control-icon">
                                                    <i class="bi bi-currency-rupee"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <lable class="fw-bold form-label" for="repeatRestriction">Repeat Restriction</lable>
                                            <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                                <input type="text" class="form-control " id="repeatRestriction" value="" name="repeatRestriction"  placeholder="Enter Repeat Restriction"/>
                                                <div class="form-control-icon">
                                                    <i class="bi bi-tag-fill"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <lable class="fw-bold form-label" for="discountType">Discount Type</lable>
                                            <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                                <select name="discountType" id="discountType" class="form-control">
                                                    <option value="">Select discountType</option>
                                                    <option value="1">Percent</option>
                                                    <option value="2">Flat</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <lable class="fw-bold form-label" for="couponStartDate">Coupon Start Date</lable>
                                            <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                                <input type="date" class="form-control mb-3 flatpickr-no-config" id="couponStartDate" value="" name="couponStartDate"  placeholder="Enter Coupon Start Date"/>
                                                <div class="form-control-icon">
                                                    <i class="bi bi-calendar"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <lable class="fw-bold form-label" for="couponExpDate">Coupon Expiry Date</lable>
                                            <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                                <input type="date" class="form-control mb-3 flatpickr-no-config" id="couponExpDate" value="" name="couponExpDate"  placeholder="Enter Coupon Expiry Date"/>
                                                <div class="form-control-icon">
                                                    <i class="bi bi-calendar"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <lable class="fw-bold form-label" for="description">Coupon Description</lable>
                                            <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                                <!--- <input type="date" class="form-control mb-3 flatpickr-no-config" id="description" value="" name="description"  placeholder="Enter Coupon Description"/>
                                                <div class="form-control-icon">
                                                    <i class="bi bi-calendar"></i>
                                                </div> --->
                                                <textarea id="description" name="description" class="form-control" row="4"></textarea>
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
                                            <span class="d-block">Close</span>
                                        </button>
                                        <button type="submit" id="defaultSubmit" class="btn btn-primary ms-1" >
                                            <span class="d-block">Submit</span>
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table nowrap" id="couponDataTable">
                            <thead>
                                <tr>
                                    <th>SI No.</th>
                                    <th>Product</th>
                                    <th>Coupon Name</th>
                                    <th>Coupon Code</th>
                                    <th>Discount Type</th>  
                                    <th>Discount Value</th>  
                                    <th>Coupon Start Date</th>  
                                    <th>Coupon Expiry Date</th>  
                                    <th>Coupon Repeat Restriction</th>  
                                    <th>Coupon Description</th>  
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
        
        flatpickr('.flatpickr-no-config', {
            dateFormat: "d-m-Y", 
        });
        $('#product').select2({
            theme: "bootstrap-5",
            width: $( this ).data( 'width' ) ? $( this ).data( 'width' ) : $( this ).hasClass( 'w-100' ) ? '100%' : 'style',
            placeholder: $( this ).data( 'placeholder' ),
            dropdownParent: $('#addCouponModal'),
            allowClear: true,
        });
        $('#couponDataTable').DataTable({
            processing: true,
            destroy: true,
            pageLength: 10,
            pagination: 'datatablePagination',
            order: [[10, 'desc']],
            serverSide:true,
            responsive: true,
            autoWidth: false,
            columnDefs: [
                { "width": "40%", "targets": [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14] }
            ],
            pagingType: "full_numbers",
            dom: 'l<"toolbar">frtip',
            ajax: {
                url: "../ajaxAddCoupon.cfm?formAction=getRecord",
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
                { data: 'sNo'},
                { data: 'productName',
                    render: function (data, type, row) {
                        if (data === '') {
                            return '<span>For All Products</span>'
                        } else {
                            return '<span>'+data+'</span>'
                        }
                    }
                },
                { data: 'couponName'},
                { data: 'couponCode' },
                { data: 'discountType',
                    render: function (data,type,row) {
                        if(data === 1){
                            return '<span>Percent</span>'
                        } else {
                            return '<span>Flat</span>'
                        }
                    }
                },
                { data: 'discountValue' },
                { data: 'couponStartDate' },
                { data: 'couponExpDate' },
                { data: 'repeatRestriction' },
                { data: 'description' },
                { data: 'userName' },
                { data: 'dateCreated' },
                { data: 'userNameUpdate' },
                { data: 'dateUpdated' },
                { data: 'isActive',
                    render: function (data,type,row) {
                        if(row.isActive == 1){
                            return '<span id="deactive" data-id="'+row.PkCouponId+'" data-status="Active" data-name="'+row.couponName+'" class=" badge bg-success text-white changeStatus"  data-toggle="tooltip" data-html="true" title="Click to Deactive Coupon" data-placement="bottom">Active</span>';
                        }else{
                            return '<span id="active" data-id="'+row.PkCouponId+'" data-status="Deactive" data-name="'+row.couponName+'" class="badge bg-danger text-white changeStatus" data-toggle="tooltip" data-html="true" title="Click to Active Coupon" data-placement="bottom">Inactive</span>';
                        }
                    }
                },
                { data: 'PkCouponId',
                    render: function(data, type, row, meta)
                    {
                        var returnStr = '';
                        if(row.isDeleted == 1){
                            returnStr += '<a data-id="'+ row.PkCouponId + '" data-name="'+row.couponName+'" id="restoreCoupon" class="border-none btn btn-sm btn-warning text-white mt-1 restoreCoupon"><i class="fas fa-undo"></i></a>'	
                        } else{
                            returnStr += '<a data-id="'+row.PkCouponId+'"  id="editCoupon" class="border-none btn btn-sm btn-success text-white mt-1 editCoupon" > <i class="bi bi-pen-fill"></i></a>  <a data-id="'+row.PkCouponId+'" data-name="'+row.couponName+'" id="deleteCoupon" class="border-none btn btn-sm btn-danger text-white mt-1 deleteCoupon" > <i class="bi bi-trash"></i></a>'				
                        }
                        return returnStr;
                    }
                },
            ],
            rowCallback : function(nRow, aData, iDisplayIndex){
                $("td:first", nRow).html(iDisplayIndex + 1);
                if ( aData.isDeleted === 1 ) {
                    $(nRow).addClass('table-danger');
                }
                return nRow;
            },
        });
        
        $('div.toolbar').after('<select id="isDeleted" class="form-select d-inline-block w-25 pl-1 form-select-sm"><option value="2">Select All</option><option value="0" selected>Not Deleted</option><option value="1">Deleted</option></select>');
        
        $('#isDeleted').change(function () {
            $('#couponDataTable').DataTable().ajax.reload();
        });
        // open add Coupon model
        $("#addCoupon").on("click", function () {
            $("#addCouponModal").modal('show');
            $('#PkCouponId').val(0);
            getProduct();
        });

        var validator = $("#addCouponForm").validate({
            rules: {
                product: {
                    required: true
                },
                couponName: {
                    required: true
                },
                couponCode: {
                    required: true
                },
                discountValue: {
                    required: true,
                },
                discountType: {
                    required: true
                },
                couponStartDate: {
                    required: true
                },
                couponExpDate: {
                    required: true
                },
                repeatRestriction: {
                    required: true,
                    digits: true
                },
            },
            errorPlacement: function (error, element) {
                error.insertAfter($(element).parent('div')); 
            },
            messages: {
                product: {
                    required: "Please select product",                    
                },
                couponName: {
                    required: "Please enter coupon name",                    
                },
                couponCode: {
                    required: "Please enter coupon code",                    
                },
                discountValue: {
                    required: "Please enter discount value",                    
                },
                discountType: {
                    required: "Please select discount type",                    
                },
                couponStartDate: {
                    required: "Please enter coupon start date",                    
                },
                couponExpDate: {
                    required: "Please enter coupon expiry date",                    
                },
                repeatRestriction: {
                    required: "Please enter the number coupon repeation",                    
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
                submitCouponData();
            }, 
        });

        $('#addCouponModal').on('hidden.bs.modal', function () {
            $("#addCouponForm").trigger('reset');
            validator.resetForm(); 
            $("#discountType").val('').trigger("change");
            $("#product").val('').trigger("change");
        });
        $("select").on("select2:close", function (e) {  
            $(this).valid(); 
        });

        $("#couponDataTable").on("click", ".editCoupon", function () { 
            var id = $(this).attr("data-id");
            $("#addCouponModal").modal('show');
            $('#PkCouponId').val(id);
            $(".modal-title").html("Update Coupon");
            $.ajax({
                type: "GET",
                url: "../ajaxAddCoupon.cfm?PkCouponId="+ id,
                success: function(result) {
                    if (result.success) {
                        $("#PkCouponId").val(result.json.PkCouponId);
                        $('#couponName').val(result.json.couponName);
                        $('#couponCode').val(result.json.couponCode);
                        $('#discountValue').val(result.json.discountValue);
                        $('#repeatRestriction').val(result.json.repeatRestriction);
                        $('#couponStartDate').val(result.json.couponStartDate);
                        $('#couponExpDate').val(result.json.couponExpDate);
                        $('#description').val(result.json.description);
                        $('#discountType').val(result.json.discountType).trigger('change');
                        getProduct(result.json.FkProductId);
                        $('#product').val(result.json.FkProductId).trigger('change');
                        if(result.json.isActive == 1){ 
                            $('#isActive').prop('checked', true);
                        } else{
                            $('#isActive').prop('checked', false);
                        }
                        $('#addCouponModal').on('hidden.bs.modal', function () {
                            $("#addCouponForm").trigger('reset');
                            validator.resetForm();
                            $(".modal-title").html("Add Coupon");
                            $("#discountType").val('').trigger("change");
                            $("#product").val('').trigger("change");
                        });
                    }
                }   
            });
        });
        $("#couponDataTable").on("click", ".deleteCoupon", function () { 
            var id = $(this).attr("data-id");
            var name = $(this).data("name");
            Swal.fire({
                title: 'Are you sure?',
                text: 'You want to delete coupon record for ' + '"' +  name + '"',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#dc3545',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({  
                        url: '../ajaxAddCoupon.cfm?delPkCouponId='+id,
                        type: 'GET',  
                        success: function(data) {
                            dangerToast("Deleted!","Coupon Deleted Successfully");
                            $('#couponDataTable').DataTable().ajax.reload();               
                        }  
                    });
                }
            });
        });
        $("#couponDataTable").on("click", ".changeStatus", function () {
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
                            url: '../ajaxAddCoupon.cfm?statusId='+id,  
                            type: 'POST',  
                            success: function(data) {
                                dangerToast("Deactivated!","Coupon Deactivated Successfully");
                                $('#couponDataTable').DataTable().ajax.reload();                       
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
                            url: '../ajaxAddCoupon.cfm?statusId='+id,  
                            type: 'POST',  
                            success: function(data) {
                                successToast("Activated!","Coupon Activated Successfully");
                                $('#couponDataTable').DataTable().ajax.reload();                       
                            }  
                        });
                    }
                });
            }
        });
        $("#couponDataTable").on("click", ".restoreCoupon", function () { 
            var id = $(this).attr("data-id");
            var name = $(this).data("name");
            Swal.fire({
                title: 'Are you sure?',
                text: 'You want to restore Coupon record for ' + '"' +  name + '"',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Yes, Restore it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({  
                        url: '../ajaxAddCoupon.cfm?restorePkCouponId='+id, 
                        type: 'GET',  
                        success: function(data) {
                            successToast("Restore!","Coupon Restore Successfully");
                            $('#couponDataTable').DataTable().ajax.reload();               
                        }  
                    });
                }
            });
        });  
    });
    function getProduct(productId='') {
        $.ajax({    
            type: "GET",
            url: "../ajaxAddCoupon.cfm?formAction=getProduct", 
            dataType: "html",  
            success: function(data){
                let dataRecord = JSON.parse(data);
                if (dataRecord.success) {
                    //var html = "";
                    $('#product').html('');
                    var html = "<option value=''></option><option value='0'>For All Products</option>";
                    $.each(dataRecord.productList, function( data, value, i ) {
                        html += "<option value ="+value.pkproductid+">" + value.productname +"</option>";
                    });
                    $('#product').append(html);
                    if (productId >= 0) {
                        $('#product').val(productId);
                    } else {
                        $('#product').val();
                    }
                }
            }
        }); 
    }
    function submitCouponData() {
        var formData = new FormData($('#addCouponForm')[0]);
        
        $.ajax({
            type: "POST",
            url: "../ajaxAddCoupon.cfm?PkCouponId=" + $('#PkCouponId').val(),
            data: formData,
            contentType: false,
            processData: false,
            success: function(result) {
                if ($('#PkCouponId').val() > 0) {
                    successToast("Coupon Updated!","Coupon Successfully Updated");
                } else{
                    successToast("Coupon Add!","Coupon Successfully Added");
                }
                $("#addCouponModal").modal('hide');
                $('#couponDataTable').DataTable().ajax.reload();   
            }
        });
    }
    
</script>
