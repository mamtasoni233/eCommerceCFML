<!--- <cffunction name="getCategoryResult" access="public" returntype="array">
    <cfargument name="returnArray" required="true" type="any"/>
    <cfargument name="parentId" required="true" default="0" type="any"/>

        <cfset qryGetCategory = "">
        <cfquery name="qryGetCategory">
            SELECT categoryName, PkCategoryId, parentCategoryId FROM Category 
            WHERE parentCategoryId =  <cfqueryparam value="#arguments.parentId#" cfsqltype="cf_sql_integer">
            AND isDeleted = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfif qryGetCategory.recordCount GT 0>
            <cfdump var="#qryGetCategory#">
            
            <cfloop query="qryGetCategory">
                <cfset res = StructNew()>
                <cfset res.catName = qryGetCategory.categoryName>
                <cfset res.parentCategoryId = qryGetCategory.parentCategoryId>
                <cfset res.PkCategoryId = qryGetCategory.PkCategoryId>
                
                <cfif arguments.parentId EQ 0>
                    <!--- <cfset res.catName  = arguments.parentName & ' -> ' & qryGetCategory.categoryName> --->
                    <cfset res.catName  = qryGetCategory.categoryName>
                    <cfset getCategoryResult( arguments.returnArray, res.PkCategoryId)>
                </cfif>       
                <!--- <cfset getCategoryResult( arguments.returnArray, res.PkCategoryId)> --->
                <cfset arrayAppend(arguments.returnArray, res)>         
            </cfloop>
            <!--- <cfset getCategoryResult( arguments.returnArray, res.PkCategoryId)> --->
        </cfif>
        <cfreturn arguments.returnArray>
</cffunction> --->
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
            <!--- <cfif qryGetCategory.parentCategoryId EQ 0>
                <cfset res['catName'] = qryGetCategory.categoryName>
            </cfif> --->
            <cfset res['child'] = getCategoryResult(res.PkCategoryId)>
            <cfset arrayAppend(arguments.returnArray, res)> 
        </cfloop>
    </cfif>
    <cfreturn arguments.returnArray>
</cffunction>
<cfset categoryList = getCategoryResult()>
<!--- <cfdump var='#categoryList#'>
<!--- <cfset firstLevelArray = []> ---> 
<cfloop array="#categoryList#" index="idx">
    <cfif idx['parentCategoryId'] EQ 0>
        <!---  <cfset arrayAppend(firstLevelArray, idx)> --->
        <cfdump var="#idx.catName#">
    </cfif>
    <cfloop array="#idx.child#" index="child">
        <cfdump var="#child#">
        <cfloop array="#child.child#" index="subChild">
            <cfdump var="#subChild#">
        </cfloop>
    </cfloop>
    <!--- <cfdump var="#firstLevelArray#"> --->
</cfloop>
<!--- <cfdump var='#firstLevelArray#'> --->

<cfabort> --->

<!--- <cfquery name="qryAllGetCategory">
    SELECT categoryName, PkCategoryId, parentCategoryId, categoryImage FROM Category 
    WHERE isDeleted = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
</cfquery>

<cfquery name="qryAllParentCategory" dbtype="query">
    SELECT categoryName, PkCategoryId, parentCategoryId, categoryImage  FROM qryAllGetCategory 
    WHERE parentCategoryId = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
</cfquery> --->

<!--- <cfdump var="#qryAllGetCategory#" >
<cfdump var="#qryAllParentCategory#"> --->

<!--- <cfloop query="qryAllParentCategory">
    <cfquery name="qryGetChildCategory" dbtype="query">
        SELECT categoryName, PkCategoryId, parentCategoryId, categoryImage FROM qryAllGetCategory
        WHERE parentCategoryId = <cfqueryparam value="#qryAllParentCategory.PkCategoryId#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfdump var="#qryGetChildCategory#">
