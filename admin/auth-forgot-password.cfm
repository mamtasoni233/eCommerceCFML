<cfoutput>
    <!DOCTYPE html>
    <html lang="en">
        <cfinclude template="common/login-head.cfm">
        <body>
            <div id="auth">
                <div class="row h-100">
                    <div class="col-lg-5 col-12">
                        <div id="auth-left">
                            <div class="auth-logo">
                                <a href="index.cfm">
                                    <img src="./assets/compiled/svg/logo.svg" alt="Logo"/>
                                </a>
                            </div>
                            <h1 class="auth-title">Forgot Password</h1>
                            <p class="auth-subtitle mb-5">
                                Input your email and we will send you reset password link.
                            </p>
                            <form action="validate.cfm?formAction=forgotPass">
                                <div class="form-group position-relative has-icon-left mb-4">
                                    <input type="email" name="email" class="form-control form-control-xl" placeholder="Email"/>
                                    <div class="form-control-icon">
                                        <i class="bi bi-envelope"></i>
                                    </div>
                                </div>
                                <button class="btn btn-primary btn-block btn-lg shadow-lg mt-5">
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
        </body>
    </html>
</cfoutput>