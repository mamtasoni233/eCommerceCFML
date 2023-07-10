<cfoutput>
    <cfif StructKeyExists(session, "isLoggedIn")>
        <cflocation url="index.cfm" addtoken="false">
    <cfelse>
        <cfinclude template="common/login-head.cfm">
        <body>
            <cfparam name="msg" default=""/>
            <cfparam name="email" default="" />
            <cfparam name="password" default="" />
            <cfset bcrypt = application.bcrypt>
            <cfset gensalt = bcrypt.gensalt()>
            <cfif structKeyExists(url,'msg') AND url.msg != ''>
                <cfset msg = url.msg>
            <cfelse>
                <cfset msg = "">
            </cfif>
            <cfif len(trim(email)) GT 0>
                <cfquery name="login">
                    SELECT PkUserId, firstName, lastName, email, dob, password, gender FROM users 
                    WHERE email = <cfqueryparam value="#trim(email)#" cfsqltype="cf_sql_varchar">
                </cfquery>
                <cfif login.recordCount EQ 1>
                    <!--- <cfset hashPassword = bcrypt.hashpw(login.password, gensalt)> --->
                    <cfset checkPassword = bcrypt.checkpw(password, login.password)>
                    <cfif checkPassword EQ true>
                        <cfset session.isLoggedIn = login.PkUserId>
                        <cflocation url="index.cfm" addtoken="false">
                    <cfelse>
                        <cflocation url="login.cfm?error=1" addtoken="false">
                    </cfif>
                <cfelse>
                    <cflocation url="login.cfm" addtoken="false">
                </cfif>
            </cfif>
            <!--- JS --->
            <script src="assets/static/js/initTheme.js"></script>
            <div id="auth">
                <div class="row h-100">
                    <div class="col-lg-5 col-12">
                        <div id="auth-left">
                            <div class="auth-logo">
                                <a href="index.html">
                                    <img src="assets/compiled/svg/logo.svg" alt="Logo"/>
                                </a>
                            </div>
                            <cfif msg != ''>
                                <div class="alert alert-success alert-dismissible show fade">
                                    <strong>User Succefully created!!!</strong> 
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
                                    </button>
                                </div>
                            <cfelseif structKeyExists(url,"error") AND url.error EQ 1>
                                <div class="alert alert-danger alert-dismissible show fade">
                                    <strong>Invalid User Name/Password!!!</strong> 
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
                                    </button>
                                </div>
                            </cfif>
                            <h1 class="auth-title">Log in.</h1>
                            <p class="auth-subtitle mb-5">
                                Log in with your data that you entered during registration.
                            </p>
                            <form class="form" id="loginForm" method="POST">
                                <div class="form-group position-relative has-icon-left mb-4">
                                    <input type="text" name="email" id="email" class="form-control form-control-xl" placeholder="Username" data-parsley-required="true" />
                                    <div class="form-control-icon">
                                        <i class="bi bi-person"></i>
                                    </div>
                                </div>
                                <div class="form-group position-relative has-icon-left mb-4">
                                    <input type="password" name="password" id="password" class="form-control form-control-xl" placeholder="Password" data-parsley-required="true" />
                                    <div class="form-control-icon">
                                        <i class="bi bi-shield-lock"></i>
                                    </div>
                                </div>
                                <!--- <div class="form-check form-check-lg d-flex align-items-end">
                                    <input class="form-check-input me-2" type="checkbox" value="" id="flexCheckDefault"/>
                                    <label class="form-check-label text-gray-600" for="flexCheckDefault">
                                        Keep me logged in
                                    </label>
                                </div> --->
                                <button class="btn btn-primary btn-block btn-lg shadow-lg mt-5">
                                    Log in
                                </button>
                            </form>
                            <div class="text-center mt-5 text-lg fs-4">
                                <p class="text-gray-600">
                                    Don't have an account?
                                    <a href="auth-register.cfm" class="font-bold">Sign up</a>.
                                </p>
                                <p>
                                    <a class="font-bold" href="auth-forgot-password.html">Forgot password?</a>.
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-7 d-none d-lg-block">
                        <div id="auth-right"></div>
                    </div>
                </div>
            </div>


            <!---  <!--- js --->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js" integrity="sha512-rstIgDs0xPgmG6RX1Aba4KV5cWJbAMcvRCVmglpam9SoHZiUCyQVDdH2LPlxoHtrv17XWblE/V/PP+Tr04hbtA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script> --->
            <script src="assets/extensions/jquery/jquery.min.js"></script>
            <script src="assets/extensions/parsleyjs/parsley.min.js"></script>
            <script src="assets/static/js/pages/parsley.js"></script>

            <!---  <script>
                $( document ).ready(function() {
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
            </script> --->
        </body>
        </html>
    </cfif>
</cfoutput>
