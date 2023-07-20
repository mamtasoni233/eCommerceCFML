<cfoutput>

    <cfparam name="firstName" default="" />
    <cfparam name="lastName" default="" />
    <cfparam name="email" default="" />
    <cfparam name="gender" default="" />
    <cfparam name="dob" default="" />
    <cfset bcrypt = application.bcrypt>
    <cfset gensalt = bcrypt.gensalt()>
    <cfparam name="password" default="" />
    <!--- <cfset saved = 2> for register --->

    <cfif structKeyExists(form, 'firstName') AND len(form.firstName) GT 0> 
        <cfif structKeyExists(form, 'PkUserId') AND form.PkUserId EQ 0>
            <cfquery name="checkEmail">
                SELECT PkUserId, email FROM users 
                WHERE email = <cfqueryparam value="#trim(email)#" cfsqltype="cf_sql_varchar"> AND 
                PkUserId != <cfqueryparam value = "#form.PkUserId#" cfsqltype = "cf_sql_integer">
            </cfquery>
            <cfif checkEmail.recordCount GT 0>
                <cflocation url="auth-register.cfm?checkEmail=1" addtoken="false">
            </cfif>     
        </cfif>
        
        <cfset dob = dateFormat(CreateDate(form.year, form.month, form.day), 'yyyy-mm-dd')>
        <cfset hashPassword = bcrypt.hashpw(form.password,gensalt)>
        <cfquery name="insertUserQuery">
            INSERT INTO users (
                firstName
                , lastName
                , email
                , dob
                , gender
                , password
            ) VALUES (
                <cfqueryparam value = "#form.firstName#" cfsqltype = "cf_sql_varchar">
                , <cfqueryparam value = "#form.lastName#" cfsqltype = "cf_sql_varchar">
                , <cfqueryparam value = "#form.email#" cfsqltype = "cf_sql_varchar">
                , <cfqueryparam value = "#dob#" cfsqltype = "cf_sql_date">
                , <cfqueryparam value = "#form.gender#" cfsqltype = "cf_sql_bit">
                , <cfqueryparam value = "#hashPassword#" cfsqltype = "cf_sql_varchar">
            )
        </cfquery>
        <cflocation url="auth-register.cfm?saved=2" addtoken="false">
    </cfif>
    <!DOCTYPE html>
    <html lang="en">
        <cfinclude template="common/login-head.cfm">
        <style>
            .invalidCs{
                border:1px solid red !important;
            }
        </style>
        <body>
            <div id="auth">
                <div class="row h-100">
                    <div class="col-lg-3">
                        <div id="auth-right"></div>
                    </div>
                    <div class="col-lg-6 col-12">
                        <div id="auth-left">
                            <h1 class="auth-title mt-0">Sign Up</h1>
                            <p class="auth-subtitle mb-5">
                                Input your data to register to our website.
                            </p>
                            <cfif structKeyExists(url,"saved") AND url.saved EQ 2>
                                <div class="alert alert alert-light-success alert-dismissible show fade">
                                    <i class="bi bi-check-circle"></i> User Succefully created!!!
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
                                    </button>
                                </div>
                            <cfelseif structKeyExists(url,"checkEmail") AND url.checkEmail EQ 1>
                                <div class="alert alert-light-danger alert-dismissible show fade">
                                    <i class="bi bi-exclamation-circle"></i> Email already exist!!!
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
                                    </button>
                                </div>
                            </cfif>
                            <form class="form" id="register" method="POST" action="">
                                <input type="hidden" value="0" name="PkUserId">
                                <div class="row">
                                    <div class="col-md-12">
                                        <lable class="fw-bold form-label" for="firstName">First Name</lable>
                                        <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                            <input type="text" class="form-control form-control-xl" id="firstName" name="firstName" placeholder="First Name"/>
                                            <div class="form-control-icon">
                                                <i class="bi bi-person"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <lable class="fw-bold form-label" for="lastName">Last Name</lable>
                                        <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                            <input type="text" class="form-control form-control-xl" id="lastName" name="lastName" placeholder="Last Name"/>
                                            <div class="form-control-icon">
                                                <i class="bi bi-person"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12"> 
                                        <lable class="fw-bold form-label" for="email">Email</lable>
                                        <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                            <input type="text" class="form-control form-control-xl" id="email" name="email" placeholder="Email"/>
                                            <div class="form-control-icon">
                                                <i class="bi bi-envelope"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12"> 
                                        <lable class="fw-bold form-label" for="gender">Gender</lable>
                                        <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                            <div class="row genderRow">
                                                <div class="col-md-6">
                                                        <div class="form-check ms-5">
                                                            <input class="form-check-input genderCheck" type="radio" name="gender" value="1">
                                                            <label class="form-check-label" for="male" id="male"> Male</label>
                                                        </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-check ms-5">
                                                        <input class="form-check-input genderCheck" type="radio" name="gender" value="0">
                                                        <label class="form-check-label" for="female" id="female"> Female </label>
                                                    </div>
                                                </div>
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
                                                                <option value="#idx#">#idx#</option>
                                                            </cfloop>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <select name="month" class="form-select" id="month">
                                                            <option value="" selected class="opacity-100">Month</option>
                                                            <cfloop from="1" to="12" index="i">
                                                                <option value="#i#">#i#</option>
                                                            </cfloop>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <select name="day" class="form-select" id="day">
                                                            <option value="" class="opacity-100">Day</option>
                                                            <cfloop from="1" to="31" index="j">
                                                                <option value="#j#">#j#</option>
                                                            </cfloop>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <lable class="fw-bold form-label" for="password">Password</lable>
                                        <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                            <input type="password" name="password" id="password" class="form-control form-control-xl" placeholder="Password" value=""/>
                                            <div class="form-control-icon">
                                                <i class="bi bi-shield-lock"></i>
                                            </div>
                                        </div>
                                        <div id="pswmeter" class="d-none"></div>
                                        <div id="pswmeter-message" class="d-none mb-3"></div>
                                    </div>
                                    <div class="col-md-12">
                                        <lable class="fw-bold form-label" for="confrimPassword">Confrim Password</lable>
                                        <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                            <input type="password" name="confrimPassword" id="confrimPassword" class="form-control form-control-xl" placeholder="Confrim Password"/>
                                            <div class="form-control-icon">
                                                <i class="bi bi-shield-lock"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <!--- <div>
                                        <div class="form-check form-check-lg d-flex align-items-end">
                                            <input class="form-check-input me-2" type="checkbox" value="" id="flexCheckDefault"/>
                                            <label class="form-check-label text-gray-600" for="flexCheckDefault">
                                                Keep me logged in
                                            </label>
                                        </div>
                                    </div> --->
                                </div>
                                <div class="col-4 mx-auto">
                                    <button type="submit" class="btn btn-primary btn-block btn-lg shadow-lg mx-auto">
                                        Register Here
                                    </button>
                                </div>
                            </form>
                            <div class="text-center mt-5 text-lg fs-4">
                                <p class="text-gray-600">
                                    Do you have an account?
                                    <a href="login.cfm" class="font-bold">Login</a>.
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 d-none d-lg-block">
                        <div id="auth-right"></div>
                    </div>
                </div>
            </div>

            <!--- JS --->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js" integrity="sha512-rstIgDs0xPgmG6RX1Aba4KV5cWJbAMcvRCVmglpam9SoHZiUCyQVDdH2LPlxoHtrv17XWblE/V/PP+Tr04hbtA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
            
            <script src="assets/static/js/components/dark.js"></script>
            <script src="assets/extensions/perfect-scrollbar/perfect-scrollbar.min.js"></script>
            
            <script src="assets/extensions/choices.js/public/assets/scripts/choices.js"></script>
            <script src="assets/static/js/pages/form-element-select.js"></script>
            <script src="assets/compiled/js/app.js"></script> 
            <!--- password meter --->
            <script async defer src="https://buttons.github.io/buttons.js"></script>
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
                    $("##register").validate({
                        rules: {
                            firstName: {
                                required: true
                            },
                            lastName: {
                                required: true
                            },
                            /*  gender: {
                                required: true
                            }, */
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
        </body>
    </html>
</cfoutput>