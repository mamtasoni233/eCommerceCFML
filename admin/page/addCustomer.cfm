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
                            <li class="breadcrumb-item" aria-current="page">
                                <a href="index.cfm?pg=customerList">Customers</a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">
                                Add Customer
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
                    <a href="index.cfm?pg=customerList" class="btn btn-primary editCustomer"  name="addCustomer" id="addCustomer" data-id="0">
                        <i class="bi bi-plus-lg "></i><span class="ms-2 pt-1">Back</span>
                    </a>
                </div>
                <form class="form p-3" id="addCustomerForm" method="POST" enctype="multipart/form-data">
                    <input type="hidden" id="PkCustomerId" value="" name="PkCustomerId">
                    <div class="row g-3">
                        <div class="col-md-12">
                            <lable class="fw-bold form-label" for="parentCategory">Parent Category Name</lable>
                            <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                <select name="parentCategory" id="parentCategory" class="form-control-xl">
                                    <!--- <option selected value='0'>Select As A Parent</option> --->
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
                                <input type="file" class="form-control form-control-xl" name="categoryImage" id="categoryImage"  aria-describedby="inputGroupPrepend">
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
        </section>
    </div>
</cfoutput>