<cfoutput>
    <cfif structKeyExists(session, "customer")>
        <cflocation url="index.cfm?pg=dashboard" addtoken="false">
    </cfif>
    <cfparam name="firstName" default="" />
    <cfparam name="lastName" default="" />
    <cfparam name="email" default="" />
    <cfparam name="gender" default="" />
    <cfparam name="dob" default="" />
    <cfset bcrypt = application.bcrypt>
    <cfset gensalt = bcrypt.gensalt()>
    <cfparam name="password" default="" />
    <cfif len(trim(email)) GT 0>
        <cfquery name="login">
            SELECT PkCustomerId, firstName, lastName, email, dob, password, gender, profile FROM customer 
            WHERE email = <cfqueryparam value="#trim(email)#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfif login.recordCount EQ 1>
            <!--- <cfset hashPassword = bcrypt.hashpw(login.password, gensalt)> --->
            <cfset checkPassword = bcrypt.checkpw(password, login.password)>
            <cfif checkPassword EQ true>
                <cfset session.customer = {}>
                <cfset session.customer.isLoggedIn = login.PkCustomerId>
                <cfset session.customer.firstName = login.firstName>
                <cfset session.customer.lastName = login.lastName>
                <cfset session.customer.email = login.email>
                <cfset session.customer.gender = login.gender>
                <cfset session.customer.dob = login.dob>
                <cfset session.customer.profile = login.profile>
                <cfset session.customer.saved = 1>
                <!--- <cfset saved = 2> --->
                <cflocation url="index.cfm?pg=dashboard" addtoken="false">
            <cfelse>
                <cflocation url="login.cfm?error=1" addtoken="false">
            </cfif>
        <cfelse>
            <cflocation url="login.cfm" addtoken="false">
        </cfif>
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
            <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

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
                body {
                    background: ##fccb90;
                    background: -webkit-linear-gradient(to right,  ##3cb0d1, ##324db1, ##5736dd, ##4581b4);
                    background: linear-gradient(to right, ##3cb0d1, ##324db1, ##5736dd, ##4581b4);
                }
            </style>
        </head>
        <body>
            <!-- Main Section-->
            <section class="d-flex justify-content-center align-items-center p-5" >
                <div class="container py-5 h-100">
                    <div class="row d-flex justify-content-center align-items-center h-100">
                        <div class="col col-xl-10">
                            <div class="card" style="border-radius: 1rem;">
                                <div class="row g-0">
                                    <div class="col-md-6 col-lg-5 d-none d-md-block">
                                    <img src="./assets/images/logos/woman-shopping-online.gif"
                                        alt="login form" class="img-fluid mt-5 pt-3" />
                                    </div>
                                    <div class="col-md-6 col-lg-7 d-flex align-items-center">
                                        <div class="card-bodyshadow-xl p-5 p-lg-5 bg-white rounded-3 text-black">
                                            <cfif structKeyExists(url,"saved") AND url.saved EQ 4>
                                                <div class="alert alert-success alert-dismissible show fade">
                                                    <i class="fa fa-check-circle"></i> Your password is succesfully set!!
                                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
                                                    </button>
                                                </div>
                                            <cfelseif structKeyExists(url,"error") AND url.error EQ 1>
                                                <div class="alert alert-danger alert-dismissible show fade">
                                                    <i class="fa fa-exclamation-circle"></i> Invalid User Name/Password!!
                                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
                                                    </button>
                                                </div>
                                            </cfif>
                                            <h1 class="text-center fw-bold mb-5 fs-2">Login Form</h1>
                                            <p class="auth-subtitle mb-4">
                                                Log in with your data that you entered during registration.
                                            </p>
                                            <form class="form" id="loginForm" method="POST">
                                                <div class="row">
                                                    <div class="col-12">
                                                        <label class="form-label d-flex justify-content-between align-items-center" for="login-email">Email address</label>
                                                        <div class="form-floating form-group position-relative">
                                                            <input type="email" class="form-control" name="email" id="email" placeholder="name@email.com">
                                                            <label for="email" class="text-muted">
                                                                <i class="fa-solid fa-envelope"></i>
                                                                Enter email address
                                                            </label>
                                                        </div>
                                                    </div>
                                                    <div class="col-12">
                                                        <label
                                                            for="login-password"
                                                            class="form-label d-flex justify-content-between align-items-center"
                                                        >
                                                            Password
                                                            <a href="forgot-password.cfm" class="text-muted small">Forgot your password?</a>
                                                        </label>
                                                        <div class="form-floating form-group">
                                                            <input
                                                                type="password"
                                                                class="form-control" name="password" id="password"
                                                                placeholder="Enter your password"
                                                            >
                                                            <label for="password" class="text-muted">
                                                                <i class="fa-solid fa-key"></i>
                                                                Enter password
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <button type="submit" class="btn text-white d-block w-100 my-4 login-button">Login</button>
                                            </form>
                                            <p class="d-block text-center text-muted">
                                                New customer? <a class="text-dark" href="sign-up.cfm">Sign up for an account</a>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!---  <section class="d-flex justify-content-center align-items-center p-5">
                <!-- Page Content Goes Here -->
                <!-- Login Form-->
                <div class="col col-md-8 col-lg-6 col-xxl-6 ">
                    <!--- <!-- Logo-->
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
                    <!-- / Logo--> --->
                    <div class="shadow-xl p-5 p-lg-5 bg-white rounded-3">
                        <cfif structKeyExists(url,"saved") AND url.saved EQ 4>
                            <div class="alert alert-light-success alert-dismissible show fade">
                                <i class="bi bi-check-circle"></i> Your password is succesfully set!!
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
                                </button>
                            </div>
                        <cfelseif structKeyExists(url,"error") AND url.error EQ 1>
                            <div class="alert alert-light-danger alert-dismissible show fade">
                                <i class="bi bi-exclamation-circle"></i> Invalid User Name/Password!!
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
                                </button>
                            </div>
                        </cfif>
                        <h1 class="text-center fw-bold mb-5 fs-2">Login Form</h1>
                        <p class="auth-subtitle mb-5">
                            Log in with your data that you entered during registration.
                        </p>
                        <form class="form" id="loginForm" method="POST">
                            <div class="form-group">
                                <label class="form-label" for="login-email">Email address</label>
                                <input type="email" class="form-control" name="email" id="email" placeholder="name@email.com">
                            </div>
                            <div class="form-group">
                                <label
                                    for="login-password"
                                    class="form-label d-flex justify-content-between align-items-center"
                                >
                                    Password
                                    <a href="##" class="text-muted small">Forgot your password?</a>
                                </label>
                                <input
                                    type="password"
                                    class="form-control" name="password" id="password"
                                    placeholder="Enter your password"
                                >
                            </div>
                            <button type="submit" class="btn btn-dark d-block w-100 my-4">Login</button>
                        </form>
                        <p class="d-block text-center text-muted">
                            New customer? <a class="text-dark" href="sign-up.cfm">Sign up for an account</a>
                        </p>
                    </div>
                </div>
                <!-- / Login Form-->
                <!-- /Page Content -->
            </section> --->
            <!-- / Main Section-->
            <!--- jquery validation js --->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js" integrity="sha512-rstIgDs0xPgmG6RX1Aba4KV5cWJbAMcvRCVmglpam9SoHZiUCyQVDdH2LPlxoHtrv17XWblE/V/PP+Tr04hbtA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
            <!-- Vendor JS -->
            <script src="./assets/js/vendor.bundle.js"></script>

            <!-- Theme JS -->
            <script src="./assets/js/theme.bundle.js"></script>

            <script>
                $( document ).ready(function() {
                    console.log('hiiiii');
                    $("##loginForm").validate({
                        rules: {
                            email: {
                                required: true,
                                email: true
                            },
                            password: {
                                required: true,
                                minlength:8
                            },
                        },
                        errorPlacement: function (error, element) {
                            error.insertAfter($(element).parent('div')); 
                        },
                        messages: { 
                            email: {
                                required: "Please enter your email address",                    
                            },
                            password: {
                                required: "Please enter your password"
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
                });
            </script>
        </body>
    </html>
</cfoutput>