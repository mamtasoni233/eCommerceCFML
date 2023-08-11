<cfoutput>

    <cfparam name="email" default="" />
    <cfparam name="token" default="" />
    <cfparam name="saved" default="" />
    <cfset bcrypt = application.bcrypt>
    <cfset gensalt = bcrypt.gensalt()>

    <cfif structKeyExists(form, 'email') AND len(form.email) GT 0>  
        <cfquery name="getMail">
            SELECT PkCustomerId, firstName, lastName, email, dob, password, gender, token FROM customer 
            WHERE email = <cfqueryparam value="#trim(form.email)#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfif getMail.recordCount EQ 1>
            <cfset token = createUUID()>
            <cfset email = getMail.email>
            <cfset PkCustomerId = getMail.PkCustomerId>
            <cfquery result="addToken">
                UPDATE customer SET 
                token = <cfqueryparam value="#token#" cfsqltype="cf_sql_varchar">
                WHERE email = <cfqueryparam value="#trim(email)#" cfsqltype="cf_sql_varchar"> 
                AND PkCustomerId = <cfqueryparam value="#PkCustomerId#" cfsqltype="cf_sql_integer">
            </cfquery>
            <cfmail from="mamta.s@lucidsolutions.in" to="#email#"
                subject="Hello from CFML" 
                type="html">
                <cfmailpart type="text/html">
                    <div>
                        Hii! <b>#getMail.firstName# #getMail.lastName#</b> <br>
                        If you have lost your password and wish to reset it,  <br>
                        use the link below get started....  <br>
                    </div>
                    <button style="background: blue; padding: 10px; margin-top: 10px; border-radius: 20px;">
                        <a style="text-decoration: none; color: white;" href="http://127.0.0.1:51085/reset-password.cfm?token=#token#">Reset Your Password</a>
                    </button>
                </cfmailpart>
            </cfmail>
        </cfif>
        <cfset saved = 3>
    </cfif>
    <!DOCTYPE html>
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
            <section class="d-flex justify-content-center align-items-center p-5" >
                <div class="container py-5 h-100">
                    <div class="row d-flex justify-content-center align-items-center h-100">
                        <div class="col-md-6 col-lg-5 col-xl-5 d-flex align-items-center">
                            <div class="card" style="border-radius: 1rem;">
                                <div class="card-bodyshadow-xl p-5 p-lg-5 bg-white rounded-3 text-black">
                                    <cfif structKeyExists(variables, 'saved') AND saved EQ 3>
                                        <div class="alert alert alert-success alert-dismissible show fade">
                                            <i class="fa fa-check-circle"></i> Your reset password link has been sent to your email address!!!
                                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
                                            </button>
                                        </div>
                                    </cfif>
                                    <h1 class="auth-title">Forgot Password</h1>
                                    <p class="auth-subtitle mb-5">
                                        Input your email and we will send you reset password link.
                                    </p>
                                    <form method="POST" action="" id="forgotPassForm">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="form-floating form-group">
                                                    <input type="email" name="email" id="email" class="form-control form-control-xl" placeholder="Please enter your email address"/>
                                                    <label for="email" class="text-muted">Please enter your email!</label>
                                                </div>
                                            </div>
                                        </div>
                                        <button type="submit" class="btn text-white d-block w-100 my-4 login-button">Send</button>
                                        <!--- <button type="submit" class="btn btn-primary btn-block btn-lg shadow-lg mt-5">
                                            Send
                                        </button> --->
                                    </form>
                                    <div class="text-center mt-5 text-lg fs-4">
                                        <p class="text-gray-600">
                                            Remember your account?<a href="login.cfm" class="font-bold"> Log in</a>.
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!---  <div id="auth">
                <div class="row h-100">
                    <div class="col-lg-5 col-xl-5 col-12">
                        <div id="auth-left">
                            <cfif structKeyExists(variables, 'saved') AND saved EQ 3>
                                <div class="alert alert alert-success alert-dismissible show fade">
                                    <i class="bi bi-check-circle"></i> Your reset password link has been sent to your email address!!!
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
                                    </button>
                                </div>
                            </cfif>
                            <h1 class="auth-title">Forgot Password</h1>
                            <p class="auth-subtitle mb-5">
                                Input your email and we will send you reset password link.
                            </p>
                            <form method="POST" action="" id="forgotPassForm">
                                <div class="form-group position-relative has-icon-left mb-4">
                                    <input type="email" name="email" class="form-control form-control-xl" placeholder="Email"/>
                                    <div class="form-control-icon">
                                        <i class="bi bi-envelope"></i>
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-primary btn-block btn-lg shadow-lg mt-5">
                                    Send
                                </button>
                            </form>
                            <div class="text-center mt-5 text-lg fs-4">
                                <p class="text-gray-600">
                                    Remember your account?<a href="login.cfm" class="font-bold">Log in</a>.
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-7 d-none d-lg-block">
                        <div id="auth-right"></div>
                    </div>
                </div>
            </div> --->

            <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js" integrity="sha512-rstIgDs0xPgmG6RX1Aba4KV5cWJbAMcvRCVmglpam9SoHZiUCyQVDdH2LPlxoHtrv17XWblE/V/PP+Tr04hbtA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
            <!-- Vendor JS -->
            <script src="./assets/js/vendor.bundle.js"></script>

            <!-- Theme JS -->
            <script src="./assets/js/theme.bundle.js"></script>
            <script>
                $( document ).ready(function() {
                    $("##forgotPassForm").validate({
                        rules: {
                            email: {
                                required: true,
                                email: true
                            },
                        },
                        messages: {  
                            email: {
                                required: "Please enter your email address", 
                            },
                        },
                        ignore: [],
                        errorElement: 'span',
                        errorPlacement: function (error, element) {
                            
                            error.insertAfter(element);
                            error.addClass('invalid-feedback');
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