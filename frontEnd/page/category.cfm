<cfparam name="id" default="#url.id#" />
<cfparam name="productTagValue" default="" />
<cfparam name="PkCategoryId" default="" />
<cfparam name="PkTagId" default="" />
<cfparam name="PkProductId" default="" />
<cfparam name="isDeleted" default="0" />
<cfparam name="startRow" default="">
<cfparam name="pageNum" default="1">
<cfparam name="maxRows" default="9">
<cfset startRow = ( pageNum-1 ) * maxRows>
<!--- <cfquery name="getProduct">
    SELECT C.PkCategoryId, C.categoryName, C.parentCategoryId, P.PkProductId, P.productQty, P.productName, P.productPrice
    FROM product P
    LEFT JOIN category C ON P.FkCategoryId = C.PkCategoryId
    WHERE  1 = 1
    AND P.isDeleted = <cfqueryparam value="#isDeleted#" cfsqltype = "cf_sql_bit">
    AND P.FkCategoryId = <cfqueryparam value="#url.id#" cfsqltype = "cf_sql_integer">
</cfquery> --->
<cfquery name="getProduct">
    SELECT P.PkProductId, P.productQty, P.productName, P.productPrice, PT.PkTagId, PT.tagName 
    FROM product P
    LEFT JOIN product_tags PT ON PT.PkTagId = P.product_tags 
    WHERE P.isDeleted = <cfqueryparam value="#isDeleted#" cfsqltype = "cf_sql_bit">
    AND P.FkCategoryId = <cfqueryparam value="#url.id#" cfsqltype = "cf_sql_integer">
    <cfif structKeyExists(url, 'tags') AND url.tags GT 0>
        AND (
            P.product_tags LIKE (<cfqueryparam value="%#url.tags#%">)
            <cfloop list="#tags#" item="item">
                OR P.product_tags LIKE (<cfqueryparam value="%#item#%">)
            </cfloop>
        )
    </cfif>
</cfquery>
<!--- paingnation --->
<cfset totalPages = ceiling( getProduct.recordCount/maxRows )>
<!--- <cfquery name="getProductPaging">
    SELECT C.PkCategoryId, C.categoryName, C.parentCategoryId, P.PkProductId, P.productQty, P.productName, P.productPrice
    FROM product P
    LEFT JOIN category C ON P.FkCategoryId = C.PkCategoryId
    WHERE  1 = 1
    AND P.isDeleted = <cfqueryparam value="#isDeleted#" cfsqltype = "cf_sql_bit">
    AND P.FkCategoryId = <cfqueryparam value="#url.id#" cfsqltype = "cf_sql_integer">
    LIMIT #startRow#, #maxRows#
</cfquery> --->
<cfquery name="getProductPaging">
    SELECT P.PkProductId, P.productQty, P.productName, P.productPrice, PT.PkTagId, PT.tagName 
    FROM product P
    LEFT JOIN product_tags PT ON PT.PkTagId = P.product_tags 
    WHERE  P.isDeleted = <cfqueryparam value="#isDeleted#" cfsqltype = "cf_sql_bit">
    AND P.FkCategoryId = <cfqueryparam value="#url.id#" cfsqltype = "cf_sql_integer">
    <cfif structKeyExists(url, 'tags') AND url.tags GT 0>
        AND (
            P.product_tags LIKE (<cfqueryparam value="%#url.tags#%">)
            <cfloop list="#tags#" item="item">
                OR P.product_tags LIKE (<cfqueryparam value="%#item#%">)
            </cfloop>
        )
    </cfif>
    LIMIT #startRow#, #maxRows#
</cfquery>
<cffunction name="getCategoryResult" access="public" returntype="array">
    <cfargument name="parentId" default="0" required="false" type="numeric"/>
    <cfargument name="categoryId" default="0" required="false" type="numeric"/>
    <cfargument name="returnArray" required="false" type="array" default="#arrayNew(1)#"/>
    <cfset var qryGetCategory = "">
    <cfquery name="qryGetCategory">
        SELECT categoryName, PkCategoryId, parentCategoryId, categoryImage 
        FROM Category
        WHERE 1 = 1
        <cfif arguments.categoryId GT 0>
            AND PkCategoryId = <cfqueryparam value="#arguments.categoryId#" cfsqltype="cf_sql_integer">
        <cfelse>
            AND parentCategoryId = <cfqueryparam value="#arguments.parentId#" cfsqltype="cf_sql_integer">
        </cfif>
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
            <cfquery name="countProduct">
                SELECT COUNT(P.PkProductId) AS productCount
                FROM product P
                WHERE P.isDeleted = <cfqueryparam value="0" cfsqltype = "cf_sql_integer">
                AND P.FkCategoryId = <cfqueryparam value="#res['PkCategoryId']#" cfsqltype = "cf_sql_integer">
            </cfquery>
            <cfset res['productCount'] = countProduct.productCount>
            <cfset arrayAppend(arguments.returnArray, res)> 
        </cfloop>
    </cfif>
    <cfreturn arguments.returnArray>
