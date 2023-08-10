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
                <cflocation url="sign-up.cfm?checkEmail=1" addtoken="false">
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
        <cflocation url="sign-up.cfm?saved=2" addtoken="false">
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
            <!--- fontawsome --->
            <script src="https://kit.fontawesome.com/194ef163b5.js" crossorigin="anonymous"></script>
            <!-- Vendor CSS -->
            <link rel="stylesheet" href="./assets/css/libs.bundle.css"/>
            <!-- Main CSS -->
            <link rel="stylesheet" href="./assets/css/theme.bundle.css"/>
            <link rel="stylesheet" href="./assets/css/custom.css"/>
            <!-- jquery -->
            <script
                src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"
                integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw=="
                crossorigin="anonymous"
                referrerpolicy="no-referrer"
            ></script>

            <!-- Fix for custom scrollbar if JS is disabled-->
            <!--- <noscript>
                <style>
                    /**
                    * Reinstate scrolling for non-JS clients
                    */
                    .simplebar-content-wrapper {
                    overflow: auto;
                    }
                </style>
            </noscript> --->
            <!-- Page Title -->
            <title>Alpine | Bootstrap 5 HTML Template</title>
            <style>
                .invalidCs{
                    border:1px solid red !important;
                }
                body {
                    background: ##fccb90;
                    background: -webkit-linear-gradient(to right, ##ee7724, ##d8363a, ##dd3675, ##b44593);
                    background: linear-gradient(to right, ##3cb0d1, ##324db1, ##5736dd, ##4581b4);
                }
            </style>
        </head>
        <body>
            <!-- Main Section-->
                        <section class="" >
                <div class="container py-5 h-100">
                    <div class="row d-flex justify-content-center align-items-center h-100">
                        <div class="col-12 col-xl-11">
                            <div class="card" style="border-radius: 1rem;">
                                <div class="row g-0">
                                    <div class="col-md-6 col-lg-5 col-xl-5 d-none d-md-block">
                                    <img src="./assets/images/logos/woman-shopping-online.gif"
                                        alt="login form" class="img-fluid mt-5 pt-3" />
                                    </div>
                                    <div class="col-md-6 col-lg-7 d-flex align-items-center">
                                        <div class="card-bodyshadow-xl p-5 p-lg-5 bg-white rounded-3 text-black">
                                            <h1 class="text-center mb-5 fs-2 fw-bold">Sign Up</h1>
                                            <p class="auth-subtitle mb-4">
                                                Log in with your data that you entered during registration.
                                            </p>
                                            <cfif structKeyExists(url,"saved") AND url.saved EQ 2>
                                                <div class="alert alert alert-success alert-dismissible show fade">
                                                    <i class="fa-regular fa-circle-check"></i> User Succefully created!!!
                                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
                                                    </button>
                                                </div>
                                            <cfelseif structKeyExists(url,"checkEmail") AND url.checkEmail EQ 1>
                                                <div class="alert alert-danger alert-dismissible show fade">
                                                    <i class="fa-solid fa-circle-exclamation"></i> Email already exist!!!
                                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
                                                    </button>
                                                </div>
                                            </cfif>
                                            <form class="form" id="register" method="POST" action="">
                                                <input type="hidden" value="0" name="PkCustomerId">
                                                <div class="row">
                                                    <div class="col-12 col-md-6">
                                                        <lable class="form-label d-flex justify-content-between align-items-center" for="firstName">First Name</lable>
                                                        <div class="form-group position-relative">
                                                            <input type="text" class="form-control form-control-xl" id="firstName" name="firstName" placeholder="First Name"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-12 col-md-6">
                                                        <lablel class="form-label d-flex justify-content-between align-items-center" for="lastName">Last Name</lablel>
                                                        <div class="form-group position-relative">
                                                            <input type="text" class="form-control form-control-xl" id="lastName" name="lastName" placeholder="Last Name"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-12 col-md-6">
                                                        <lablel class="form-label d-flex justify-content-between align-items-center" for="email">Email</lablel>
                                                        <div class="form-group position-relative">
                                                            <input type="text" class="form-control form-control-xl" id="email" name="email" placeholder="Email"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-12 col-md-6">
                                                        <lablel class="form-label d-flex justify-content-between align-items-center" for="gender">Gender</lablel>
                                                        <div class="form-group position-relative">
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
                                                    <div class="col-12">
                                                        <lable class="fw-bold form-label " for="dob">DOB</lable>
                                                        <div class="form-group position-relative">
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
                                                    <div class="col-12 col-md-6">
                                                        <lable class="form-label d-flex justify-content-between align-items-center" for="password">Password</lable>
                                                        <div class="form-group position-relative ">
                                                            <input type="password" name="password" id="password" class="form-control form-control-xl" placeholder="Enter Your Password" value=""/>
                                                        </div>
                                                        <div id="pswmeter" class="d-none"></div>
                                                        <div id="pswmeter-message" class="d-none mb-3"></div>
                                                    </div>
                                                    <div class="col-12 col-md-6">
                                                        <lable class="form-label d-flex justify-content-between align-items-center" for="confrimPassword">Confrim Password</lable>
                                                        <div class="form-group position-relative ">
                                                            <input type="password" name="confrimPassword" id="confrimPassword" class="form-control form-control-xl" placeholder="Confrim Password"/>
                                                        </div>
                                                        <div id="pswmeter" class="d-none"></div>
                                                        <div id="pswmeter-message" class="d-none mb-3"></div>
                                                    </div>
                                                </div>
                                                <button type="submit" class="btn text-white d-block w-100 my-4 signup-button">Sign Up</button>
                                            </form>
                                            <p class="d-block text-center text-muted">
                                                Already registered? <a class="text-dark" href="login.cfm">Login here.</a>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section> 
            <!---  <section class=" d-flex justify-content-center align-items-center p-5">
                <!-- Page Content Goes Here -->

                <!-- Login Form-->
                <div class="col col-md-8 col-lg-6 col-xxl-6">
                    <div class="shadow-xl p-5 p-lg-5 bg-white rounded-3">
                        <h1 class="text-center mb-5 fs-2 fw-bold">Sign Up</h1>
                        <cfif structKeyExists(url,"saved") AND url.saved EQ 2>
                            <div class="alert alert alert-success alert-dismissible show fade">
                                <i class="fa-regular fa-circle-check"></i> User Succefully created!!!
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
                                </button>
                            </div>
                        <cfelseif structKeyExists(url,"checkEmail") AND url.checkEmail EQ 1>
                            <div class="alert alert-danger alert-dismissible show fade">
                                <i class="fa-solid fa-circle-exclamation"></i> Email already exist!!!
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
                                </button>
                            </div>
                        </cfif>
                        <form class="form" id="register" method="POST" action="">
                            <input type="hidden" value="0" name="PkCustomerId">
                            <div class="form-group">
                                <lable class="fw-bold form-label" for="firstName">First Name</lable>
                                <div class="input-group position-relative has-icon-left mb-4 mt-2">
                                    <div class="input-group-text">
                                        <i class="fa-solid fa-user-large"></i>
                                    </div>
                                    <input type="text" class="form-control form-control-xl" id="firstName" name="firstName" placeholder="First Name"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <lable class="fw-bold form-label" for="lastName">Last Name</lable>
                                <div class="input-group position-relative has-icon-left mb-4 mt-2">
                                    <span class="">
                                        <i class="fa-solid fa-user-large"></i>
                                    </span>
                                    <input type="text" class="form-control form-control-xl" id="lastName" name="lastName" placeholder="Last Name"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <lable class="fw-bold form-label" for="email">Email</lable>
                                <div class="input-group position-relative has-icon-left mb-4 mt-2">
                                    <div class="input-group-text">
                                        <i class="fa fa-envelope"></i>
                                    </div>
                                    <input type="text" class="form-control form-control-xl" id="email" name="email" placeholder="Email"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <lable class="fw-bold form-label" for="gender">Gender</lable>
                                <div class="input-group position-relative has-icon-left mb-4 mt-2">
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
                                <div class=" position-relative has-icon-left mb-4 mt-2">
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
                                <div class="input-group position-relative has-icon-left mb-4 mt-2">
                                    <div class="input-group-text">
                                        <i class="fa-solid fa-shield"></i>
                                    </div>
                                    <input type="password" name="password" id="password" class="form-control form-control-xl" placeholder="Enter Your Password" value=""/>
                                </div>
                                <div id="pswmeter" class="d-none"></div>
                                <div id="pswmeter-message" class="d-none mb-3"></div>
                            </div>
                            <div class="form-group">
                                <lable class="fw-bold form-label" for="confrimPassword">Confrim Password</lable>
                                <div class="input-group position-relative has-icon-left mb-4 mt-2">
                                    <div class="input-group-text">
                                        <i class="fa-solid fa-shield"></i>
                                    </div>
                                    <input type="password" name="confrimPassword" id="confrimPassword" class="form-control form-control-xl" placeholder="Confrim Password"/>
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
            </section> --->
            <!-- / Main Section-->
            <!--- jquery validation js --->
            <script
                src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"
                integrity="sha512-rstIgDs0xPgmG6RX1Aba4KV5cWJbAMcvRCVmglpam9SoHZiUCyQVDdH2LPlxoHtrv17XWblE/V/PP+Tr04hbtA=="
                crossorigin="anonymous"
                referrerpolicy="no-referrer"
            ></script>
            <script async defer src="https://buttons.github.io/buttons.js"></script>
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
