<cfoutput>
    <cfparam name="PkUserId" default="0" />
    <cfparam name="firstName" default="" />
    <cfparam name="lastName" default="" />
    <cfparam name="email" default="" />
    <cfparam name="password" default="" />
    <cfparam name="dob" default="" />
    <cfparam name="dobYear" default="" />
    <cfparam name="dobDate" default="" />
    <cfparam name="dobMonth" default="" />
    <cfparam name="gender" default="" />
    <cfparam name="mobile" default="" />
    <cfparam name="image" default="" />
    <cfparam name="isActive" default="" /> 
    <cfif structKeyExists(url, "PkUserId") AND url.PkUserId GT 0>
        <cfquery name="editUserData">
            SELECT PkUserId, firstName, image, isActive, lastName, email, gender, dob, mobile
            FROM users 
            WHERE PkUserId = <cfqueryparam value="#PkUserId#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfset PkUserId= editUserData.PkUserId>
        <cfset firstName = editUserData.firstName>
        <cfset lastName = editUserData.lastName>
        <cfset email = editUserData.email>
        <cfset gender = editUserData.gender>
        <cfset dobDate = dateFormat(editUserData.dob, 'dd')>
        <cfset dobMonth = dateFormat(editUserData.dob, 'mm')>
        <cfset dobYear = dateFormat(editUserData.dob, 'yyyy')>
        <cfset image = editUserData.image>
        <cfset isActive = editUserData.isActive>
    </cfif>
    <div class="page-heading">
        <div class="page-title">
            <div class="row">
                <div class="col-12 col-md-6 order-md-1 order-last">
                    <h1>User</h1>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="index.cfm?pg=dashboard">Dashboard</a>
                            </li>
                            <li class="breadcrumb-item" aria-current="page">
                                <a href="index.cfm?pg=user&s=userList">Users</a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">
                                Add User
                            </li>
                        </ol>
                    </nav>
                </div>
                <cfif structKeyExists(url,"checkEmail") AND url.checkEmail EQ 1>
                    <div class="alert alert-light-danger alert-dismissible show fade">
                        <i class="bi bi-exclamation-circle"></i> Email already exist!!!
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
                        </button>
                    </div>
                </cfif>
            </div>
        </div>
        <section class="section">
            <div class="card">
                <div class="card-header d-flex justify-content-end">
                    <a href="index.cfm?pg=user&s=userList" class="btn btn-primary"  name="backUserList" id="backUserList" data-id="0">
                        <i class="bi bi-left-arrow"></i><span class="ms-2 pt-1">Back</span>
                    </a>
                </div>
                <form action="ajaxAddUser.cfm?formAction=saveUser" class="form p-3" id="addUserForm" method="POST" enctype="multipart/form-data">
                    <input type="hidden" id="PkUserId" value="#PkUserId#" name="PkUserId">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <lable class="fw-bold form-label" for="firstName">First Name</lable>
                            <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                <input type="text" name="firstName" id="firstName" class="form-control form-control-xl" placeholder="Enter First Name" value="#firstName#"/>
                                <div class="form-control-icon">
                                    <i class="bi bi-person-fill"></i>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <lable class="fw-bold form-label" for="lastName">Last Name</lable>
                            <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                <input type="text" name="lastName" id="lastName" class="form-control form-control-xl" placeholder="Enter Last Name" value="#lastName#"/>
                                <div class="form-control-icon">
                                    <i class="bi bi-person-fill"></i>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <lable class="fw-bold form-label" for="email">Email</lable>
                            <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                <input type="email" name="email" id="email" class="form-control form-control-xl" placeholder="Enter Email" value="#email#"/>
                                <div class="form-control-icon">
                                    <i class="bi bi-person-fill"></i>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <lable class="fw-bold form-label" for="mobile">Mobile</lable>
                            <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                <input type="mobile" name="mobile" id="mobile" class="form-control form-control-xl" placeholder="Enter mobile" value="#mobile#"/>
                                <div class="form-control-icon">
                                    <i class="bi bi-phone"></i>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <lable class="fw-bold form-label" for="password">Password</lable>
                            <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                <input type="password" name="password" id="password" class="form-control form-control-xl" placeholder="Password" <cfif PkUserId EQ 0>required</cfif> value="" />
                                <div class="form-control-icon">
                                    <i class="bi bi-shield-lock"></i>
                                </div>
                            </div>
                            <div id="pswmeter" class="d-none"></div>
                            <div id="pswmeter-message" class="d-none mb-3"></div>
                        </div>
                        <div class="col-md-6"> 
                            <lable class="fw-bold form-label" for="gender">Gender</lable>
                            <div class="form-group position-relative has-icon-left mb-4 mt-3">
                                <div class="row genderRow me-5">
                                    <div class="col-md-6">
                                            <div class="form-check">
                                                <input class="form-check-input genderCheck" type="radio" name="gender" value="1" <cfif gender EQ 1>checked</cfif>>
                                                <label class="form-check-label" for="male" id="male"> Male</label>
                                            </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-check">
                                            <input class="form-check-input genderCheck" type="radio" name="gender" value="0" <cfif gender EQ 0>checked</cfif>>
                                            <label class="form-check-label" for="female" id="female"> Female </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <lable class="fw-bold form-label " for="dob">DOB</lable>
                            <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <select name="year" class="form-select" id="year">
                                                <option value="" selected class="opacity-100">Year</option>
                                                <cfloop from="1995" to="2013" index="idx">
                                                    <option value="#idx#" <cfif dobYear EQ idx>selected</cfif>>#idx#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <select name="month" class="form-select" id="month">
                                                <option value="" selected class="opacity-100">Month</option>
                                                <cfloop from="1" to="12" index="i">
                                                    <option value="#i#" <cfif dobMonth EQ i>selected</cfif>>#i#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <select name="day" class="form-select" id="day">
                                                <option value="" class="opacity-100">Day</option>
                                                <cfloop from="1" to="31" index="j">
                                                    <option value="#j#" <cfif dobDate EQ j>selected</cfif>>#j#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <lable class="fw-bold form-label" for="userProfile">Profile</lable>
                            <div class="form-group position-relative has-icon-left mb-4 mt-2">
                            <input type="file" class="form-control form-control-xl image-preview-filepond" name="userProfile" id="userProfile"  aria-describedby="inputGroupPrepend">
                                <div class="form-control-icon">
                                    <i class="bi bi-cloud-plus-fill me-2"></i>
                                </div>
                            </div>
                            <img id="imgPreviewProfile" src="" class="w-25">     
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
                        <a href="index.cfm?pg=user&s=userList" class="btn btn-light-secondary">
                            <span class="d-block">Cancel</span>
                        </a>
                        <button type="submit" id="defaultSubmit" class="btn btn-primary ms-1" >
                            <span class="d-block">Submit</span>
                        </button>
                    </div>
                </form>
            </div>
        </section>
    </div>
    <script src="/assets/js/pswmeter.min.js"></script>
    <script>
        $( document ).ready(function() {
            $('##password').on('keyup',function(){
                if ($(this).val().length > 0) {
                    $("##pswmeter").removeClass('d-none');
                    $("##pswmeter-message").removeClass('d-none');
                } else {
                    $("##pswmeter").addClass('d-none');
                    $("##pswmeter-message").addClass('d-none');
                }
            });
            $('##userProfile').change(function(){
                const file = this.files[0];
                if (file){
                    let reader = new FileReader();
                    reader.onload = function(event){
                        $('##imgPreviewProfile').attr('src', event.target.result);
                    }
                        reader.readAsDataURL(file);
                    }
            });
            $("##addUserForm").validate({
                rules: {
                    firstName: {
                        required: true
                    },
                    lastName: {
                        required: true
                    },
                    email: {
                        required: true,
                        email: true
                    },
                    gender: {
                        required: true
                    },
                    day: {
                        required: true
                    },
                    month: {
                        required: true
                    },
                    year: {
                        required: true
                    },
                    password: {
                        //required: true,
                        required: function(element){
                            if( $("##PkUserId").val() > 0){
                                return false;
                            } else{
                                return true;
                            }
                        },
                        minlength:8
                    },
                },
                messages: {
                    firstName: {
                        required: "Please enter your first name",                    
                    },   
                    lastName: {
                        required: "Please enter your last name",                    
                    },  
                    email: {
                        required: "Please enter your email address",                    
                    },
                    gender: {
                        required: "Please enter your gender",                    
                    },
                    day: {
                        required: "Please enter your birth date",                    
                    },
                    month: {
                        required: "Please enter your birth month",                    
                    },
                    year: {
                        required: "Please enter your birth year",                    
                    },
                    password: {
                        required: "Please enter your password"
                    } 
                },
                ignore: [],
                errorElement: 'span',
                errorPlacement: function (error, element) {
                    if (element.attr("name") == "gender") {
                        error.insertAfter($('.genderRow'));
                    } else {
                        error.insertAfter(element);
                    }
                    error.addClass('invalid-feedback');
                },
                highlight: function (element, errorClass, validClass) {
                    if ($(element).hasClass('form-check-input')){
                        if ($(element).attr('name') == 'gender') {
                            $('.genderCheck').each(function () {
                                $(this).addClass('is-invalid');
                            });
                        }
                    } else {
                        $(element).addClass('is-invalid');
                    }
                    //$(element).addClass('is-invalid');
                },
                unhighlight: function (element, errorClass, validClass) {
                    if ($(element).hasClass('form-check-input')){
                        if ($(element).attr('name') == 'gender') {
                            $('.genderCheck').each(function () {
                                $(this).removeClass('is-invalid');
                            });
                        }
                    } else {
                        $(element).removeClass('is-invalid');
                    }
                },
            });
        });
        // Run pswmeter with options
        var pass = document.getElementById('password');
        const myPassMeter = passwordStrengthMeter({
            containerElement: '##pswmeter',
            passwordInput: '##password',
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