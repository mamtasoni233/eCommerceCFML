<cfoutput>

    <cfparam name="email" default="" />
    <cfparam name="token" default="" />
    <cfparam name="saved" default="" />
    <cfset bcrypt = application.bcrypt>
    <cfset gensalt = bcrypt.gensalt()>

    <cfif structKeyExists(form, 'email') AND len(form.email) GT 0>  
        <cfquery name="getMail">
            SELECT PkUserId, firstName, lastName, email, dob, password, gender, token FROM users 
            WHERE email = <cfqueryparam value="#trim(form.email)#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfif getMail.recordCount EQ 1>
            <cfset token = createUUID()>
            <cfset email = getMail.email>
            <cfset userId = getMail.PkUserId>
            <cfquery result="addToken">
                UPDATE users SET 
                token = <cfqueryparam value="#token#" cfsqltype="cf_sql_varchar">
                WHERE email = <cfqueryparam value="#trim(email)#" cfsqltype="cf_sql_varchar"> 
                AND PkUserId = <cfqueryparam value="#userId#" cfsqltype="cf_sql_integer">
            </cfquery>
                from="mamta.s@lucidsolutions.in" 
                subject="Hello from CFML" 
                type="html">
                <cfmailpart type="text/html">
                    <div>
                        Hii! <b>#getMail.firstName# #getMail.lastName#</b> <br>
                        If you have lost your password and wish to reset it,  <br>
                        use the link below get started....  <br>
                    </div>
                    <button style="background: blue; padding: 10px; margin-top: 10px">
                        <a style="text-decoration: none; color: white;" href="http://127.0.0.1:50001/auth-reset-password.cfm?token=#token#">Reset Your Password</a>
                    </button>
                </cfmailpart>
            </cfmail>
        </cfif>
        <cfset saved = 3>
    </cfif>
    <!DOCTYPE html>
    <html lang="en">
        <cfinclude template="common/login-head.cfm">
        <body>
            <div id="auth">
                <div class="row h-100">
                    <div class="col-lg-5 col-12">
                        <div id="auth-left">
                            <cfif url.saved EQ 3>
                                <div class="alert alert alert-light-success alert-dismissible show fade">
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
            </div>

            <!--- js --->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js" integrity="sha512-rstIgDs0xPgmG6RX1Aba4KV5cWJbAMcvRCVmglpam9SoHZiUCyQVDdH2LPlxoHtrv17XWblE/V/PP+Tr04hbtA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
            
            <script src="assets/static/js/components/dark.js"></script>
            <script src="assets/extensions/perfect-scrollbar/perfect-scrollbar.min.js"></script>

            <script src="assets/compiled/js/app.js"></script>
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