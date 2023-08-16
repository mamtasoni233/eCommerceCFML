<cfoutput>
    <style>
        .img-container{
            position:relative;
        }
        .profileImg{
            opacity: 1;
            width: 100%;
            transition: .5s ease;
            backface-visibility: hidden;
        }
        .middle{
            transition: .5s ease;
            opacity: 0;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            -ms-transform: translate(-50%, -50%);
            text-align: center;
        }
        .img-container:hover .profileImg {
            opacity: 0.4;
        }
        .img-container:hover .middle {
            opacity: 1;
        }
        .text {
            color: rgb(5, 5, 5);
            font-size: 1.2rem;
            margin:auto;
        }

       /* HIDE RADIO */
        [type=radio] { 
            position: absolute;
            opacity: 0;
            width: 0;
            height: 0;
        }
        /* IMAGE STYLES */
        [type=radio] + img {
            cursor: pointer;
        }

        /* CHECKED STYLES */
        [type=radio]:checked + img {
            border: 5px solid rgb(83, 91, 244);
           /*  outline: 10px solid ##0000; */
        }
    </style>
    <cfparam name="PkUserId" default="" />
    <cfparam name="firstName" default="" />
    <cfparam name="lastName" default="" />
    <cfparam name="email" default="" />
    <cfparam name="gender" default="" />
    <cfparam name="dob" default="" />
    <cfset bcrypt = application.bcrypt>
    <cfset gensalt = bcrypt.gensalt()>
    <cfquery name="getUser">
        SELECT PkUserId, firstName, lastName, email, dob, password, gender FROM users 
        WHERE PkUserId = <cfqueryparam value="#session.user.isLoggedIn#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfif getUser.recordCount EQ 1>
        <cfset PkUserId = getUser.PkUserId>
        <cfset firstName = getUser.firstName>
        <cfset lastName = getUser.lastName>
        <cfset email = getUser.email>
        <cfset gender = getUser.gender>
        <cfset dobDate = dateFormat(getUser.dob, 'dd')>
        <cfset dobMonth = dateFormat(getUser.dob, 'mm')>
        <cfset dobYear = dateFormat(getUser.dob, 'yyyy')>
        <cfif structKeyExists(form, 'password') AND len(form.password) GT 0> 
            <cfset checkPassword = bcrypt.checkpw(form.password, getUser.password)>
            <cfif checkPassword EQ true>
                <cfset hashPassword = bcrypt.hashpw(form.newPassword,gensalt)>
                <cfquery result="updatePassword">
                    UPDATE users SET  
                    password = <cfqueryparam value="#hashPassword#" cfsqltype="cf_sql_varchar">
                    WHERE PkUserId= <cfqueryparam value="#PkUserId#" cfsqltype="cf_sql_integer"> 
                </cfquery>
                <cfset session.user.saved = 6>
                <cflocation url="index.cfm?pg=profile" addtoken="false">
            <cfelse>
                <cfset session.user.error = 2>
                <cflocation url="index.cfm?pg=profile" addtoken="false">
            </cfif>
        </cfif>
        <cfif structKeyExists(form, 'PkUserId') AND form.PkUserId GT 0> 
            <cfset dob = dateFormat(CreateDate(form.year, form.month, form.day), 'yyyy-mm-dd')>
            <cfquery result="updateProfile">
                UPDATE users SET
                firstName = <cfqueryparam value="#form.firstName#" cfsqltype="cf_sql_varchar">
                , lastName = <cfqueryparam value="#form.lastName#" cfsqltype="cf_sql_varchar">
                , email = <cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">
                , dob = <cfqueryparam value="#dob#" cfsqltype="cf_sql_date">
                , gender = <cfqueryparam value="#form.gender#" cfsqltype="cf_sql_bit">
                WHERE PkUserId= <cfqueryparam value="#PkUserId#" cfsqltype="cf_sql_integer"> 
            </cfquery>
            <cfset session.user.saved = 5>
            <cfset session.user.firstName = form.firstName>
            <cfset session.user.lastName = form.lastName>
            <cfset session.user.email = form.email>
            <cfset session.user.gender = form.gender>
            <cfset session.user.dob = dob>
            <cflocation url="index.cfm?pg=profile" addtoken="false">
        </cfif>
    </cfif>
    <div class="page-heading">
        <div class="page-title">
            <div class="row">
                <div class="col-12 col-md-6 order-md-1 order-last">
                    <h1>Profile</h1>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="index.cfm?pg=profile">Dashboard</a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">
                                Profile
                            </li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
        <section class="section pt-5">
            <div class="row">
                <div class="col-md-4">
                    <div class="card  p-4 ">
                        <div class="card-body profile-card d-flex flex-column align-items-center">
                            <div class="img-container" id="OpenImgUpload">
                                <cfif listFind("1.jpg,2.jpg,3.jpg,4.jpg,5.jpg,6.jpg", session.user.profile)>
                                    <img src="../assets/compiled/jpg/#session.user.profile#" class="rounded-circle profileImg" alt="Profile">
                                <!--- <cfelse>
                                    <img src="../assets/compiled/jpg/1.jpg" class="rounded-circle profileImg" alt="Profile"> --->
                                </cfif>
                                <cfif NOT listFind("1.jpg,2.jpg,3.jpg,4.jpg,5.jpg,6.jpg", session.user.profile) AND structKeyExists(session.user, 'profile') AND len(session.user.profile) GT 0>
                                    <img src="../assets/profileImage/#session.user.profile#" class="rounded-circle profileImg" alt="Profile">
                                </cfif>
                                <span class="middle text">
                                    Change Hover
                                </span>
                            </div>
                            <div class="modal fade text-left" id="imageFileUpload" tabindex="-1" role="dialog" aria-labelledby="myModalLabel160" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered  modal-lg" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header bg-primary">
                                            <h5 class="modal-title white" id="myModalLabel160">
                                                Profile Picture
                                            </h5>
                                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                                <i data-feather="x"></i>
                                            </button>
                                        </div>
                                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                                            <li class="nav-item" role="presentation">
                                                <a class="nav-link active" id="default-upload-tab" data-bs-toggle="tab" href="##default-upload" role="tab" aria-controls="default-upload" aria-selected="true">
                                                    Deafult Upload
                                                </a>
                                            </li>
                                            <li class="nav-item" role="presentation">
                                                <a class="nav-link" id="custom-upload-tab" data-bs-toggle="tab" href="##custom-upload" role="tab" aria-controls="custom-upload" aria-selected="false">
                                                    Custom Upload
                                                </a>
                                            </li>
                                        </ul> 
                                        <div class="tab-content p-2" id="myTabContent"> 
                                            <div class="tab-pane fade show active" id="default-upload" aria-labelledby="default-upload-tab">
                                                <form enctype="multipart/form-data" class="row g-3 needs-validation" novalidate method="POST" id="defaultUploadForm">
                                                    <div class="modal-body">
                                                        <div class="DefaultImageRow row">
                                                            <label class="col-2">
                                                                <input class="form-check-input avtarCheck" <cfif structKeyExists(session.user, "profile") AND session.user.profile EQ '1.jpg'>checked</cfif> name="avtarProfile" type="radio" value="1.jpg"/>
                                                                <img id="avtar1" src="../assets/compiled/jpg/1.jpg" class="w-100 ">  
                                                            </label> 
                                                            <label class="col-2">
                                                                <input class="form-check-input avtarCheck " <cfif structKeyExists(session.user, "profile") AND session.user.profile EQ '2.jpg'>checked</cfif>  name="avtarProfile" type="radio" value="2.jpg" />
                                                                <img id="avtar2" src="../assets/compiled/jpg/2.jpg" class="w-100 ">     
                                                            </label> 
                                                            <label class="col-2">
                                                                <input class="form-check-input avtarCheck " <cfif structKeyExists(session.user, "profile") AND session.user.profile EQ '3.jpg'>checked</cfif> name="avtarProfile" type="radio" value="3.jpg" />
                                                                <img id="avtar3" src="../assets/compiled/jpg/3.jpg" class="w-100 ">  
                                                            </label> 
                                                            <label class="col-2">
                                                                <input class="form-check-input avtarCheck " <cfif structKeyExists(session.user, "profile") AND session.user.profile EQ '4.jpg'>checked</cfif> name="avtarProfile" type="radio" value="4.jpg" />
                                                                <img id="avtar4" src="../assets/compiled/jpg/4.jpg" class="w-100 ">     
                                                            </label> 
                                                            <label class="col-2">
                                                                <input class="form-check-input avtarCheck " <cfif structKeyExists(session.user, "profile") AND session.user.profile EQ '5.jpg'>checked</cfif> name="avtarProfile" type="radio" value="5.jpg" />
                                                                <img id="avtar5" src="../assets/compiled/jpg/5.jpg" class="w-100 ">  
                                                            </label> 
                                                            <label class="col-2">
                                                                <input class="form-check-input avtarCheck " <cfif structKeyExists(session.user, "profile") AND session.user.profile EQ '6.jpg'>checked</cfif> name="avtarProfile" type="radio" value="6.jpg" />
                                                                <img id="avtar6" src="../assets/compiled/jpg/6.jpg" class="w-100 ">  
                                                            </label> 
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
                                            <div class="tab-pane fade show" id="custom-upload" aria-labelledby="custom-upload-tab">
                                                <form enctype="multipart/form-data" class="row g-3 needs-validation" novalidate method="POST" id="customUploadForm">
                                                    <div class="modal-body">
                                                        <div class="col-12 mb-3">
                                                            <input type="file" class="form-control" name="customProfile" id="customProfile"  aria-describedby="inputGroupPrepend" onchange="readURL(this)">
                                                        </div>
                                                        <img id="imgPreviewProfile" src="" class="w-25">     
                                                        <div>
                                                            <p><span style="color:red;">*</span>Max Size: 200 kb</p>
                                                            
                                                            <p><span style="color:red;">*</span>Format Supported: JPG/JPEG/PNG</p>
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-light-secondary" data-bs-dismiss="modal">
                                                            <i class="bx bx-x d-block d-sm-none"></i>
                                                            <span class="d-none d-sm-block">Close</span>
                                                        </button>
                                                        <button type="submit" id="customUploadSubmit" class="btn btn-primary ms-1" >
                                                            <i class="bx bx-check d-block d-sm-none"></i>
                                                            <span class="d-none d-sm-block">Upload</span>
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <h2 class="mb-0 pt-1 h2">#session.user.firstName# #session.user.lastName#</h2>
                            <p class="fw-semibold mb-0">#session.user.email#</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="card  p-3">
                        <div class="card-body pt-3">  
                            <ul class="nav nav-tabs" id="myTab" role="tablist">
                                <li class="nav-item" role="presentation">
                                    <a class="nav-link <cfif structKeyExists(session.user, "saved") AND session.user.saved EQ 5>active<cfelseif NOT structKeyExists(session.user, 'saved')>active</cfif>" id="profile-edit-tab" data-bs-toggle="tab" href="##profile-edit" role="tab" aria-controls="profile-edit" aria-selected="true">
                                        Edit Profile
                                    </a>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <a class="nav-link <cfif structKeyExists(session.user, "saved") AND session.user.saved EQ 6> active</cfif>" id="change-password-tab" data-bs-toggle="tab" href="##change-password" role="tab" aria-controls="change-password" aria-selected="false">
                                        Change Password
                                    </a>
                                </li>
                            </ul> 
                            <div class="tab-content pt-5" id="myTabContent"> 
                                <div class="tab-pane fade show  <cfif structKeyExists(session.user, "saved") AND session.user.saved EQ 5>active<cfelseif NOT structKeyExists(session.user, 'saved')>active</cfif>" id="profile-edit" aria-labelledby="profile-edit-tab">
                                    <!-- Profile Edit Form -->
                                    <cfif structKeyExists(session.user, "saved") AND session.user.saved EQ 5>
                                        <div class="alert alert-light-success alert-dismissible show fade">
                                            <i class="bi bi-check-circle"></i> User Profile Succefully Updated!!!
                                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                        </div>
                                        <cfset StructDelete(session.user,'saved')>
                                    </cfif>
                                    <form action="" enctype="multipart/form-data" class="form mt-3" novalidate method="POST" id="editProfile">
                                        <input type="hidden" name="PkUserId" id="PkUserId" value="#PkUserId#">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <lable class="fw-bold form-label" for="firstName">First Name</lable>
                                                <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                                    <input type="text" class="form-control form-control-xl" id="firstName" name="firstName" placeholder="Enter First Name" value="#firstName#"/>
                                                    <div class="form-control-icon">
                                                        <i class="bi bi-person"></i>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <lable class="fw-bold form-label" for="lastName">Last Name</lable>
                                                <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                                    <input type="text" class="form-control form-control-xl" id="lastName" name="lastName" placeholder="Enter Last Name" value="#lastName#"/>
                                                    <div class="form-control-icon">
                                                        <i class="bi bi-person"></i>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
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
                                                                        <option value="#j#" <cfif dobDate EQ j  >selected</cfif>>#j#</option>
                                                                    </cfloop>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6"> 
                                            <lable class="fw-bold form-label" for="email">Email</lable>
                                            <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                                <input type="text" class="form-control form-control-xl" id="email" name="email" placeholder="Email" value="#email#"/>
                                                <div class="form-control-icon">
                                                    <i class="bi bi-envelope"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6"> 
                                            <lable class="fw-bold form-label" for="gender">Gender</lable>
                                            <div class="form-group position-relative has-icon-left mt-4">
                                                <div class="row genderRow">
                                                    <div class="col-md-6">
                                                            <div class="form-check">
                                                                <input class="form-check-input genderCheck" type="radio" name="gender" value="1" <cfif gender EQ 1>checked</cfif>>
                                                                <label class="form-check-label" for="male" id="male"> Male</label>
                                                            </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-check">
                                                            <input class="form-check-input genderCheck" type="radio" name="gender" value="0"  <cfif gender EQ 0>checked</cfif>>
                                                            <label class="form-check-label" for="female" id="female"> Female </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-4 mx-auto">
                                            <button type="submit" class="btn btn-primary btn-block btn-lg shadow-lg mx-auto">
                                                Update
                                            </button>
                                        </div>
                                    </form>
                                    <!-- End Profile Edit Form -->
                                </div>
                                <div class="tab-pane fade show <cfif structKeyExists(session.user, "saved") AND session.user.saved EQ 6> active</cfif>" id="change-password" aria-labelledby="change-password-tab">
                                    <!-- Change Password Form -->
                                    <cfif structKeyExists(session.user, "saved") AND session.user.saved EQ 6>
                                        <div class="alert alert-light-success alert-dismissible show fade">
                                            <i class="bi bi-check-circle"></i> User Password Succefully Updated!!!
                                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                        </div>
                                        <cfset StructDelete(session.user,'saved')>
                                    <cfelseif structKeyExists(session.user, "error") AND session.user.error EQ 2>
                                        <div class="alert alert-light-danger alert-dismissible show fade">
                                            <i class="bi bi-exclamation-circle"></i> User Old Password Doesn't Match!!!
                                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                        </div>
                                        <cfset StructDelete(session.user,'error')>
                                    </cfif>
                                    <form class="form mt-3" novalidate method="POST" id="checkPasswordMatch">
                                        <div class="row"> 
                                            <div class="col-md-12">
                                                <lable class="fw-bold form-label" for="password">Old Password <span class="text-danger">*</span></lable>
                                                <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                                    <input type="password" name="password" id="password" class="form-control form-control-xl" placeholder="Enter Your Old Password" value=""/>
                                                    <div class="form-control-icon">
                                                        <i class="bi bi-shield-lock"></i>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <lable class="fw-bold form-label" for="newPassword">New Password <span class="text-danger">*</span></lable>
                                                <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                                    <input type="password" name="newPassword" id="newPassword" class="form-control form-control-xl" placeholder="Enter your new password" value=""/>
                                                    <div class="form-control-icon">
                                                        <i class="bi bi-shield-lock"></i>
                                                    </div>
                                                </div>
                                                <div id="pswmeter" class="d-none"></div>
                                                <div id="pswmeter-message" class="d-none mb-3"></div>
                                            </div>
                                            <div class="col-md-12">
                                                <lable class="fw-bold form-label" for="confrimPassword">Confrim Password <span class="text-danger">*</span></lable>
                                                <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                                    <input type="password" name="confrimPassword" id="confrimPassword" class="form-control form-control-xl" placeholder="Enter your Confrim password" value=""/>
                                                    <div class="form-control-icon">
                                                        <i class="bi bi-shield-lock"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-12 d-flex justify-content-center">
                                            <button type="submit" class="btn btn-primary btn-sm" data-bs-toggle="tooltip" data-bs-html="true" data-bs-title="Update Password" data-bs-placement="bottom">Update</button>
                                        </div>
                                    </form>
                                    <!-- End Change Password Form -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</cfoutput>
