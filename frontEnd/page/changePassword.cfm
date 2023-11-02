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

<!--- <cfquery name="getCustomerPassword">
    SELECT PkCustomerId, password FROM customer 
    WHERE PkCustomerId = <cfqueryparam value="#customerId#" cfsqltype="cf_sql_integer">
</cfquery>
<cfif getCustomerPassword.recordCount GT 0>
    <cfif structKeyExists(form, 'oldpassword')>
    </cfif>

</cfif> --->
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
                <cfif structKeyExists(session.customer, "save") AND session.customer.save EQ 6>
                    <div class="alert alert-success alert-dismissible show fade">
                        <i class="fa fa-check-circle"></i> Your Password Succefully Updated!!!
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <cfset StructDelete(session.customer,'save')>
                <cfelseif structKeyExists(session.customer, "error") AND session.customer.error EQ 2>
                    <div class="alert alert-danger alert-dismissible show fade">
                        <i class="fa fa-exclamation-circle"></i> Your Old Password Doesn't Match!!!
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <cfset StructDelete(session.customer,'error')>
                </cfif>
                <form method="Post" action="ajaxEditAccount.cfm?formAction=changePassword" id="passwordForm">
                    <h3>Change Password</h3>
                    <div class="row mt-4">
                        <div class="col-12 col-lg-2 mt-1"><label>Old Password</label> <span class="text-danger">*</span></div>
                        <div class="col-12 col-lg-10">
                            <div class="input-group input-group-merge" data-hs-validation-validate-class>
                                <input  type="password" class="js-toggle-password
                                form-control form-control-xl" name="oldpassword" id="oldpassword" placeholder="Enter Old Password"
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
                                form-control form-control-xl" name="newPassword" id="newPassword" placeholder="Enter New Password"
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
                            <div id="pswmeter" class="d-none"></div>
                            <div id="pswmeter-message" class="d-none mb-3"></div>
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

    <!--- password meter --->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
    <script src="../assets/js/pswmeter.min.js"></script>
    <script>
        $(document).ready(function(){
            $('##newPassword').on('keyup',function(){
                if ($(this).val().length > 0) {
                    $("##pswmeter").removeClass('d-none');
                    $("##pswmeter-message").removeClass('d-none');
                } else {
                    $("##pswmeter").addClass('d-none');
                    $("##pswmeter-message").addClass('d-none');
                }
            });

            $('##changePassIcon').click(function(){
                if($('##changePassIcon').attr('class') == 'fa fa-eye-slash'){
                    $('##oldpassword').attr('type','text');
                    $('##changePassIcon').removeClass('fa fa-eye-slash');
                    $('##changePassIcon').addClass('fa fa-eye');
                } else{
                    $('##oldpassword').attr('type','password');
                    $('##changePassIcon').removeClass('fa fa-eye');
                    $('##changePassIcon').addClass('fa fa-eye-slash');
                }
            });

            $('##changeNewPassIcon').click(function(){
                if($('##changeNewPassIcon').attr('class') == 'fa fa-eye-slash'){
                    $('##newPassword').attr('type','text');
                    $('##changeNewPassIcon').removeClass('fa fa-eye-slash');
                    $('##changeNewPassIcon').addClass('fa fa-eye');
                } else{
                    $('##newPassword').attr('type','password');
                    $('##changeNewPassIcon').removeClass('fa fa-eye');
                    $('##changeNewPassIcon').addClass('fa fa-eye-slash');
                }
            });

            $('##passwordForm').validate({
                rules: {
                    oldpassword:{
                        required: true
                    },
                    newPassword:{
                        validPassword : true,
                        required: true,
                        minlength:8,
                    },                                 
                },
                messages: {
                    oldpassword: {
                        required: 'Please enter old password.'
                    },
                    newPassword: {
                        required: 'Please enter new password.'
                    },
                },
                ignore: [],
                errorElement: 'span',
                errorPlacement: function (error, element) {
                    if(element.attr('name') == "oldpassword"){
                        error.addClass('invalid-feedback');
                        error.insertAfter(element.parent());
                    } else if(element.attr('name') == "newPassword"){
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
        // Run pswmeter with options
        var pass = document.getElementById('newPassword');
        const myPassMeter = passwordStrengthMeter({
            containerElement: '##pswmeter',
            passwordInput: '##newPassword',
            showMessage: true,
            messageContainer: '##pswmeter-message',
            messagesList: [
                'Write your password...',
                'Easy peasy!',
                'That is a simple one',
                'That is better',
                'Yeah! that password rocks ;)'
            ],
            height: 6,
            borderRadius: 0,
            pswMinLength: 8,
            colorScore1: '##d91818',
            colorScore2: '##c37b48',
            colorScore3: '##ffc107',
            colorScore4: 'limegreen'
        });
    </script>
</cfoutput>