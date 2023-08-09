<cfoutput>
    <cfparam name="firstName" default="" />
    <cfparam name="lastName" default="" />
    <cfparam name="email" default="" />
    <cfparam name="gender" default="" />
    <cfparam name="dob" default="" />
    <cfset bcrypt = application.bcrypt>
    <cfset gensalt = bcrypt.gensalt()>
    <cfparam name="password" default="" />

    <cfif structKeyExists(form, 'firstName') AND len(form.firstName) GT 0> 
        <cfif structKeyExists(form, 'PkCustomerId') AND form.PkCustomerId EQ 0>
            <cfquery name="checkEmail">
                SELECT PkCustomerId, email FROM customer 
                WHERE email = <cfqueryparam value="#trim(email)#" cfsqltype="cf_sql_varchar"> AND 
                PkCustomerId != <cfqueryparam value = "#form.PkCustomerId#" cfsqltype = "cf_sql_integer">
            </cfquery>
            <cfif checkEmail.recordCount GT 0>
                <cflocation url="auth-register.cfm?checkEmail=1" addtoken="false">
            </cfif>     
        </cfif>
        
        <cfset dob = dateFormat(CreateDate(form.year, form.month, form.day), 'yyyy-mm-dd')>
        <cfset hashPassword = bcrypt.hashpw(form.password,gensalt)>
        <cfquery name="insertUserQuery">
            INSERT INTO customer (
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
    <!doctype html>
    <html lang="en">
        <head>
            <!-- Page Meta Tags-->
            <meta charset="utf-8">
            <meta http-equiv="x-ua-compatible" content="ie=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <meta name="description" content="">
            <meta name="author" content="">
            <meta name="keywords" content="">

            <!-- Custom Google Fonts-->
            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link
                href="https://fonts.googleapis.com/css2?family=Oswald:wght@500;600&family=Roboto:wght@300;400;700&display=auto"
                rel="stylesheet"
            >

            <!-- Favicon -->
            <link rel="apple-touch-icon" sizes="180x180" href="./assets/favicon/apple-touch-icon.png">
            <link rel="icon" type="image/png" sizes="32x32" href="./assets/favicon/favicon-32x32.png">
            <link rel="icon" type="image/png" sizes="16x16" href="./assets/favicon/favicon-16x16.png">
            <link rel="mask-icon" href="./assets/favicon/safari-pinned-tab.svg" color="##5bbad5">
            <meta name="msapplication-TileColor" content="##da532c">
            <meta name="theme-color" content="##ffffff">

            <!-- Vendor CSS -->
            <link rel="stylesheet" href="./assets/css/libs.bundle.css"/>

            <!-- Main CSS -->
            <link rel="stylesheet" href="./assets/css/theme.bundle.css"/>
            <!-- jquery -->
            <script
                src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"
                integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw=="
                crossorigin="anonymous"
                referrerpolicy="no-referrer"
            ></script>

            <!-- Fix for custom scrollbar if JS is disabled-->
            <noscript>
                <style>
                    /**
                    * Reinstate scrolling for non-JS clients
                    */
                    .simplebar-content-wrapper {
                    overflow: auto;
                    }
                </style>
            </noscript>
            <!-- Page Title -->
            <title>Alpine | Bootstrap 5 HTML Template</title>
            <style>
                .invalidCs{
                    border:1px solid red !important;
                }
            </style>
        </head>
        <body class=" bg-light">
            <!-- Main Section-->
            <section class="mt-0 overflow-hidden  vh-100 d-flex justify-content-center align-items-center p-4">
                <!-- Page Content Goes Here -->

                <!-- Login Form-->
                <div class="col col-md-8 col-lg-6 col-xxl-5">
                    <!-- Logo-->
                    <a
                        class="navbar-brand fw-bold fs-3 flex-shrink-0 order-0 align-self-center justify-content-center d-flex mx-0 px-0"
                        href="./index.cfm"
                    >
                        <div class="d-flex align-items-center">
                            <div class="f-w-6 d-flex align-items-center me-2 lh-1">
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 194 194">
                                    <path
                                        fill="currentColor"
                                        class="svg-logo-white"
                                        d="M47.45,60l1.36,27.58,53.41-51.66,50.87,50,3.84-26L194,100.65V31.94A31.94,31.94,0,0,0,162.06,0H31.94A31.94,31.94,0,0,0,0,31.94v82.57Z"
                                    />
                                    <path
                                        fill="currentColor"
                                        class="svg-logo-dark"
                                        d="M178.8,113.19l1,34.41L116.3,85.92l-14.12,15.9L88.07,85.92,24.58,147.53l.93-34.41L0,134.86v27.2A31.94,31.94,0,0,0,31.94,194H162.06A31.94,31.94,0,0,0,194,162.06V125.83Z"
                                    />
                                </svg>
                            </div>
                            <span class="fs-5">Alpine</span>
                        </div>
                    </a>
                    <!-- / Logo-->
                    <div class="shadow-xl p-4 p-lg-5 bg-white">
                        <h1 class="text-center mb-5 fs-2 fw-bold">Open Account</h1>
                        <a href="#" class="btn btn-facebook d-block mb-2"><i class="ri-facebook-circle-fill align-bottom"></i> Login
                            with Facebook</a>
                        <a href="#" class="btn btn-twitter d-block mb-2"><i class="ri-twitter-fill align-bottom"></i> Login with
                            Twitter</a>
                        <span class="text-muted text-center d-block fw-bolder my-4">OR</span>
                        <form>
                            <div class="form-group">
                                <lable class="fw-bold form-label" for="firstName">First Name</lable>
                                <div class="position-relative has-icon-left mb-4 mt-2">
                                    <input type="text" class="form-control form-control-xl" id="firstName" name="firstName" placeholder="First Name"/>
                                    <div class="form-control-icon">
                                        <i class="bi bi-person"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <lable class="fw-bold form-label" for="lastName">Last Name</lable>
                                <div class="position-relative has-icon-left mb-4 mt-2">
                                    <input type="text" class="form-control form-control-xl" id="lastName" name="lastName" placeholder="Last Name"/>
                                    <div class="form-control-icon">
                                        <i class="bi bi-person"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
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
                            <div class="form-group">
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
                            <div class="form-group">
                                <lable class="fw-bold form-label" for="password">Password</lable>
                                <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                    <input type="password" name="password" id="password" class="form-control form-control-xl" placeholder="Enter Your Password" value=""/>
                                    <div class="form-control-icon">
                                        <i class="bi bi-shield-lock"></i>
                                    </div>
                                </div>
                                <div id="pswmeter" class="d-none"></div>
                                <div id="pswmeter-message" class="d-none mb-3"></div>
                            </div>
                            <div class="form-group">
                                <lable class="fw-bold form-label" for="confrimPassword">Confrim Password</lable>
                                <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                    <input type="password" name="confrimPassword" id="confrimPassword" class="form-control form-control-xl" placeholder="Confrim Password"/>
                                    <div class="form-control-icon">
                                        <i class="bi bi-shield-lock"></i>
                                    </div>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-dark d-block w-100 my-4">Sign Up</button>
                        </form>
                        <p class="d-block text-center text-muted">
                            Already registered? <a class="text-dark" href="login.cfm">Login here.</a>
                        </p>
                    </div>
                </div>
                <!-- / Login Form-->
                <!-- /Page Content -->
            </section>
            <!-- / Main Section-->
            <!--- jquery validation js --->
            <script
                src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"
                integrity="sha512-rstIgDs0xPgmG6RX1Aba4KV5cWJbAMcvRCVmglpam9SoHZiUCyQVDdH2LPlxoHtrv17XWblE/V/PP+Tr04hbtA=="
                crossorigin="anonymous"
                referrerpolicy="no-referrer"
            ></script>
            <!-- Vendor JS -->
            <script src="./assets/js/vendor.bundle.js"></script>

            <!-- Theme JS -->
            <script src="./assets/js/theme.bundle.js"></script>
            <script src="./assets/js/pswmeter.min.js"></script>

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
