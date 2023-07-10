<cfoutput>
        <cfinclude template="common/login-head.cfm">
        <body>
            <cfparam name="firstName" default="" />
            <cfparam name="lastName" default="" />
            <cfparam name="email" default="" />
            <cfparam name="gender" default="" />
            <cfparam name="dob" default="" />
            <cfparam name="password" default="" />
            <cfparam name="msg" default=""/>
            <cfset bcrypt = application.bcrypt>
            <cfset gensalt = bcrypt.gensalt()>
            <cfif structKeyExists(form, "firstName") AND form.firstName GT 0>
                <cfset year = "#form.year#">
                <cfset month = "#form.month#">
                <cfset day = "#form.day#">
                <cfset dateDob = "#year##month##day#">             
                <cfset dob = dateFormat(CreateDate(year, month, day), 'yyyy-mm-dd')>
                <cfset hashPassword = bcrypt.hashpw(form.password,gensalt)>
                <!--- <cfquery>
                    SELECT email, PkUserId FROM users WHERE email=<cfqueryparam value = "#form.email#" cfsqltype = "cf_sql_varchar">
                </cfquery> --->
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
                <cfset msg = "1">
                <cflocation url="login.cfm?msg=#msg#" addtoken="false">
            </cfif>
            <!--- JS --->
            <script src="assets/static/js/initTheme.js"></script>
            <div id="auth">
                <div class="row h-100">
                    <div class="col-lg-2">
                        <div id="auth-right"></div>
                    </div>
                    <div class="col-lg-8 col-12">
                        <div id="auth-left">
                            <div class="auth-logo">
                                <a href="">
                                    <img src="assets/compiled/svg/logo.svg" alt="Logo"/>
                                </a>
                            </div>
                            <h1 class="auth-title">Sign Up</h1>
                            <p class="auth-subtitle mb-5">
                            Input your data to register to our website.
                            </p>
                            <form class="form" action="" id="register" method="POST" >
                                <div class="row">
                                    <div class="col-md-6">
                                        <lable class="fw-bold form-label" for="firstName">First Name</lable>
                                        <div class="form-group position-relative has-icon-left mb-4">
                                            <input type="text" class="form-control form-control-xl" id="firstName" name="firstName" placeholder="First Name"/>
                                            <div class="form-control-icon">
                                                <i class="bi bi-person"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <lable class="fw-bold form-label" for="lastName">Last Name</lable>
                                        <div class="form-group position-relative has-icon-left mb-4">
                                            <input type="text" class="form-control form-control-xl" id="lastName" name="lastName" placeholder="Last Name"/>
                                            <div class="form-control-icon">
                                                <i class="bi bi-person"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6"> 
                                        <lable class="fw-bold form-label" for="email">Email</lable>
                                        <div class="form-group position-relative has-icon-left mb-4">
                                            <input type="text" class="form-control form-control-xl" id="email" name="email" placeholder="Email"/>
                                            <div class="form-control-icon">
                                                <i class="bi bi-envelope"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6"> 
                                        <lable class="fw-bold form-label" for="gender">Gender</lable>
                                        <div class="form-group position-relative has-icon-left mb-4">
                                            <div class="row">
                                                <div class="col-md-6">
                                                        <div class="form-check ms-5">
                                                            <input class="form-check-input" type="radio" name="gender" value="1">
                                                            <label class="form-check-label" for="male" id="male"> Male</label>
                                                        </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-check ms-5">
                                                        <input class="form-check-input" type="radio" name="gender" value="0">
                                                        <label class="form-check-label" for="female" id="female"> Female </label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <lable class="fw-bold form-label" for="dob">DOB</lable>
                                        <div class="form-group position-relative has-icon-left mb-4">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <!--- <label class="input-group-text pb-3" for="dob">
                                                            <i class=" bi bi-calendar-date"></i>
                                                            <!--- DOB --->
                                                        </label> --->
                                                        <select name="year" class="choices form-select" id="year">
                                                            <option selected class="opacity-100">Year</option>
                                                            <cfloop from="1995" to="2013" index="idx">
                                                                <option value="#idx#">#idx#</option>
                                                            </cfloop>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <select name="month" class="choices form-select" id="month">
                                                            <option selected class="opacity-100">Month</option>
                                                            <cfloop from="1" to="12" index="i">
                                                                <option value="#i#">#i#</option>
                                                            </cfloop>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <select name="day" class="choices form-select" id="day">
                                                            <option selected class="opacity-100">Day</option>
                                                            <cfloop from="1" to="31" index="j">
                                                                <option value="#j#">#j#</option>
                                                            </cfloop>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group position-relative has-icon-left mb-4">
                                            <input type="password" name="password" id="password" class="form-control form-control-xl" placeholder="Password"/>
                                            <div class="form-control-icon">
                                                <i class="bi bi-shield-lock"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group position-relative has-icon-left mb-4">
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
                    <div class="col-lg-2 d-none d-lg-block">
                        <div id="auth-right"></div>
                    </div>
                </div>
            </div>

            <!--- JS --->
            <!--- <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js" integrity="sha512-rstIgDs0xPgmG6RX1Aba4KV5cWJbAMcvRCVmglpam9SoHZiUCyQVDdH2LPlxoHtrv17XWblE/V/PP+Tr04hbtA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script> --->
            <script src="assets/static/js/components/dark.js"></script>
            <script src="assets/extensions/perfect-scrollbar/perfect-scrollbar.min.js"></script>
            
            <script src="assets/extensions/choices.js/public/assets/scripts/choices.js"></script>
            <script src="assets/static/js/pages/form-element-select.js"></script>
            <script src="assets/compiled/js/app.js"></script> 
            <script src="assets/extensions/jquery/jquery.min.js"></script>
            <script src="assets/extensions/parsleyjs/parsley.min.js"></script>
            <script src="assets/static/js/pages/parsley.js"></script>
            <script>
                $( document ).ready(function() {
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
                            password: {
                                required: true,
                                minlength:8
                            },
                            confrimPassword: {
                                required:true,
                                equalTo: "##password"
                            }
                        },
                        errorPlacement: function (error, element) {
                            error.insertAfter($(element).parent('div')); 
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
                           /*  gender: {
                                required: "Please enter your gender",                    
                            }, */
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