<cffunction name="getCategoryResult" access="public" returntype="array">
    <cfargument name="parentId" default="0" required="false" type="numeric"/>
    <cfargument name="returnArray" required="false" type="array" default="#arrayNew(1)#"/>

    <cfset var qryGetCategory = "">
    <cfquery name="qryGetCategory">
        SELECT categoryName, PkCategoryId, parentCategoryId, categoryImage FROM Category 
        WHERE parentCategoryId = <cfqueryparam value="#arguments.parentId#" cfsqltype="cf_sql_integer">
        AND isDeleted = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfif qryGetCategory.recordCount GT 0>
        <cfloop query="qryGetCategory">
            <cfset var res = StructNew()>
            <cfset res['child'] = []>
            <cfset res['catName'] = qryGetCategory.categoryName>
            <cfset res['PkCategoryId'] = qryGetCategory.PkCategoryId>
            <cfset res['parentCategoryId'] = qryGetCategory.parentCategoryId>
            <cfset res['categoryImage'] = qryGetCategory.categoryImage>
            <cfset res['child'] = getCategoryResult(res.PkCategoryId)>
            <cfset arrayAppend(arguments.returnArray, res)> 
        </cfloop>
    </cfif>
    <cfreturn arguments.returnArray>
</cffunction>
<cfset categoryList = getCategoryResult()>
<cfoutput>
    <style>
        .fixed-top.scrolled {
            background-color: ##fff !important;
            transition: background-color 200ms linear;
        }
        .fixed-top.scrolled .nav-link{
            color:##000000;
        }
    </style>
    <cfset imagePath = "http://127.0.0.1:50847/assets/categoryImage/">
    <nav
        class="navbar navbar-expand-lg navbar-light bg-white border-bottom mx-0 p-0 flex-column border-0 <cfif pg EQ 'dashboard'>fixed-top w-100 z-index-30 bg-transparent navbar-dark navbar-transparent bg-white-hover transition-all</cfif> "
    >
        <div class="w-100 pb-lg-0 pt-lg-0 pt-4 pb-3">
            <div class="container-fluid d-flex justify-content-between align-items-center flex-wrap">
                <!-- Logo-->
                <a class="nav-link fw-bolder navbar-brand fw-bold fs-3 m-0 p-0 flex-shrink-0" href="index.cfm?pg=dashboard">
                    <!-- Start of Logo-->
                    <div class="d-flex align-items-center">
                        <div class="f-w-6 d-flex align-items-center me-2 lh-1">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 194 194">
                                <path
                                    fill="currentColor"
                                    class="svg-logo-white"
                                    d="M47.45,60l1.36,27.58,53.41-51.66,50.87,50,3.84-26L194,100.65V31.94A31.94,31.94,0,0,0,162.06,0H31.94A31.94,31.94,0,0,0,0,31.94v82.57Z"
                                />
                                <pathbiperson
                                    fill="currentColor"
                                    class="svg-logo-dark"
                                    d="M178.8,113.19l1,34.41L116.3,85.92l-14.12,15.9L88.07,85.92,24.58,147.53l.93-34.41L0,134.86v27.2A31.94,31.94,0,0,0,31.94,194H162.06A31.94,31.94,0,0,0,194,162.06V125.83Z"
                                />
                            </svg>
                        </div>
                        <span class="fs-5">Alpine</span>
                    </div>
                    <!-- / Logo-->
                </a>
                <!-- / Logo-->
                <!-- Main Navigation-->
                <div class="ms-5 flex-shrink-0 collapse navbar-collapse navbar-collapse-light w-auto flex-grow-1" id="navbarNavDropdown">
                    <!-- Mobile Nav Toggler-->
                    <button
                        class="nav-link fw-bolder btn btn-link px-2 text-decoration-none navbar-toggler border-0 position-absolute top-0 end-0 mt-3 me-2"
                        data-bs-toggle="collapse"
                        data-bs-target="##navbarNavDropdown"
                        aria-controls="navbarNavDropdown"
                        aria-expanded="false"
                        aria-label="Toggle navigation"
                    >
                        <i class="ri-close-circle-line ri-2x"></i>
                    </button>
                    <!-- / Mobile Nav Toggler-->
                    <ul class="navbar-nav py-lg-2 mx-auto">
                        <cfloop array="#categoryList#" index="idx">
                            <li class="nav-item me-lg-4 dropdown position-static">
                                <a
                                    class="nav-link fw-bolder dropdown-toggle py-lg-4"
                                    role="button"
                                    data-bs-toggle="dropdown"
                                    aria-haspopup="true"
                                    aria-expanded="false"
                                >
                                <cfif idx['parentCategoryId'] EQ 0>
                                    #idx.catName#
                                </cfif>
                                </a>
                                <!-- parent category dropdown menu-->
                                <div class="dropdown-menu dropdown-megamenu vh-100">
                                    <div class="container">
                                        <div class="row g-0">
                                            <!-- Dropdown Menu Links Section-->
                                            <div class="col-12 col-lg-6">
                                                <div class="row py-lg-5">
                                                    <!-- menu row-->
                                                        <div class="col col-lg-6 mb-5 mb-sm-0">
                                                            <ul class="list-unstyled">
                                                                <cfloop array="#idx.child#" index="child">
                                                                    <li class="dropdown-list-item">
                                                                        <h6 class="fw-bolder mb-2 mt-2 fw-bold">
                                                                            #child.catName#
                                                                        </h6>
                                                                        <ul class="list-unstyled">
                                                                            <cfloop array="#child.child#" index="subChild">
                                                                                <li class="dropdown-list-item">
                                                                                    <a class="dropdown-item" href="index.cfm?pg=category&id=#subChild.PkCategoryId#">
                                                                                        #subChild.catName#
                                                                                    </a>
                                                                                </li>
                                                                            </cfloop>
                                                                        </ul>
                                                                    </li>
                                                                </cfloop>
                                                            </ul>
                                                        </div>
                                                    <!-- /menu row-->
                                                    
                                                </div>
                                            </div>
                                            <!-- /Dropdown Menu Links Section-->

                                            <!-- Dropdown Menu Images Section-->
                                            <div class="d-none d-lg-block col-lg-6">
                                                <div
                                                    class="vw-50 h-100 position-absolute"
                                                    style=" background: url('#imagePath##idx.categoryImage#');background-repeat: no-repeat;background-position: center center;background-size: cover;">
                                                </div>
                                            </div>
                                            <!-- Dropdown Menu Images Section-->
                                        </div>
                                    </div>
                                </div>
                                <!-- / parent category dropdown menu-->
                            </li>
                        </cfloop>
                    </ul>
                </div>
                <!-- / Main Navigation-->

                <!-- Navbar Icons-->
                <ul class="list-unstyled mb-0 d-flex align-items-center">
                    <!-- Navbar Toggle Icon-->
                    <li class="d-inline-block d-lg-none">
                        <button
                            class="nav-link fw-bolder btn btn-link px-2 text-decoration-none navbar-toggler border-0 d-flex align-items-center"
                            data-bs-toggle="collapse"
                            data-bs-target="##navbarNavDropdown"
                            aria-controls="navbarNavDropdown"
                            aria-expanded="false"
                            aria-label="Toggle navigation"
                        >
                            <i class="ri-menu-line ri-lg align-middle"></i>
                        </button>
                    </li>
                    <!-- /Navbar Toggle Icon-->

                    <!-- Navbar Search-->
                    <li class="ms-1 d-inline-block">
                        <button class="nav-link fw-bolder btn btn-link px-2 text-decoration-none d-flex align-items-center" data-pr-search >
                            <i class="ri-search-2-line ri-lg align-middle"></i>
                        </button>
                    </li>
                    <!-- /Navbar Search-->

                    <!-- Navbar Wishlist-->
                    <li class="ms-1 d-none d-lg-inline-block">
                        <a class="nav-link fw-bolder btn btn-link px-2 py-0 text-decoration-none d-flex align-items-center" href="index.cfm?pg=account&s=wishList">
                            <i class="ri-heart-line ri-lg align-middle"></i>
                        </a>
                    </li>
                    <!-- /Navbar Wishlist-->

                    <!-- Navbar Login-->
                    <!---  <li class="ms-1 d-none d-lg-inline-block">
                        <a class="btn btn-link px-2 text-decoration-none d-flex align-items-center" href="../validate.cfm?formAction=logOut">
                            <i class="ri-user-line ri-lg align-middle"></i>
                        </a>
                    </li> --->
                    <li class="nav-item dropdown">
                            <a class="nav-link fw-bolder btn btn-link px-2 text-decoration-none dropdown-toggle py-lg-4" href="##" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="ri-user-line ri-lg align-middle"></i> 
                            </a>
                            <ul class="dropdown-menu position-absolute" style="left: -96px">
                                <li class="mb-2">
                                    <h4 class="dropdown-header fw-bolder m-0 p-0">
                                        Hello, #session.customer.firstName# #session.customer.lastName#!!
                                    </h4>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="index.cfm?pg=dashboard">Homepage</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="index.cfm?pg=account&s=editAccount">My Profile</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="index.cfm?pg=orders">My Orders</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="index.cfm?pg=cart">Cart</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="index.cfm?pg=checkOut">Checkout</a>
                                </li>
                                <li>
                                    <hr class="dropdown-divider"/>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="../validate.cfm?formAction=logOut">
                                        <i class="icon-mid bi bi-box-arrow-left me-2"></i>
                                        Logout
                                    </a>
                                </li>
                            </ul>
                        </li>
                    <!-- /Navbar Login-->
                    <!-- Navbar Cart-->
                    <li class="ms-1 d-inline-block position-relative">
                        <button
                            class="nav-link fw-bolder btn btn-link px-2 text-decoration-none d-flex align-items-center disable-child-pointer"
                            type="button"
                            data-bs-toggle="offcanvas"
                            data-bs-target="##offcanvasCart"
                            aria-controls="offcanvasCart"
                            id="offcanvasCartBtn"
                        >
                            <i class="ri-shopping-cart-2-line ri-lg align-middle position-relative z-index-10"></i>
                            <!--- <cfif StructKeyExists(session, "cart") AND session.cart.len() GT 0> 
                                <cfset display = 'd-none'>
                            <cfelse>
                                <cfset display = ''>
                                <!--- <span
                                    class="fs-xs fw-bolder f-w-5 f-h-5 bg-orange rounded-lg d-block lh-1 pt-1 position-absolute top-0 end-0 z-index-20 text-white cartCounter"
                                >
                                    <!---   #session.cart.cartCountValue# --->
                                </span> --->
                            </cfif> --->
                            <!--- <cfif StructKeyExists(session, "cart") AND session.cart.len() GT 0>  --->
                                <span class="fs-xs d-none fw-bolder f-w-5 f-h-5 bg-orange rounded-lg d-block lh-1 pt-1 position-absolute top-0 end-0 z-index-20 text-white cartCounter" id="cartCounter">
                                    <!---   #session.cart.cartCountValue# --->
                                </span>
                            <!--- </cfif> --->
                        </button>
                    </li>
                    <!-- /Navbar Cart-->
                </ul>
                <!-- Navbar Icons-->
            </div>
        </div>
    </nav>
</cfoutput>
<script>
    $(function () {
        $(document).scroll(function () {
            var $nav = $(".fixed-top");
            $nav.toggleClass('scrolled', $(this).scrollTop() > $nav.height());
        });
    });
</script>
