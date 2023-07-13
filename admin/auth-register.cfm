<cfoutput>
    <!DOCTYPE html>
    <html lang="en">
        <cfinclude template="common/login-head.cfm">
        <style>
            .invalidCs{
                border:1px solid red !important;
            }
        </style>
        <body>
            <div id="auth">
                <div class="row h-100">
                    <div class="col-lg-3">
                        <div id="auth-right"></div>
                    </div>
                    <div class="col-lg-6 col-12">
                        <div id="auth-left">
                            <h1 class="auth-title mt-0">Sign Up</h1>
                            <p class="auth-subtitle mb-5">
                            Input your data to register to our website.
                            </p>
                            <form class="form" id="register" method="POST" action="validate.cfm?formAction=signUp">
                                <div class="row">
                                    <div class="col-md-12">
                                        <lable class="fw-bold form-label" for="firstName">First Name</lable>
                                        <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                            <input type="text" class="form-control form-control-xl" id="firstName" name="firstName" placeholder="First Name"/>
                                            <div class="form-control-icon">
                                                <i class="bi bi-person"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <lable class="fw-bold form-label" for="lastName">Last Name</lable>
                                        <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                            <input type="text" class="form-control form-control-xl" id="lastName" name="lastName" placeholder="Last Name"/>
                                            <div class="form-control-icon">
                                                <i class="bi bi-person"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12"> 
                                        <lable class="fw-bold form-label" for="email">Email</lable>
                                        <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                            <input type="text" class="form-control form-control-xl" id="email" name="email" placeholder="Email"/>
                                            <div class="form-control-icon">
                                                <i class="bi bi-envelope"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12"> 
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
                                    <div class="col-md-12">
                                        <lable class="fw-bold form-label " for="dob">DOB</lable>
                                        <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <!--- <label class="input-group-text pb-3" for="dob">
                                                            <i class=" bi bi-calendar-date"></i>
                                                            <!--- DOB --->
                                                        </label> --->
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
                                    <div class="col-md-12">
                                        <lable class="fw-bold form-label" for="password">Password</lable>
                                        <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                            <input type="password" name="password" id="password" class="form-control form-control-xl" placeholder="Password" value=""/>
                                            <div class="form-control-icon">
                                                <i class="bi bi-shield-lock"></i>
                                            </div>
                                        </div>
                                        <div id="pswmeter" class="mt-3"></div>
                                        <div id="pswmeter-message" class="mt-3"></div>
                                    </div>
                                    <div class="col-md-12">
                                        <lable class="fw-bold form-label" for="confrimPassword">Confrim Password</lable>
                                        <div class="form-group position-relative has-icon-left mb-4 mt-2">
                                            <input type="password" name="confrimPassword" id="confrimPassword" class="form-control form-control-xl" placeholder="Confrim Password"/>
                                            <div class="form-control-icon">
                                                <i class="bi bi-shield-lock"></i>
                                            </div>
                                        </div>
                                        <div id="confrimpswmeter" class="mt-3"></div>
                                        <div id="confrim-pswmeter-message" class="mt-3"></div>    
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
                    <div class="col-lg-3 d-none d-lg-block">
                        <div id="auth-right"></div>
                    </div>
                </div>
            </div>

            <!--- JS --->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js" integrity="sha512-rstIgDs0xPgmG6RX1Aba4KV5cWJbAMcvRCVmglpam9SoHZiUCyQVDdH2LPlxoHtrv17XWblE/V/PP+Tr04hbtA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
            
            <script src="assets/static/js/components/dark.js"></script>
            <script src="assets/extensions/perfect-scrollbar/perfect-scrollbar.min.js"></script>
            
            <script src="assets/extensions/choices.js/public/assets/scripts/choices.js"></script>
            <script src="assets/static/js/pages/form-element-select.js"></script>
            <script src="assets/compiled/js/app.js"></script> 
            <!--- password meter --->
            <script async defer src="https://buttons.github.io/buttons.js"></script>
            <script src="/assets/js/pswmeter.min.js"></script>
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
                       /*  showMessage: false, */
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
                        colorScore1: '##aaa',
                        colorScore2: '##aaa',
                        colorScore3: '##aaa',
                        colorScore4: 'limegreen'
                    
                        if(pass.value.length > 0){
                            showMessage: true,
                        }
                    });

                    const myConfimPassMeter = passwordStrengthMeter({
                        containerElement: '##confrimpswmeter',
                        passwordInput: '##confrimPassword',
                        /* showMessage: false, */
                        messageContainer: '##confrim-pswmeter-message',
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
                        colorScore1: '##aaa',
                        colorScore2: '##aaa',
                        colorScore3: '##aaa',
                        colorScore4: 'limegreen'
                        /*  if (passwordInput.length != '') {
                            showMessage: true, 
                        } */
                        
                    });

                    /* const myConfrimPassMeter = passwordStrengthMeter({
                        containerElement: '##pswmeter',
                        passwordInput: '##confrimPassword',
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
                        colorScore1: '##aaa',
                        colorScore2: '##aaa',
                        colorScore3: '##aaa',
                        colorScore4: 'limegreen'
                    }); */
    
            </script>
        </body>
    </html>
</cfoutput>