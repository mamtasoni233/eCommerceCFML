<cfparam name="PkCustomerId" default="" />
<cfparam name="firstName" default="" />
<cfparam name="lastName" default="" />
<cfparam name="email" default="" />
<cfparam name="gender" default="" />
<cfparam name="dob" default="" />
<cfparam name="mobile" default="" />
<cfset bcrypt = application.bcrypt>
<cfset gensalt = bcrypt.gensalt()>
<cfparam name="password" default="" />
<cfparam name="createdBy" default="" />
<cfparam name="customerId" default="#session.customer.isLoggedIn#" />
<cfquery name="getCustomerDetails">
    SELECT 
        PkCustomerId, firstName, lastName, email, gender, dob, mobile, isActive, isBlcoked, createdBy, updatedBy, createdDate, updatedDate, isDeleted
    FROM customer 
    WHERE PkCustomerId = <cfqueryparam value="#session.customer.isLoggedIn#" cfsqltype = "cf_sql_integer">
</cfquery>
<cfoutput>
        <style>
            .form-control{
                border-radius: 0 !important;
            }
        </style>
    <section class="container mb-5">
        <!-- Breadcrumbs-->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="index.cfm?pg=dashboard">Home</a></li>
                <li class="breadcrumb-item active" aria-current="page">Edit Account</li>
            </ol>
        </nav>
        <div class="row">
            <div class="col-md-9">
                <cfif structKeyExists(session.customer, 'customerUpdate') AND session.customer.customerUpdate EQ 1>
                    <div class="alert alert-success alert-dismissible show fade">
                        <i class="fa fa-check-circle"></i> Your personal details successfully updated..!!!
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <cfset StructDelete(session.customer,'customerUpdate')>
                </cfif>
                <form method="Post" action="ajaxEditAccount.cfm?formAction=editAccountDetail" id="editDetailForm">
                    <h3>Edit Account</h3>
                    <div class="row mt-4">
                        <div class="col-12 col-lg-2"><label>First Name</label> <span class="text-danger">*</span></div>
                        <div class="col-12 col-lg-10">
                            <input type="text" class="form-control" name="firstname" id="firstname" value="#getCustomerDetails.firstName#" placeholder="Enter First Name" tabindex="1">
                        </div>
                    </div>
                    <div class="row mt-4">    
                        <div class=" col-12 col-lg-2"><label>Last Name</label> <span class="text-danger">*</span></div>
                        <div class=" col-12 col-lg-10">
                            <input type="text" class="form-control" name="lastname" id="lastname" value="#getCustomerDetails.lastName#" placeholder="Enter Last Name" tabindex="2">
                        </div>
                    </div>
                    <div class="row mt-4">    
                        <div class=" col-12 col-lg-2"><label>Email</label> <span class="text-danger">*</span></div>
                        <div class=" col-12 col-lg-10">
                            <input type="email" class="form-control" name="email" id="email" value="#getCustomerDetails.email#" placeholder="Enter Email" tabindex="3">
                        </div>
                    </div>
                    <div class="row mt-4">    
                        <div class=" col-12 col-lg-2"><label>Mobile</label> <span class="text-danger">*</span></div>
                        <div class=" col-12 col-lg-10">
                            <input type="text" maxlength="15" class="form-control" name="mobile" id="mobile" value="#getCustomerDetails.mobile#" placeholder="Enter Mobile Number" tabindex="4">
                        </div>
                    </div>
                    <div class="row mt-4 mb-4 d-flex flex-row-reverse">    
                        <div class="col-10 col-lg-10 text-end">
                            <input type="submit" class="btn btn-md btn-orange rounded-3" data-bs-toggle="tooltip" tabindex="5" title="Continue" value="Continue">
                        </div>
                        <div class="col-2 col-lg-2">
                            <a href="" class="text-decoration-none btn btn-md btn-dark rounded-3" data-bs-toggle="tooltip" title="Back" tabindex="6">Back</a>
                        </div>
                    </div>
                </form>   
            </div>
            <div class="col-md-3">
                <cfinclude template="../common/sidebar.cfm">
            </div>
        </div>
    </section>

    <script>
        $(document).ready( function () { 
            var validator = $("##editDetailForm").validate({
                rules: {
                    email: {
                        required: true
                    },
                    firstName: {
                        required: true
                    },
                    lastName: {
                        required: true
                    },
                    mobile: {
                        required: true,
                        digits:true
                    },
                },
                messages: {
                    email: {
                        required: "Please enter email address",                    
                    },
                    firstName: {
                        required: "Please enter first name",                    
                    },
                    lastName: {
                        required: "Please enter last name",                    
                    },
                    mobile: {
                        required: "Please enter mobile number",                    
                    },
                },
                ignore: [],
                errorElement: 'span',
                errorPlacement: function (error, element) {
                    var elem = $(element);
                    error.insertAfter(element);
                    error.addClass('invalid-feedback');
                },
                highlight: function (element, errorClass, validClass) {
                    
                    $(element).addClass('is-invalid');
                },
                unhighlight: function (element, errorClass, validClass) {
                    $(element).removeClass('is-invalid');
                },
            });
        });
    </script>
</cfoutput>