</cffunction>
<cfquery name="qryGetSecLevelCat">
    SELECT C.parentCategoryId, C.categoryName, B.parentCategoryId AS seclevelCat
    FROM category C, category B
    WHERE C.PkCategoryId = <cfqueryparam value="#url.id#" cfsqltype = "cf_sql_integer">
    AND B.PkCategoryId = C.parentCategoryId
</cfquery>
<cfset categoryList = getCategoryResult(qryGetSecLevelCat.seclevelCat, qryGetSecLevelCat.parentCategoryId)>
<!--- <cfset parentId = getProduct.parentCategoryId> --->
<cfquery name="getProductTag">
    SELECT PT.PkTagId, PT.FkCategoryId, PT.tagName, PT.isActive, PT.isDeleted
    FROM product_tags PT
    WHERE PT.isDeleted = <cfqueryparam value="0" cfsqltype = "cf_sql_bit">
    AND PT.isActive = <cfqueryparam value="1" cfsqltype = "cf_sql_bit">
    AND PT.FkCategoryId = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">
</cfquery>
<cfoutput>
    <style>
        img {
            width: 200px;
            height: 300px;
            object-fit: contain;
        }
        ##overlay {
            position: relative;
            width: 100%;
            height: 100%;
            left: 0;
            right: 0;
            top: 0;
            bottom: 0;
            z-index: 9999;
        }
        .cv-spinner {
            position: absolute;
            width: inherit;
            height: inherit;
        }
        .spinner {
            width: 40px;
            height: 40px;
            border: 4px ##ddd solid;
            border-top: 4px ##2e93e6 solid;
            border-radius: 50%;
            animation: sp-anime 0.8s infinite linear;
        }
        @keyframes sp-anime {
            100% { 
                transform: rotate(360deg); 
            }
        }
    </style>
    <cfset imagePath = "http://127.0.0.1:50847/assets/productImage/">
    <!-- Category Top Banner -->
    <div class="py-6 bg-img-cover bg-dark bg-overlay-gradient-dark position-relative overflow-hidden mb-4 bg-pos-center-center"
        style="background-image: url('../assets/images/banners/banner-1.jpg');">
        <div class="container position-relative z-index-20" data-aos="fade-right" data-aos-delay="300">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item breadcrumb-light"><a href="index.cfm?pg=dashboard">Home</a></li>
                    <li class="breadcrumb-item breadcrumb-light">
                        <cfloop array="#categoryList#" index="idx">
                            <cfloop array="#idx.child#" index="child">
                                <cfif child.PkCategoryId EQ qryGetSecLevelCat.parentCategoryId>
                                    #child.catName#
                                </cfif>
                            </cfloop>
                        </cfloop>    
                    </li>
                    <li class="breadcrumb-item active breadcrumb-light" aria-current="page">#qryGetSecLevelCat.categoryName#</li>
                </ol>
            </nav>                
            <h1 class="fw-bold display-6 mb-4 text-white">Latest Arrivals (121)</h1>
            <div class="col-12 col-md-6">
                <p class="lead text-white mb-0">
                    Move, stretch, jump and hike in our latest waterproof arrivals. We've got you covered for your
                    hike or climbing sessions, from Gortex jackets to lightweight waterproof pants. Discover our
                    latest range of outdoor clothing.
                </p>
            </div>
        </div>
    </div>
    <!-- Category Top Banner -->
    <div class="container">
        <div class="row">
            <!-- Category Aside/Sidebar -->
            <div class="d-none d-lg-flex col-lg-3">
                <div class="pe-4">
                    <!-- Category Aside -->
                    <aside>
                        <!-- Filter Category -->
                        <div class="mb-4">
                            <h2 class="mb-4 fs-6 mt-2 fw-bolder">
                                <cfloop array="#categoryList#" index="idx">
                                    #idx.catName#
                                </cfloop>
                            </h2>
                            <nav>
                                <ul class="list-unstyled list-default-text">
                                    <cfloop array="#categoryList#" index="idx">
                                        <cfloop array="#idx.child#" index="child">
                                            <li class="mb-2">
                                                <a class="text-decoration-none text-body text-secondary-hover transition-all d-flex justify-content-between align-items-center"
                                                href="index.cfm?pg=category&id=#child.PkCategoryId#&pageNum=1">
                                                    <span><i class="ri-arrow-right-s-line align-bottom ms-n1"></i> 
                                                        #child.catName#
                                                    </span> 
                                                    <span class="text-muted ms-4">(#child.productCount#)</span>
                                                </a>
                                            </li>
                                        </cfloop>
                                    </cfloop>              
                                </ul>
                            </nav>
                        </div>
                        <!-- / Filter Category-->
                        <!-- Price Filter -->
                        <!--- <div class="py-4 widget-filter widget-filter-price border-top">
                            <a class="small text-body text-decoration-none text-secondary-hover transition-all transition-all fs-6 fw-bolder d-block collapse-icon-chevron"
                                data-bs-toggle="collapse" href="##filter-price" role="button" aria-expanded="true"
                                aria-controls="filter-price">
                                Price
                            </a>
                            <div id="filter-price" class="collapse show">
                                <div class="filter-price mt-6"></div>
                                <div class="d-flex justify-content-between align-items-center mt-7">
                                    <div class="input-group mb-0 me-2 border">
                                        <span class="input-group-text bg-transparent fs-7 p-2 text-muted border-0">$</span>
                                        <input type="number" min="00" max="1000" step="1" class="filter-min form-control-sm border flex-grow-1 text-muted border-0">
                                    </div>   
                                    <div class="input-group mb-0 ms-2 border">
                                        <span class="input-group-text bg-transparent fs-7 p-2 text-muted border-0">$</span>
                                        <input type="number" min="00" max="1000" step="1" class="filter-max form-control-sm flex-grow-1 text-muted border-0">
                                    </div>                
                                </div>        
                            </div>
                        </div> --->
                        <!-- / Price Filter -->   
                        <!-- Brands Filter -->
                        <!--- <div class="py-4 widget-filter border-top">
                            <a class="small text-body text-decoration-none text-secondary-hover transition-all transition-all fs-6 fw-bolder d-block collapse-icon-chevron"
                                data-bs-toggle="collapse" href="##filter-brands" role="button" aria-expanded="true"
                                aria-controls="filter-brands">
                                Brands
                            </a>
                            <div id="filter-brands" class="collapse show">
                                <div class="input-group my-3 py-1">
                                    <input type="text" class="form-control py-2 filter-search rounded" placeholder="Search" aria-label="Search">
                                    <span class="input-group-text bg-transparent px-2 position-absolute top-7 end-0 border-0 z-index-20"><i class="ri-search-2-line text-muted"></i></span>
                                </div>
                                <div class="simplebar-wrapper">
                                    <div class="filter-options" data-pixr-simplebar>
                                        <div class="form-group form-check mb-0">
                                            <input type="checkbox" class="form-check-input" id="filter-brand-0">
                                            <label class="form-check-label fw-normal text-body flex-grow-1 d-flex justify-content-between" for="filter-brand-0">
                                                Adidas <span class="text-muted">(21)</span>
                                            </label>
                                        </div>                            
                                        <div class="form-group form-check mb-0">
                                            <input type="checkbox" class="form-check-input" id="filter-brand-1">
                                            <label class="form-check-label fw-normal text-body flex-grow-1 d-flex justify-content-between" for="filter-brand-1">
                                                Asics <span class="text-muted">(13)</span>
                                            </label>
                                        </div>                            
                                        <div class="form-group form-check mb-0">
                                            <input type="checkbox" class="form-check-input" id="filter-brand-2">
                                            <label class="form-check-label fw-normal text-body flex-grow-1 d-flex justify-content-between" for="filter-brand-2">
                                                Canterbury <span class="text-muted">(18)</span>
                                            </label>
                                        </div>                            
                                        <div class="form-group form-check mb-0">
                                            <input type="checkbox" class="form-check-input" id="filter-brand-3">
                                            <label class="form-check-label fw-normal text-body flex-grow-1 d-flex justify-content-between" for="filter-brand-3">
                                                Converse <span class="text-muted">(25)</span>
                                            </label>
                                        </div>                            
                                        <div class="form-group form-check mb-0">
                                            <input type="checkbox" class="form-check-input" id="filter-brand-4">
                                            <label class="form-check-label fw-normal text-body flex-grow-1 d-flex justify-content-between" for="filter-brand-4">
                                                Donnay <span class="text-muted">(11)</span>
                                            </label>
                                        </div>                            
                                        <div class="form-group form-check mb-0">
                                            <input type="checkbox" class="form-check-input" id="filter-brand-5">
                                            <label class="form-check-label fw-normal text-body flex-grow-1 d-flex justify-content-between" for="filter-brand-5">
                                                Nike <span class="text-muted">(19)</span>
                                            </label>
                                        </div>                            
                                        <div class="form-group form-check mb-0">
                                            <input type="checkbox" class="form-check-input" id="filter-brand-6">
                                            <label class="form-check-label fw-normal text-body flex-grow-1 d-flex justify-content-between" for="filter-brand-6">Mi
                                                llet <span class="text-muted">(24)</span>
                                            </label>
                                        </div>                            
                                        <div class="form-group form-check mb-0">
                                            <input type="checkbox" class="form-check-input" id="filter-brand-7">
                                            <label class="form-check-label fw-normal text-body flex-grow-1 d-flex justify-content-between" for="filter-brand-7">
                                                Puma <span class="text-muted">(11)</span>
                                            </label>
                                        </div>                            
                                        <div class="form-group form-check mb-0">
                                            <input type="checkbox" class="form-check-input" id="filter-brand-8">
                                            <label class="form-check-label fw-normal text-body flex-grow-1 d-flex justify-content-between" for="filter-brand-8">Re
                                                ebok <span class="text-muted">(19)</span>
                                            </label>
                                        </div>                            
                                        <div class="form-group form-check mb-0">
                                            <input type="checkbox" class="form-check-input" id="filter-brand-9">
                                            <label class="form-check-label fw-normal text-body flex-grow-1 d-flex justify-content-between" for="filter-brand-9">
                                                Under Armour <span class="text-muted">(24)</span>
                                            </label>
                                        </div>                    
                                    </div>
                                </div>
                            </div>
                        </div> --->
                        <!-- / Brands Filter -->
                        <!-- Type Filter -->
                        <div class="py-4 widget-filter border-top">
                            <a class="small text-body text-decoration-none text-secondary-hover transition-all transition-all fs-6 fw-bolder d-block collapse-icon-chevron"
                                data-bs-toggle="collapse" href="##filter-type" role="button" aria-expanded="true"
                                aria-controls="filter-type">
                                Product Type
                            </a>
                            <div id="filter-type" class="collapse show">
                                <div class="input-group my-3 py-1">
                                    <input type="text" class="form-control py-2 filter-search rounded" placeholder="Search" aria-label="Search">
                                    <span class="input-group-text bg-transparent px-2 position-absolute top-7 end-0 border-0 z-index-20"><i class="ri-search-2-line text-muted"></i></span>
                                </div>
                                <div class="filter-options">
                                    <cfloop query="#getProductTag#">
                                        <div class="form-group form-check mb-0">
                                            <input type="checkbox" class="form-check-input productTag" name="productTag" value="#getProductTag.PkTagId#" data-type="#getProductTag.tagName#" data-catId ="#url.id#" id="filter-type-#getProductTag.PkTagId#" <cfif structKeyExists(url, 'tags') AND listFindNoCase(url.tags, getProductTag.PkTagId)>checked</cfif>>
                                            <label class="form-check-label fw-normal text-body flex-grow-1 d-flex justify-content-between" for="filter-type-#getProductTag.PkTagId#"> #getProductTag.tagName#</label>
                                        </div>
                                    </cfloop>               
                                </div>
                            </div>
                        </div>
                        <!-- / Type Filter -->
                        <!-- Sizes Filter -->
                        <!--- <div class="py-4 widget-filter border-top">
                            <a class="small text-body text-decoration-none text-secondary-hover transition-all transition-all fs-6 fw-bolder d-block collapse-icon-chevron"
                                data-bs-toggle="collapse" href="##filter-sizes" role="button" aria-expanded="true"
                                aria-controls="filter-sizes">
                                Sizes
                            </a>
                            <div id="filter-sizes" class="collapse show">
                                <div class="filter-options mt-3">
                                    <div class="form-group d-inline-block mr-2 mb-2 form-check-bg form-check-custom">
                                        <input type="checkbox" class="form-check-bg-input" id="filter-sizes-0">
                                        <label class="form-check-label fw-normal" for="filter-sizes-0">6.5</label>
                                    </div>                        
                                    <div class="form-group d-inline-block mr-2 mb-2 form-check-bg form-check-custom">
                                        <input type="checkbox" class="form-check-bg-input" id="filter-sizes-1">
                                        <label class="form-check-label fw-normal" for="filter-sizes-1">7</label>
                                    </div>                        
                                    <div class="form-group d-inline-block mr-2 mb-2 form-check-bg form-check-custom">
                                        <input type="checkbox" class="form-check-bg-input" id="filter-sizes-2">
                                        <label class="form-check-label fw-normal" for="filter-sizes-2">7.5</label>
                                    </div>                        
                                    <div class="form-group d-inline-block mr-2 mb-2 form-check-bg form-check-custom">
                                        <input type="checkbox" class="form-check-bg-input" id="filter-sizes-3">
                                        <label class="form-check-label fw-normal" for="filter-sizes-3">8</label>
                                    </div>                        
                                    <div class="form-group d-inline-block mr-2 mb-2 form-check-bg form-check-custom">
                                        <input type="checkbox" class="form-check-bg-input" id="filter-sizes-4">
                                        <label class="form-check-label fw-normal" for="filter-sizes-4">8.5</label>
                                    </div>                        
                                    <div class="form-group d-inline-block mr-2 mb-2 form-check-bg form-check-custom">
                                        <input type="checkbox" class="form-check-bg-input" id="filter-sizes-5">
                                        <label class="form-check-label fw-normal" for="filter-sizes-5">9</label>
                                    </div>                        
                                    <div class="form-group d-inline-block mr-2 mb-2 form-check-bg form-check-custom">
                                        <input type="checkbox" class="form-check-bg-input" id="filter-sizes-6">
                                        <label class="form-check-label fw-normal" for="filter-sizes-6">9.5</label>
                                    </div>                        
                                    <div class="form-group d-inline-block mr-2 mb-2 form-check-bg form-check-custom">
                                        <input type="checkbox" class="form-check-bg-input" id="filter-sizes-7">
                                        <label class="form-check-label fw-normal" for="filter-sizes-7">10</label>
                                    </div>                        
                                    <div class="form-group d-inline-block mr-2 mb-2 form-check-bg form-check-custom">
                                        <input type="checkbox" class="form-check-bg-input" id="filter-sizes-8">
                                        <label class="form-check-label fw-normal" for="filter-sizes-8">10.5</label>
                                    </div>                        
                                    <div class="form-group d-inline-block mr-2 mb-2 form-check-bg form-check-custom">
                                        <input type="checkbox" class="form-check-bg-input" id="filter-sizes-9">
                                        <label class="form-check-label fw-normal" for="filter-sizes-9">11</label>
                                    </div>                        
                                    <div class="form-group d-inline-block mr-2 mb-2 form-check-bg form-check-custom">
                                        <input type="checkbox" class="form-check-bg-input" id="filter-sizes-10">
                                        <label class="form-check-label fw-normal" for="filter-sizes-10">11.5</label>
                                    </div>                
                                </div>
                            </div>
                        </div> --->
                        <!-- / Sizes Filter -->
                        <!-- Colour Filter -->
                        <!--- <div class="py-4 widget-filter border-top">
                            <a class="small text-body text-decoration-none text-secondary-hover transition-all transition-all fs-6 fw-bolder d-block collapse-icon-chevron"
                                data-bs-toggle="collapse" href="##filter-colour" role="button" aria-expanded="true"
                                aria-controls="filter-colour">
                                Colour
                            </a>
                            <div id="filter-colour" class="collapse show">
                                <div class="filter-options mt-3">
                                        <div class="form-group d-inline-block mr-1 mb-1 form-check-solid-bg-checkmark form-check-custom form-check-primary">
                                            <input type="checkbox" class="form-check-color-input" id="filter-colours-0">
                                            <label class="form-check-label" for="filter-colours-0"></label>
                                        </div>                        
                                        <div class="form-group d-inline-block mr-1 mb-1 form-check-solid-bg-checkmark form-check-custom form-check-success">
                                            <input type="checkbox" class="form-check-color-input" id="filter-colours-1">
                                            <label class="form-check-label" for="filter-colours-1"></label>
                                        </div>                        
                                        <div class="form-group d-inline-block mr-1 mb-1 form-check-solid-bg-checkmark form-check-custom form-check-danger">
                                            <input type="checkbox" class="form-check-color-input" id="filter-colours-2">
                                            <label class="form-check-label" for="filter-colours-2"></label>
                                        </div>                        
                                        <div class="form-group d-inline-block mr-1 mb-1 form-check-solid-bg-checkmark form-check-custom form-check-info">
                                            <input type="checkbox" class="form-check-color-input" id="filter-colours-3">
                                            <label class="form-check-label" for="filter-colours-3"></label>
                                        </div>                        
                                        <div class="form-group d-inline-block mr-1 mb-1 form-check-solid-bg-checkmark form-check-custom form-check-warning">
                                            <input type="checkbox" class="form-check-color-input" id="filter-colours-4">
                                            <label class="form-check-label" for="filter-colours-4"></label>
                                        </div>                        
                                        <div class="form-group d-inline-block mr-1 mb-1 form-check-solid-bg-checkmark form-check-custom form-check-dark">
                                            <input type="checkbox" class="form-check-color-input" id="filter-colours-5">
                                            <label class="form-check-label" for="filter-colours-5"></label>
                                        </div>                        
                                        <div class="form-group d-inline-block mr-1 mb-1 form-check-solid-bg-checkmark form-check-custom form-check-secondary">
                                            <input type="checkbox" class="form-check-color-input" id="filter-colours-6">
                                            <label class="form-check-label" for="filter-colours-6"></label>
                                        </div>                
                                    </div>
                            </div>
                        </div> --->
                        <!-- / Colour Filter -->
                    </aside>
                    <!-- / Category Aside-->                    
                </div>
            </div>
            <!-- / Category Aside/Sidebar -->
            <!-- Category Products-->
            <div class="col-12 col-lg-9 transition-fade">
                <div id="overlay" class="d-flex align-items-center justify-content-center d-none">
					<div class="cv-spinner d-flex align-items-center justify-content-center mx-auto">
                        <span class="spinner"></span>
                    </div>
				</div>
                <div id="productContainer" class="">
                    <!-- Top Toolbar-->
                    <div class="mb-4 d-md-flex justify-content-between align-items-center" >
                        <div class="d-flex justify-content-start align-items-center flex-grow-1 mb-4 mb-md-0 d-none" id="productTypeContainer">
                            <small class="d-inline-block fw-bolder">Filtered by:</small>
                            <ul class="list-unstyled d-inline-block mb-0 ms-2">
                                <cfloop query="#getProductTag#">
                                    <cfif structKeyExists(url, 'tags') AND url.tags GT 0>
                                        <li class="bg-light py-1 fw-bolder px-2 cursor-pointer d-inline-block me-1 small productType" id="productType" >
                                            #getProductTag.tagName#
                                            <i class="ri-close-circle-line align-bottom ms-1"></i>
                                        </li>
                                        </cfif>
                                    </cfloop>
                                    <!--- Type: Slip On --->
                            </ul>
                            <span class="fw-bolder text-muted-hover text-decoration-underline ms-2 cursor-pointer small">
                                Clear All
                            </span>
                        </div>
                        <div class="d-flex align-items-center flex-column flex-md-row">
                            <!-- Filter Trigger-->
                            <button class="btn bg-light p-3 d-flex d-lg-none align-items-center fs-xs fw-bold text-uppercase w-100 mb-2 mb-md-0 w-md-auto" type="button" data-bs-toggle="offcanvas" data-bs-target="##offcanvasFilters" aria-controls="offcanvasFilters">
                                <i class="ri-equalizer-line me-2"></i> Filters
                            </button>
                            <!-- / Filter Trigger-->
                            <div class="dropdown ms-md-2 lh-1 p-3 bg-light w-100 mb-2 mb-md-0 w-md-auto">
                                <p class="fs-xs fw-bold text-uppercase text-muted-hover p-0 m-0" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    Sort By <i class="ri-arrow-drop-down-line ri-lg align-bottom"></i>
                                </p>
                                <ul class="dropdown-menu">
                                    <li>
                                        <a class="dropdown-item fs-xs fw-bold text-uppercase text-muted-hover mb-2" href="##">
                                            Price: Hi Low
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item fs-xs fw-bold text-uppercase text-muted-hover mb-2" href="##">
                                            Price: Low Hi
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item fs-xs fw-bold text-uppercase text-muted-hover mb-2"href="##">
                                            Name
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>                    
                    <!-- / Top Toolbar-->
                    <!-- Products-->
                    <div class="row g-4 mb-5">
                        <cfif getProductPaging.recordCount GT 0>
                            <cfloop query="getProductPaging">
                                <cfquery name="getProductImage">
                                    SELECT image, isDefault
                                    FROM product_image
                                    WHERE FkProductId = <cfqueryparam value="#getProductPaging.PkProductId#" cfsqltype = "cf_sql_integer">
                                </cfquery>
                                <div class="col-12 col-sm-6 col-md-4 col-lg-4">
                                    <!-- Card Product-->
                                    <div class="card position-relative h-100 card-listing hover-trigger">
                                        <div class="card-header d-flex align-self-center">
                                            <cfloop query="getProductImage">
                                                <cfif getProductImage.isDefault EQ 1>
                                                    <picture class="position-relative overflow-hidden d-block bg-light">
                                                        <img class="vh-25 img-fluid position-relative z-index-10" title="" src="#imagePath##getProductImage.image#" alt="">
                                                    </picture>
                                                </cfif>
                                                <picture class="position-absolute z-index-20 start-0 top-0 hover-show bg-light">
                                                    <img class="vh-25 img-fluid" title="" src="#imagePath##getProductImage.image#" alt="">
                                                </picture>
                                            </cfloop> 
                                            <div class="card-actions">
                                                <span class="small text-uppercase tracking-wide fw-bolder text-center d-block">Quick Add</span>
                                                <div class="d-flex justify-content-center align-items-center flex-wrap mt-3">
                                                    <button class="btn btn-outline-dark btn-sm mx-2">S</button>
                                                    <button class="btn btn-outline-dark btn-sm mx-2">M</button>
                                                    <button class="btn btn-outline-dark btn-sm mx-2">L</button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-body px-0 text-center">
                                            <div class="d-flex justify-content-center align-items-center mx-auto mb-1">
                                                <!-- Review Stars Small-->
                                                <div class="rating position-relative d-table">
                                                    <div class="position-absolute stars" style="width: 90%">
                                                        <i class="ri-star-fill text-dark mr-1"></i>
                                                        <i class="ri-star-fill text-dark mr-1"></i>
                                                        <i class="ri-star-fill text-dark mr-1"></i>
                                                        <i class="ri-star-fill text-dark mr-1"></i>
                                                        <i class="ri-star-fill text-dark mr-1"></i>
                                                    </div>
                                                    <div class="stars">
                                                        <i class="ri-star-fill mr-1 text-muted opacity-25"></i>
                                                        <i class="ri-star-fill mr-1 text-muted opacity-25"></i>
                                                        <i class="ri-star-fill mr-1 text-muted opacity-25"></i>
                                                        <i class="ri-star-fill mr-1 text-muted opacity-25"></i>
                                                        <i class="ri-star-fill mr-1 text-muted opacity-25"></i>
                                                    </div>
                                                </div> 
                                                <span class="small fw-bolder ms-2 text-muted"> 4.7 (456)</span>
                                            </div>
                                            <a class="mb-0 mx-2 mx-md-4 fs-p link-cover text-decoration-none d-block text-center" href="">
                                                #getProductPaging.productName#
                                            </a>
                                            <p class="fw-bolder m-0 mt-2"><i class="fa fa-rupee"></i> #getProductPaging.productPrice#</p>
                                        </div>
                                    </div>
                                    <!--/ Card Product-->
                                </div>
                            </cfloop>
                        <cfelse>
                            <div class="card position-relative h-100 card-listing hover-trigger">
                                <div class="card-header">
                                    <div class="card-body px-0 text-center">
                                        No Record Found
                                    </div>
                                </div>
                            </div>
                        </cfif>
                    </div>
                    <!-- / Products-->
                    <!-- Pagination-->
                    <nav class="border-top mt-5 pt-5 d-flex justify-content-between align-items-center" aria-label="Category Pagination">
                        <ul class="pagination">
                            <li class="page-item <cfif pageNum EQ 1>disabled</cfif>">
                                <a class="page-link prev"  href="index.cfm?pg=category&id=#url.id#&pageNum=#pageNum-1#<cfif structKeyExists(url, 'tags')>&tags=#url.tags#</cfif>" data-id="#pageNum#">
                                    <i class="ri-arrow-left-line align-bottom"></i>
                                    Prev
                                </a>
                            </li>
                        </ul>
                        <ul class="pagination">
                            <cfloop from="1" to="#totalPages#" index="i">
                                <li class="page-item <cfif pageNum EQ i>active</cfif> mx-1">
                                    <a class="page-link" href="index.cfm?pg=category&id=#url.id#&pageNum=#i#<cfif structKeyExists(url, 'tags')>&tags=#url.tags#</cfif>">
                                        #i#
                                    </a>
                                </li>
                            </cfloop>
                        </ul>
                        <ul class="pagination">
                            <li class="page-item <cfif pageNum EQ totalPages>disabled</cfif>">
                                <a class="page-link next" href="index.cfm?pg=category&id=#url.id#&pageNum=#pageNum+1#<cfif structKeyExists(url, 'tags')>&tags=#url.tags#</cfif>">Next 
                                    <i class="ri-arrow-right-line align-bottom"></i>
                                </a>
                            </li>
                        </ul>
                    </nav>                    
                    <!-- / Pagination-->
                    <!-- Related Categories-->
                    <!--- <div class="border-top mt-5 pt-5">
                        <p class="lead fw-bolder">Related Categories</p>
                        <div class="d-flex flex-wrap justify-content-start align-items-center">
                            <a class="btn btn-sm btn-outline-dark rounded-pill me-2 mb-2 mb-md-0 text-white-hover"
                                href="##">Hiking
                                Shoes</a>
                            <a class="btn btn-sm btn-outline-dark rounded-pill me-2 mb-2 mb-md-0 text-white-hover"
                                href="##">Waterproof Trousers</a>
                            <a class="btn btn-sm btn-outline-dark rounded-pill me-2 mb-2 mb-md-0 text-white-hover"
                                href="##">Hiking
                                Shirts</a>
                            <a class="btn btn-sm btn-outline-dark rounded-pill me-2 mb-2 mb-md-0 text-white-hover"
                                href="##">Jackets</a>
                            <a class="btn btn-sm btn-outline-dark rounded-pill me-2 mb-2 mb-md-0 text-white-hover"
                                href="##">Gilets</a>
                            <a class="btn btn-sm btn-outline-dark rounded-pill me-2 mb-2 mb-md-0 text-white-hover"
                                href="##">Hiking
                                Socks</a>
                            <a class="btn btn-sm btn-outline-dark rounded-pill me-2 mb-2 mb-md-0 text-white-hover"
                                href="##">Rugsacks</a>
                        </div>
                    </div> --->
                    <!-- Related Categories-->
                </div>
            </div>
            
            <!-- / Category Products-->
        </div>
    </div>
    <script>
        var #toScript('#pageNum#','pageNum')#;
        var #toScript('#pg#','pg')#;
        var #toScript('#id#','id')#;
        $(document).ready( function () { 
            hideLoader();
            /* $(document).ajaxSend(function() {
                showLoader();
            }); */
            var value = "";
            //let productContainer = $('##productContainer').html();
            //var currentUrl = location.href;
            var url = "";
            //ajaxFilter(value,id);
            $('.productTag').on('change', function(){
                showLoader();
                var catId = $(this).attr('data-catId');
                var type = $(this).attr('data-type');
                value = $(':checked').map(function(){ return $(this).val(); }).get().join(); 
                console.log("type", type)
                if (value.length === 0) {
                    setTimeout(function(){
                        showLoader();
                    },500);
                    $('##productTypeContainer').addClass('d-none');
                    //$(".productType").text('');
                    //$('##productContainer').html(productContainer);
                    ajaxFilter(value,catId);
                    let defaultURL = "index.cfm?pg=" + pg + "&id=" + id + "&pageNum=" + pageNum;
                    window.history.pushState(null, null, defaultURL);
                    setTimeout(function(){
                        hideLoader();
                    },500);
                } else {
                    
                    $('##productTypeContainer').removeClass('d-none');
                   /*  url = currentUrl +'&tags='+ value; */
                    // function ajaxFilter() {
                        // $.ajax({  
                        //     url: '../ajaxFilterProduct.cfm?productTagValue='+ value, 
                        //     data: {catId:catId, value:value},
                        //     type: 'GET',
                        //     cache: false,
                        //     success: function(result) {
                        //         if (result.success) {
                        //             // url = "index.cfm?pg=" + pg + "&id=" + id + "&pageNum=" + pageNum +'&tags=' + value;
                        //             url = "index.cfm?pg=" + pg + "&id=" + id + "&pageNum=" + pageNum +'&tags=' + value;
                        //             $('##productContainer').html(result.html);
                        //             window.history.pushState(null, null,url);
                        //         }
                        //     },
                        //     beforeSend: function(){
                        //         setTimeout(function(){
                        //             showLoader();
                        //         },500);
                        //     }, 
                        //     complete: function(){
                        //         setTimeout(function(){
                        //             hideLoader();
                        //         },500);
                        //     }  
                        // });  
                    // }
                    ajaxFilter(value,catId);
                }
                //ajaxFilter(value,catId);
            });
        });
        function ajaxFilter(value,id) {
            console.log(arguments);
            $.ajax({  
                url: '../ajaxFilterProduct.cfm?productTagValue='+ value, 
                data: {catId:id, value:value},
                type: 'GET',
                // cache: false,
                success: function(result) {
                    if (result.success) {
                        // url = "currentUrl +'&tags=' + value;
                        $('##productContainer').html(result.html);
                        url = "index.cfm?pg=" + pg + "&id=" + id + "&pageNum=" + pageNum +'&tags=' + value;
                        window.history.pushState(null, null,url);
                    } /* else{
                        url = "index.cfm?pg=" + pg + "&id=" + id + "&pageNum=" + pageNum +'&tags=' + value;
                        $('##productContainer').html(result.html);
                        window.history.pushState(null, null,url);
                    } */
                },
                beforeSend: function(){
                    setTimeout(function(){
                        showLoader();
                    },500);
                }, 
                complete: function(){
                    setTimeout(function(){
                        hideLoader();
                    },500);
                }  
            });  
        }
        function showLoader() {
            $("##overlay").removeClass("d-none");
        }
        function hideLoader() {
            $("##overlay").addClass("d-none");
        }
    </script> 
</cfoutput>
