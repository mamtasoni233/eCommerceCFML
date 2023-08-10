<cfoutput>

    <cfparam name="url.email" default="" />
    <cfparam name="token" default="" />
    <cfparam name="password" default="" />
    <!--- <cfparam name="saved" default="" /> --->
    <cfset bcrypt = application.bcrypt>
    <cfset gensalt = bcrypt.gensalt()>


    <cfif structKeyExists(url, 'token') AND len(url.token) GT 0>  
        <cfquery name="getToken">
            SELECT email, PkUserId, token FROM users  
            WHERE token = <cfqueryparam value="#url.token#" cfsqltype="cf_sql_varchar"> 
        </cfquery>
        <cfdump var="#getToken#">
        <!---   <cfdump var="#checkToken#"> --->
        <cfif getToken.recordCount EQ 1>
            <cfif structKeyExists(form, 'password') AND len(form.password) GT 0> 
                <cfset hashPassword = bcrypt.hashpw(form.password,gensalt)>
                <cfquery result="updatePassword">
                    UPDATE users SET  
                    password = <cfqueryparam value="#hashPassword#" cfsqltype="cf_sql_varchar"> 
                    , token = <cfqueryparam null="true"> 
                    WHERE email= <cfqueryparam value="#trim(getToken.email)#" cfsqltype="cf_sql_varchar"> 
                </cfquery>
                <!---  <cfdump var="#updatePassword#">
                <cfabort> --->
                <cflocation url="login.cfm?saved=4" addtoken="false">
            </cfif>
        <cfelse>
            <cflocation url="http://127.0.0.1:50001/auth-reset-password.cfm?tokenExpire=1" addtoken="false">
        </cfif>
    </cfif>
    <!DOCTYPE html>
    <html lang="en">
        <cfinclude template="common/login-head.cfm">
        <body>
            <!---   <cfdump var="mamta"><cfabort> --->
            <div id="auth">
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
            </div>

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