<!--- password meter --->
<script async defer src="https://buttons.github.io/buttons.js"></script>
<script src="./assets/js/pswmeter.min.js"></script>
<script>
    $( document ).ready(function() {
        $('#newPassword').on('keyup',function(){
            if ($(this).val().length > 0) {
                $("#pswmeter").removeClass('d-none');
                $("#pswmeter-message").removeClass('d-none');
            } else {
                $("#pswmeter").addClass('d-none');
                $("#pswmeter-message").addClass('d-none');
            }
        });
        $("#editProfile").validate({
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
                    required: true,
                    minlength:8
                },
                confrimPassword: {
                    required:true,
                    equalTo: "##password"
                }
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
                },
                confrimPassword: {
                    required : "Please enter your confrim password",
                    equalTo : "Password did not match"
                }, 
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
                $(element).removeClass('is-invalid');
            } 
        });
        $( "#checkPasswordMatch" ).validate({
            rules: {
                password:{
                    required:true,
                },
                newPassword: {
                    required:true,
                    minlength: 8,
                },
                confrimPassword: {
                    required:true,
                    equalTo: "#newPassword"
                }
            },
            messages: {
                password: {
                    required : "Please Enter Your Password"
                },
                newPassword: {
                    required: "Please Enter Your New Password"
                },
                confrimPassword: {
                    required : "Please Enter Your Confrim Password",
                    equalTo : "Password did not match"
                },
        
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
        // open image upload model
        $("#OpenImgUpload").on("click", function () {
            $("#imageFileUpload").modal('show');
            $('#FkUserId').val('prc.structUserImage.PkUserId')
                $('#customProfile').change(function(){
                const file = this.files[0];
                if (file){
                    let reader = new FileReader();
                    reader.onload = function(event){
                        $('#imgPreviewProfile').attr('src', event.target.result);
                    }
                        reader.readAsDataURL(file);
                    }
            });
        });
        $("#defaultUploadSubmit").click(function(e) {
            e.preventDefault();
            var formData = new FormData($('#defaultUploadForm')[0]);
            $.ajax({
                type: "POST",
                url: "../ajaxUploadProfile.cfm",
                data: formData,
                processData: false,
                contentType: false,
                success: function(result) {
                    successToast("Profile image Updated!");
                    setTimeout(() => {
                        location.href = 'index.cfm?pg=profile';
                    }, 1000);
                    
                }
            });
        });
        $("#customUploadSubmit").click(function(e) {
            e.preventDefault();
            var formData = new FormData($('#customUploadForm')[0]);
            $.ajax({
                type: "POST",
                url: "../ajaxUploadProfile.cfm",
                data: formData,
                processData: false,
                contentType: false,
                success: function(result) {
                    successToast("Profile image Updated!");
                    setTimeout(() => {
                        location.href = 'index.cfm?pg=profile';
                    }, 1000);
                }
            });
        });
            
    });
    // Run pswmeter with options
    var pass = document.getElementById('newPassword');
    const myPassMeter = passwordStrengthMeter({
        containerElement: '#pswmeter',
        passwordInput: '#newPassword',
        showMessage: true,
        messageContainer: '#pswmeter-message',
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
        colorScore1: '#d91818',
        colorScore2: '#c37b48',
        colorScore3: '#ffc107',
        colorScore4: 'limegreen'
        
    });

</script>