</cfloop>
<cfabort> --->
<cfoutput>
    <cfset imagePath = "http://127.0.0.1:50847/assets/categoryImage/">
    <nav
        class="navbar navbar-expand-lg navbar-light bg-white border-bottom mx-0 p-0 flex-column border-0 position-absolute w-100 z-index-30 bg-transparent navbar-dark navbar-transparent bg-white-hover transition-all"
    >
        <div class="w-100 pb-lg-0 pt-lg-0 pt-4 pb-3">
            <div class="container-fluid d-flex justify-content-between align-items-center flex-wrap">
                <!-- Logo-->
                <a class="navbar-brand fw-bold fs-3 m-0 p-0 flex-shrink-0" href="./index.html">
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
                <div
                    class="ms-5 flex-shrink-0 collapse navbar-collapse navbar-collapse-light w-auto flex-grow-1"
                    id="navbarNavDropdown"
                >
                    <!-- Mobile Nav Toggler-->
                    <button
                        class="btn btn-link px-2 text-decoration-none navbar-toggler border-0 position-absolute top-0 end-0 mt-3 me-2"
                        data-bs-toggle="collapse"
                        data-bs-target="##navbarNavDropdown"
                        aria-controls="navbarNavDropdown"
                        aria-expanded="false"
                        aria-label="Toggle navigation"
                    >
                        <i class="ri-close-circle-line ri-2x"></i>
                    </button>
                    <!-- / Mobile Nav Toggler-->

                    <!---  <ul class="navbar-nav py-lg-2 mx-auto">
                        <li class="nav-item me-lg-4 dropdown position-static">
                            <a
                                class="nav-link fw-bolder dropdown-toggle py-lg-4"
                                href="##"
                                role="button"
                                data-bs-toggle="dropdown"
                                aria-haspopup="true"
                                aria-expanded="false"
                            >
                                Menswear
                            </a>
                            <!-- Menswear dropdown menu-->
                            <div class="dropdown-menu dropdown-megamenu">
                                <div class="container">
                                    <div class="row g-0">
                                        <!-- Dropdown Menu Links Section-->
                                        <div class="col-12 col-lg-7">
                                            <div class="row py-lg-5">
                                                <!-- menu row-->
                                                <div class="col col-lg-6 mb-5 mb-sm-0">
                                                    <h6 class="dropdown-heading">
                                                        Waterproof Layers
                                                    </h6>
                                                    <ul class="list-unstyled">
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Waterproof Jackets</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Insulated Jackets</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Down Jackets</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Softshell Jackets</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Casual Jackets</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Windproof Jackets</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Breathable Jackets</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Cleaning & Proofing</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a
                                                                class="dropdown-item dropdown-link-all"
                                                                href="./category.html"
                                                            >View All</a>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <!-- /menu row-->

                                                <!-- menu row-->
                                                <div class="col col-lg-6">
                                                    <h6 class="dropdown-heading">Brands</h6>
                                                    <ul class="list-unstyled">
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Lifestyle & Casual</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Walking Shoes</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Running Shoes</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Military Boots</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Fabric Walking Boots</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Leather Walking Boots</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Wellies</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Winter Footwear</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a
                                                                class="dropdown-item dropdown-link-all"
                                                                href="./category.html"
                                                            >View All</a>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <!-- /menu row-->
                                            </div>
                                        </div>
                                        <!-- /Dropdown Menu Links Section-->

                                        <!-- Dropdown Menu Images Section-->
                                        <div class="d-none d-lg-block col-lg-5">
                                            <div
                                                class="vw-50 h-100 bg-img-cover bg-pos-center-center position-absolute"
                                                style=" background-image: url('../assets/images/banners/banner-2.jpg'); "
                                            ></div>
                                        </div>
                                        <!-- Dropdown Menu Images Section-->
                                    </div>
                                </div>
                            </div>
                            <!-- / Menswear dropdown menu-->
                        </li>
                        <li class="nav-item me-lg-4 dropdown position-static">
                            <a
                                class="nav-link fw-bolder dropdown-toggle py-lg-4"
                                href="##"
                                role="button"
                                data-bs-toggle="dropdown"
                                aria-haspopup="true"
                                aria-expanded="false"
                            >
                                Womenswear
                            </a>
                            <!-- Womenswear dropdown menu-->
                            <div class="dropdown-menu dropdown-megamenu">
                                <div class="container">
                                    <div class="row g-0">
                                        <!-- Dropdown Menu Links Section-->
                                        <div class="col-12 col-lg-7">
                                            <div class="row py-lg-5">
                                                <!-- menu row-->
                                                <div class="col col-lg-6 mb-5 mb-sm-0">
                                                    <h6 class="dropdown-heading">
                                                        Waterproof Layers
                                                    </h6>
                                                    <ul class="list-unstyled">
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Waterproof Jackets</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Insulated Jackets</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Down Jackets</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Softshell Jackets</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Casual Jackets</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Windproof Jackets</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Breathable Jackets</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Cleaning & Proofing</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a
                                                                class="dropdown-item dropdown-link-all"
                                                                href="./category.html"
                                                            >View All</a>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <!-- /menu row-->

                                                <!-- menu row-->
                                                <div class="col col-lg-6">
                                                    <h6 class="dropdown-heading">Brands</h6>
                                                    <ul class="list-unstyled">
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Lifestyle & Casual</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Walking Shoes</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Running Shoes</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Military Boots</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Fabric Walking Boots</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Leather Walking Boots</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Wellies</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a class="dropdown-item" href="./category.html">Winter Footwear</a>
                                                        </li>
                                                        <li class="dropdown-list-item">
                                                            <a
                                                                class="dropdown-item dropdown-link-all"
                                                                href="./category.html"
                                                            >View All</a>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <!-- /menu row-->
                                            </div>
                                        </div>
                                        <!-- /Dropdown Menu Links Section-->

                                        <!-- Dropdown Menu Images Section-->
                                        <div class="d-none d-lg-block col-lg-5">
                                            <div
                                                class="vw-50 h-100 bg-img-cover bg-pos-center-center position-absolute"
                                                style=" background-image: url('../assets/images/banners/banner-4.jpg');"
                                            ></div>
                                        </div>
                                        <!-- Dropdown Menu Images Section-->
                                    </div>
                                </div>
                            </div>
                            <!-- / Womenswear dropdown menu-->
                        </li>
                        <li class="nav-item me-lg-4">
                            <a class="nav-link fw-bolder py-lg-4" href="##"> Kidswear </a>
                        </li>
                        <li class="nav-item me-lg-4">
                            <a class="nav-link fw-bolder py-lg-4" href="##">
                                Sale Items
                            </a>
                        </li>
                        <li class="nav-item dropdown me-lg-4">
                            <a
                                class="nav-link fw-bolder dropdown-toggle py-lg-4"
                                href="##"
                                role="button"
                                data-bs-toggle="dropdown"
                                aria-haspopup="true"
                                aria-expanded="false"
                            >
                                Demo Pages
                            </a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a class="dropdown-item" href="./index.html">Homepage</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="./category.html">Category</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="./product.html">Product</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="./cart.html">Cart</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="./checkout.html">Checkout</a>
                                </li>
                            </ul>
                        </li>
                    </ul> --->
                    <ul class="navbar-nav py-lg-2 mx-auto">
                        <cfloop array="#categoryList#" index="idx">

                            <!---  <cfquery name="qryGetChildCategory" dbtype="query">
                                SELECT categoryName, PkCategoryId, parentCategoryId, categoryImage FROM qryAllGetCategory
                                WHERE parentCategoryId = <cfqueryparam value="#qryAllParentCategory.PkCategoryId#" cfsqltype="cf_sql_integer">
                            </cfquery> --->
                            
                            <li class="nav-item me-lg-4 dropdown position-static">
                                <a
                                    class="nav-link fw-bolder dropdown-toggle py-lg-4"
                                    href="index.cfm?pg=category.cfm"
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
                                <div class="dropdown-menu dropdown-megamenu">
                                    <div class="container">
                                        <div class="row g-0">
                                            <!-- Dropdown Menu Links Section-->
                                            <div class="col-12 col-lg-7">
                                                <div class="row py-lg-5">
                                                    <!-- menu row-->
                                                        <div class="col col-lg-6 mb-5 mb-sm-0">
                                                            <h6 class="dropdown-heading">
                                                                <!---  #qryGetChildCategory.categoryName# --->
                                                            </h6>
                                                            <ul class="list-unstyled">
                                                                <cfloop array="#idx.child#" index="child">
                                                                    <li class="dropdown-list-item">
                                                                        <a class="dropdown-item" href="index.cfm?pg=category">
                                                                            #child.catName#
                                                                        </a>
                                                                        <ul class="list-unstyled ms-5">
                                                                            <cfloop array="#child.child#" index="subChild">
                                                                                <li class="dropdown-list-item">
                                                                                    <a class="dropdown-item" href="index.cfm?pg=category">
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
                                            <div class="d-none d-lg-block col-lg-5">
                                                <div
                                                    class="vw-50 h-100 position-absolute"
                                                    style=" background: url('#imagePath##idx.categoryImage#');background-repeat: no-repeat;background-position: center center;background-size: cover;">
                                                </div>
                                                <!---  <div
                                                    class="vw-50 h-100"
                                                    style=" background-repeat: no-repeat;background:url('#imagePath##qryGetChildCategory.categoryImage#');background-position: center center; background-size: cover;">
                                                </div> --->
                                                <!--- <img src="../../assets/categoryImage/#qryAllParentCategory.categoryImage#"> --->
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
                            class="btn btn-link px-2 text-decoration-none navbar-toggler border-0 d-flex align-items-center"
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
                        <button class="btn btn-link px-2 text-decoration-none d-flex align-items-center" data-pr-search >
                            <i class="ri-search-2-line ri-lg align-middle"></i>
                        </button>
                    </li>
                    <!-- /Navbar Search-->

                    <!-- Navbar Wishlist-->
                    <li class="ms-1 d-none d-lg-inline-block">
                        <a class="btn btn-link px-2 py-0 text-decoration-none d-flex align-items-center" href="##">
                            <i class="ri-heart-line ri-lg align-middle"></i>
                        </a>
                    </li>
                    <!-- /Navbar Wishlist-->

                    <!-- Navbar Login-->
                    <li class="ms-1 d-none d-lg-inline-block">
                        <a class="btn btn-link px-2 text-decoration-none d-flex align-items-center" href="../validate.cfm?formAction=logOut">
                            <i class="ri-user-line ri-lg align-middle"></i>
                        </a>
                    </li>
                    <!-- /Navbar Login-->

                    <!-- Navbar Cart-->
                    <li class="ms-1 d-inline-block position-relative">
                        <button
                            class="btn btn-link px-2 text-decoration-none d-flex align-items-center disable-child-pointer"
                            data-bs-toggle="offcanvas"
                            data-bs-target="##offcanvasCart"
                            aria-controls="offcanvasCart"
                        >
                            <i class="ri-shopping-cart-2-line ri-lg align-middle position-relative z-index-10"></i>
                            <span
                                class="fs-xs fw-bolder f-w-5 f-h-5 bg-orange rounded-lg d-block lh-1 pt-1 position-absolute top-0 end-0 z-index-20 mt-2 text-white"
                            >2</span>
                        </button>
                    </li>
                    <!-- /Navbar Cart-->
                </ul>
                <!-- Navbar Icons-->
            </div>
        </div>
    </nav>
</cfoutput>
