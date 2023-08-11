<cfoutput>

    <cfparam name="email" default="" />
    <cfparam name="token" default="" />
    <cfparam name="password" default="" />
    <!--- <cfparam name="saved" default="" /> --->
    <cfset bcrypt = application.bcrypt>
    <cfset gensalt = bcrypt.gensalt()>

    <cfif structKeyExists(url, 'token') AND len(url.token) GT 0>  
        <cfquery name="getToken">
            SELECT email, PkCustomerId, token FROM customer  
            WHERE token = <cfqueryparam value="#url.token#" cfsqltype="cf_sql_varchar"> 
        </cfquery>
        <!--- <cfdump var="#getToken#"><cfabort> --->
        <cfif getToken.recordCount EQ 1>
            <cfif structKeyExists(form, 'password') AND len(form.password) GT 0> 
                <cfset hashPassword = bcrypt.hashpw(form.password,gensalt)>
                <cfquery result="updatePassword">
                    UPDATE customer SET  
                    password = <cfqueryparam value="#hashPassword#" cfsqltype="cf_sql_varchar"> 
                    , token = <cfqueryparam value="" null="true"> 
                    WHERE email= <cfqueryparam value="#trim(getToken.email)#" cfsqltype="cf_sql_varchar"> 
                </cfquery>
                <!---  <cfdump var="#updatePassword#">
                <cfabort> --->
                <cflocation url="login.cfm?saved=4" addtoken="false">
            </cfif>
        <cfelse>
            <cflocation url="http://127.0.0.1:51085/reset-password.cfm?tokenExpire=1" addtoken="false">
        </cfif>
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
                                    <cfif structKeyExists(url,"tokenExpire") AND url.tokenExpire EQ 1>
                                        <div class="alert alert-danger alert-dismissible show fade">
                                            <i class="fa fa-exclamation-circle"></i> Token Expired!!! 
                                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
                                            </button>
                                        </div>
                                    </cfif>
                                    <h1 class="auth-title">Reset Password</h1>
                                    <p class="auth-subtitle mb-5">
                                        Input your password and update your password.
                                    </p>
                                    <form method="POST" id="resetPassForm">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="form-floating form-group">
                                                    <input type="password" name="password" id="password" class="form-control form-control-xl" placeholder="Password" value=""/>
                                                    <label for="password" class="text-muted">
                                                        <i class="fa-solid fa-key"></i> 
                                                        Enter new password
                                                    </label>
                                                </div>
                                                <div id="pswmeter" class="d-none"></div>
                                                <div id="pswmeter-message" class="d-none mb-3"></div>
                                            </div>
                                            <div class="col-12">
                                                <div class="form-floating form-group">
                                                    <input type="password" name="confrimPassword" id="confrimPassword" class="form-control form-control-xl" placeholder="Confrim Password"/>
                                                    <label for="confrimPassword" class="text-muted">
                                                        <i class="fa-solid fa-key"></i> 
                                                        Enter confrim password
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <button type="submit" class="btn text-white d-block w-100 my-4 login-button">Reset</button>
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
                    <div class="col-lg-5 col-12">
                        <div id="auth-left">
                            <cfif structKeyExists(url,"tokenExpire") AND url.tokenExpire EQ 1>
                                <div class="alert alert-light-danger alert-dismissible show fade">
                                    <i class="bi bi-exclamation-circle"></i> Token Expired!!! 
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
                                    </button>
                                </div>
                            </cfif>
                            <h1 class="auth-title">Reset Password</h1>
                            <p class="auth-subtitle mb-5">
                                Input your password and update your password.
                            </p>
                            <form method="POST" id="resetPassForm">
                                <div class="form-group position-relative has-icon-left mb-4">
                                    <input type="password" name="password" id="password" class="form-control form-control-xl" placeholder="Password" value=""/>
                                    <div class="form-control-icon">
                                        <i class="bi bi-shield-lock"></i>
                                    </div>
                                </div>
                                <div id="pswmeter" class="d-none"></div>
                                <div id="pswmeter-message" class="d-none mb-3"></div>
                                <div class="form-group position-relative has-icon-left">
                                    <input type="password" name="confrimPassword" id="confrimPassword" class="form-control form-control-xl" placeholder="Confrim Password"/>
                                    <div class="form-control-icon">
                                        <i class="bi bi-shield-lock"></i>
                                    </div>
                                </div>
                                <div class="mx-auto col-6">
                                    <button type="submit" class="btn btn-primary btn-block btn-lg shadow-lg mt-3">
                                        Send
                                    </button>
                                </div>
                            </form>
                            <div class="text-center mt-5 text-lg fs-4">
                                <p class="text-gray-600">
                                    Remember your account?<a href="login.cfm" class="font-bold"> Log in</a>.
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-7 d-none d-lg-block">
                        <div id="auth-right"></div>
                    </div>
                </div>
            </div> --->

            <!--- js --->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js" integrity="sha512-rstIgDs0xPgmG6RX1Aba4KV5cWJbAMcvRCVmglpam9SoHZiUCyQVDdH2LPlxoHtrv17XWblE/V/PP+Tr04hbtA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
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
                    $("##resetPassForm").validate({
                        rules: {
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