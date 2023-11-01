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

<cfoutput>
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
                <!--- <cfif structKeyExists(session.customer, 'customerUpdate') AND session.customer.customerUpdate EQ 1>
                    <div class="alert alert-success alert-dismissible show fade">
                        <i class="fa fa-check-circle"></i> Your personal details successfully updated..!!!
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <cfset StructDelete(session.customer,'customerUpdate')>
                </cfif> --->
                <form method="Post" action="ajaxEditAccount.cfm?formAction=editAccountDetail" id="editDetailForm">
                    <h3>Change Password</h3>
                    <div class="row mt-4">
                        <div class="col-12 col-lg-2 mt-1"><label>Old Password</label> <span class="text-danger">*</span></div>
                        <div class="col-12 col-lg-10">
                            <div class="input-group input-group-merge" data-hs-validation-validate-class>
                                <input  type="password" class="js-toggle-password
                                form-control form-control-sm" name="oldpassword" id="oldpassword" placeholder="Enter Old Password"
                                aria-label="enter password" tabindex="1"  maxlength="16"
                                data-hs-toggle-password-options='{
                                "target": "##changePassTarget",
                                "defaultClass": "fa fa-eye-slash",
                                "showClass": "fa fa-eye",
                                "classChangeTarget": "##changePassIcon"
                                }'>
                                <a id="changePassTarget" class="input-group-append input-group-text" href="javascript:void(0);" tabindex="2">
                                    <i id="changePassIcon" class="fa fa-eye-slash"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-4">
                        <div class="col-12 col-lg-2 mt-1"><label>New Password</label> <span class="text-danger">*</span></div>
                        <div class="col-12 col-lg-10">
                            <div class="input-group input-group-merge" data-hs-validation-validate-class>
                                <input  type="password" class="js-toggle-password
                                form-control form-control-sm" name="newpassword" id="newpassword" placeholder="Enter New Password"
                                aria-label="enter password" tabindex="3" maxlength="16"
                                data-hs-toggle-password-options='{
                                "target": "##changePassTarget",
                                "defaultClass": "fa fa-eye-slash",
                                "showClass": "fa fa-eye",
                                "classChangeTarget": "##changePassIcon"
                                }'>
                                <a id="changePassTarget" class="input-group-append input-group-text" href="javascript:void(0);" tabindex="4">
                                    <i id="changeNewPassIcon" class="fa fa-eye-slash"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-4 mb-4 d-flex flex-row-reverse">
                        <div class="col-6 text-end">
                            <input type="submit" class="btn btn-md btn-orange rounded-3" data-bs-toggle="tooltip" title="Update" value="Update"  tabindex="5">
                        </div>
                        <div class="col-6 text-start">
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
        $(document).ready(function(){

            $('##changePassIcon').click(function(){
                if($('##changePassIcon').attr('class') == 'bi-eye-slash'){
                    $('##oldpassword').attr('type','text');
                    $('##changePassIcon').removeClass('bi-eye-slash');
                    $('##changePassIcon').addClass('bi-eye');
                } else{
                    $('##oldpassword').attr('type','password');
                    $('##changePassIcon').removeClass('bi-eye');
                    $('##changePassIcon').addClass('bi-eye-slash');
                }
            });

            $('##changeNewPassIcon').click(function(){
                if($('##changeNewPassIcon').attr('class') == 'bi-eye-slash'){
                    $('##newpassword').attr('type','text');
                    $('##changeNewPassIcon').removeClass('bi-eye-slash');
                    $('##changeNewPassIcon').addClass('bi-eye');
                } else{
                    $('##newpassword').attr('type','password');
                    $('##changeNewPassIcon').removeClass('bi-eye');
                    $('##changeNewPassIcon').addClass('bi-eye-slash');
                }
            });

            $('##passwordForm').validate({
                rules: {
                    oldpassword:{
                        required: true
                    },
                    newpassword:{
                        validPassword : true,
                        required: true
                    },                                 
                },
                messages: {
                    oldpassword: {
                        required: 'Please enter old password.'
                    },
                    newpassword: {
                        required: 'Please enter new password.'
                    },
                },
                ignore: [],
                errorElement: 'span',
                errorPlacement: function (error, element) {
                    if(element.attr('name') == "oldpassword"){
                        error.addClass('invalid-feedback');
                        error.insertAfter(element.parent());
                    } else if(element.attr('name') == "newpassword"){
                        error.addClass('invalid-feedback');
                        error.insertAfter(element.parent());
                    }  
                    else{
                        error.addClass('invalid-feedback');
                        element.after(error);
                    }
                },
                highlight: function (element, errorClass, validClass) {
                    $(element).addClass('is-invalid');
                },
                unhighlight: function (element, errorClass, validClass) {
                    $(element).removeClass('is-invalid');
                }
            });
        });
    </script>
</cfoutput>