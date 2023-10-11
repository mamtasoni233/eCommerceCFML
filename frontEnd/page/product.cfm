<cfparam name="id" default="#url.id#" />
<cfparam name="PkProductId" default="" />
<cfparam name="productName" default="" />
<cfparam name="productPrice" default="" />
<cfparam name="productQty" default="" />
<cfparam name="isDeleted" default="0" />
<cfset customerId = session.customer.isLoggedIn>
<cfquery name="getProduct">
    SELECT P.PkProductId, P.FkCategoryId, P.productQty, P.productName, P.productPrice, P.productDescription
    FROM product P
    WHERE  P.isDeleted = <cfqueryparam value="#isDeleted#" cfsqltype = "cf_sql_bit">
    AND P.PkProductId = <cfqueryparam value="#url.id#" cfsqltype = "cf_sql_integer">
</cfquery>
<cfset productQty = getProduct.productQty>
<cfset productPrice = getProduct.productPrice>
<!--- category recursive function --->
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
    WHERE C.PkCategoryId = <cfqueryparam value="#getProduct.FkCategoryId#" cfsqltype = "cf_sql_integer">
    AND B.PkCategoryId = C.parentCategoryId
</cfquery>
<cfset categoryList = getCategoryResult(qryGetSecLevelCat.seclevelCat, qryGetSecLevelCat.parentCategoryId)>
<!--- category recursive function --->
<!--- Related Product query --->
<cfquery name="getRelatedProduct">
    SELECT P.PkProductId, P.FkCategoryId, P.productQty, P.productName, P.productPrice, P.productDescription
    FROM product P
    WHERE P.isDeleted = <cfqueryparam value="#isDeleted#" cfsqltype = "cf_sql_bit">
    AND P.FkCategoryId = <cfqueryparam value="#getProduct.FkCategoryId#" cfsqltype = "cf_sql_integer">
    AND P.PkProductId != <cfqueryparam value="#url.id#" cfsqltype = "cf_sql_integer">
</cfquery>
<!--- / Related Product query --->
<cfoutput>
    <cfset imagePath = "http://127.0.0.1:50847/assets/productImage/">
    <style>
        img{
            object-fit: contain;
        }
        
        .quantity input {
            -webkit-appearance: none;
            border: none;
            text-align: center;
            width: 32px;
            font-size: 16px;
            color: ##0a0a0a;
            font-weight: 900;
        }
        .minus-btn img {
            margin-bottom: 3px;
        }
        .plus-btn img {
            margin-top: 2px;
        }
    </style>
    <!-- Product Top-->
    <section class="container">
        <!-- Breadcrumbs-->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="index.cfm?pg=dashboard">Home</a></li>
                <li class="breadcrumb-item">
                    <cfloop array="#categoryList#" index="idx">
                        <cfif idx.PkCategoryId EQ qryGetSecLevelCat.parentCategoryId>
                            #idx.catName#
                        </cfif>
                    </cfloop>    
                </li>
                <li class="breadcrumb-item ">
                    <a href="index.cfm?pg=category&id=#getProduct.FkCategoryId#">#qryGetSecLevelCat.categoryName#</a>
                </li>
                <li class="breadcrumb-item active" aria-current="page">#getProduct.productName#</li>
            </ol>
        </nav>           
        <!-- /Breadcrumbs-->

        <div class="row g-5">
            <!-- Images Section-->
            <div class="col-12 col-lg-7">
                <div class="row g-1">
                    <cfquery name="getProductImage">
                        SELECT image, isDefault
                        FROM product_image
                        WHERE FkProductId = <cfqueryparam value="#getProduct.PkProductId#" cfsqltype = "cf_sql_integer">
                    </cfquery>
                    <div class="swiper-container gallery-thumbs-vertical col-2 pb-4">
                        <div class="swiper-wrapper">
                            <cfloop query="getProductImage">
                                <div class="swiper-slide bg-light bg-light h-auto py-2">
                                    <picture>
                                        <img class="img-fluid mx-auto d-table" src="#imagePath##getProductImage.image#" alt="" width="300" height="200">
                                    </picture>
                                </div>
                            </cfloop>
                        </div>
                    </div>
                    <div class="swiper-container gallery-top-vertical col-10">
                        <div class="swiper-wrapper">
                            <cfloop query="getProductImage">
                                <div class="swiper-slide bg-white h-auto pt-5">
                                    <picture>
                                        <img class="img-fluid d-table mx-auto" src="#imagePath##getProductImage.image#" alt="" data-zoomable>
                                    </picture>
                                </div>
                            </cfloop>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /Images Section-->
            <!-- Product Info Section-->
            <div class="col-12 col-lg-5">
                <div class="pb-5 mb-5">
                    <!-- Product Name, Review, Brand, Price-->
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <p class="small fw-bolder text-uppercase tracking-wider text-muted mb-0 lh-1">#qryGetSecLevelCat.categoryName#</p>
                        <div class="d-flex justify-content-start align-items-center">
                            <!-- Review Stars Small-->
                            <div class="rating position-relative d-table">
                                <div class="position-absolute stars" style="width: 80%">
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
                            <small class="text-muted d-inline-block ms-2 fs-bolder">(1288)</small>
                        </div>
                    </div>
                    <h1 class="mb-2 fs-2 fw-bold">#getProduct.productName#</h1>
                    <div class="d-flex justify-content-start align-items-center">
                        <p class="lead fw-bolder m-0 fs-3 lh-1 me-2"><i class="fa fa-rupee"></i> #getProduct.productPrice#</p>
                        <!--- <s class="lh-1 me-2"><span class="fw-bolder m-0">#getProduct.productPrice#</span></s>
                        <p class="lead fw-bolder m-0 fs-6 lh-1 text-success">#getProduct.productPrice#</p> --->
                    </div>
                    <!-- /Product Name, Review, Brand, Price-->
                    <div class="d-flex justify-content-between align-items-center mt-5">
                        <div class="quantity">
                            <button class="btn btn-sm btn-dark minus-btn disabled" type="button" name="button">
                                <i class="fa fa-minus"></i>
                            </button>
                            <input type="text" name="quantity" value="1" id="productQuantity">
                            <button class="btn btn-sm btn-dark plus-btn" type="button" name="button">
                                <i class="fa fa-plus"></i>
                            </button>
                        </div>
                        <div class="stock">
                            <label for="stockAvalaible" class="h5">Stock Available: </label>
                            <span id="stockAvalaible" class=" fw-bold ms-2">#getProduct.productQty#</span>
                        </div>
                    </div>
                    <!-- Add To Cart-->
                    <div class="d-flex justify-content-between mt-4">
                        <button class="btn btn-dark btn-dark-chunky flex-grow-1 me-2 text-white addToCartBtn">Add To Cart</button>
                        <button class="btn btn-orange btn-orange-chunky"><i class="ri-heart-line"></i></button>
                    </div>
                    <!-- /Add To Cart-->
                
                    <!-- Socials-->
                    <div class="my-4">
                        <div class="d-flex justify-content-start align-items-center">
                            <p class="fw-bolder lh-1 mb-0 me-3">Share</p>
                            <ul class="list-unstyled p-0 m-0 d-flex justify-content-start lh-1 align-items-center mt-1">
                                <li class="me-2"><a class="text-decoration-none" href="##" role="button"><i class="ri-facebook-box-fill"></i></a></li>
                                <li class="me-2"><a class="text-decoration-none" href="##" role="button"><i class="ri-instagram-fill"></i></a></li>
                                <li class="me-2"><a class="text-decoration-none" href="##" role="button"><i class="ri-pinterest-fill"></i></a></li>
                                <li class="me-2"><a class="text-decoration-none" href="##" role="button"><i class="ri-twitter-fill"></i></a></li>
                            </ul>
                        </div>    
                    </div>
                    <!-- Socials-->
                
                    <!-- Special Offers-->
                    <div class="bg-light rounded py-2 px-3">
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item d-flex border-0 px-0 bg-transparent">
                                <i class="ri-truck-line"></i>
                                <span class="fs-6 ms-3">Standard delivery free for orders over $99. Next day delivery $9.99</span>
                            </li>
                        </ul>
                    </div>
                    <!-- /Special Offers-->
                </div>                
            </div>
            <!-- / Product Info Section-->
        </div>
    </section>
    <!-- / Product Top-->

    <!---  Product Details --->
    <section>
        <!-- Product Tabs-->
        <div class="mt-7 pt-5 border-top">
            <div class="container">
                <!-- Tab Nav-->
                <ul class="nav justify-content-center nav-tabs nav-tabs-border mb-4" id="myTab" role="tablist">
                    <li class="nav-item w-100 mb-2 mb-sm-0 w-sm-auto mx-sm-3" role="presentation">
                        <a class="nav-link fs-5 fw-bolder nav-link-underline mx-sm-3 px-0 active" id="details-tab" data-bs-toggle="tab" href="##details"
                        role="tab" aria-controls="details" aria-selected="true">The Details</a>
                    </li>
                    <li class="nav-item w-100 mb-2 mb-sm-0 w-sm-auto mx-sm-3" role="presentation">
                        <a class="nav-link fs-5 fw-bolder nav-link-underline mx-sm-3 px-0" id="reviews-tab" data-bs-toggle="tab" href="##reviews"
                        role="tab" aria-controls="reviews" aria-selected="false">Reviews</a>
                    </li>
                    <li class="nav-item w-100 mb-2 mb-sm-0 w-sm-auto mx-sm-3" role="presentation">
                        <a class="nav-link fs-5 fw-bolder nav-link-underline mx-sm-3 px-0" id="delivery-tab" data-bs-toggle="tab" href="##delivery"
                        role="tab" aria-controls="delivery" aria-selected="false">Delivery</a>
                    </li>
                    <li class="nav-item w-100 mb-2 mb-sm-0 w-sm-auto mx-sm-3" role="presentation">
                        <a class="nav-link fs-5 fw-bolder nav-link-underline mx-sm-3 px-0" id="returns-tab" data-bs-toggle="tab" href="##returns"
                        role="tab" aria-controls="returns" aria-selected="false">Returns</a>
                    </li>
                </ul>
                <!-- / Tab Nav-->
                <!-- Tab Content-->
                <div class="tab-content" id="myTabContent">
                    <!-- Tab Details Content-->
                    <div class="tab-pane fade show active py-5" id="details" role="tabpanel" aria-labelledby="details-tab">
                        <div class="col-12 col-lg-10 mx-auto">
                            <div class="row g-5">
                                <div class="col-12 col-md-12">
                                    <p>
                                        #getProduct.productDescription#
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Tab Details Content-->
                    <!-- Review Tab Content-->
                    <div class="tab-pane fade py-5" id="reviews" role="tabpanel" aria-labelledby="reviews-tab">
                        <!-- Customer Reviews-->
                        <section class="reviews">
                            <div class="col-lg-12 text-center pb-5">
                                <h2 class="fs-1 fw-bold d-flex align-items-center justify-content-center">4.88 
                                    <small class="text-muted fw-bolder ms-3 fw-bolder fs-6">(1288 reviews)</small>
                                </h2>
                                <div class="d-flex justify-content-center">
                                    <!-- Review Stars Medium-->
                                    <div class="rating position-relative d-table">
                                        <div class="position-absolute stars" style="width: 80%">
                                            <i class="ri-star-fill text-dark ri-2x mr-1"></i>
                                            <i class="ri-star-fill text-dark ri-2x mr-1"></i>
                                            <i class="ri-star-fill text-dark ri-2x mr-1"></i>
                                            <i class="ri-star-fill text-dark ri-2x mr-1"></i>
                                            <i class="ri-star-fill text-dark ri-2x mr-1"></i>
                                        </div>
                                        <div class="stars">
                                            <i class="ri-star-fill ri-2x mr-1 text-muted"></i>
                                            <i class="ri-star-fill ri-2x mr-1 text-muted"></i>
                                            <i class="ri-star-fill ri-2x mr-1 text-muted"></i>
                                            <i class="ri-star-fill ri-2x mr-1 text-muted"></i>
                                            <i class="ri-star-fill ri-2x mr-1 text-muted"></i>
                                        </div>
                                    </div>        
                                </div>
                                <div class="bg-light rounded py-3 px-4 mt-3 col-12 col-md-6 col-lg-5 mx-auto">
                                    <ul class="list-group list-group-flush">
                                        <li class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 bg-transparent">
                                            <span class="fw-bolder">Fit</span>
                                            <!-- Review Stars Small-->
                                            <div class="rating position-relative d-table">
                                                <div class="position-absolute stars" style="width: 25%">
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
                                        </li>
                                        <li class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 bg-transparent">
                                            <span class="fw-bolder">Value for money</span>
                                            <!-- Review Stars Small-->
                                            <div class="rating position-relative d-table">
                                                <div class="position-absolute stars" style="width: 75%">
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
                                        </li>
                                        <li class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 bg-transparent">
                                            <span class="fw-bolder">Build quality</span>
                                            <!-- Review Stars Small-->
                                            <div class="rating position-relative d-table">
                                                <div class="position-absolute stars" style="width: 65%">
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
                                        </li>
                                        <li class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 bg-transparent">
                                            <span class="fw-bolder">Style</span>
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
                                        </li>
                                    </ul>
                                </div>
                                <!-- Review Modal-->
                                <button type="button" class="btn btn-dark mt-4 hover-lift-sm hover-boxshadow disable-child-pointer" data-bs-toggle="offcanvas" data-bs-target="##offcanvasReview" aria-controls="offcanvasReview">
                                    Write A Review <i class="ri-discuss-line align-bottom ms-1"></i>
                                </button>
                                <!-- / Review Modal Button-->
                            </div>
                            <!-- Single Review-->
                            <article class="py-5 border-bottom border-top">
                                <div class="row">
                                    <div class="col-12 col-md-4">
                                        <small class="text-muted fw-bolder">08/12/2021</small>
                                        <p class="fw-bolder">Ben Sandhu, Ireland</p>
                                        <span class="bg-success-faded fs-xs fw-bolder text-uppercase p-2">Verified Customer</span>
                                    </div>
                                    <div class="col-12 col-md-8 mt-4 mt-md-0">
                                        <!-- Review Stars Small-->
                                        <div class="rating position-relative d-table">
                                            <div class="position-absolute stars" style="width: 80%">
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
                                        <p class="fw-bolder mt-4">Happy with this considering the price</p>
                                        <p>
                                            Lorem ipsum dolor sit amet consectetur adipisicing elit. Sit sequi, architecto placeat nam officia
                                            sapiente ipsam at dolorum quisquam, ipsa earum qui laboriosam. Pariatur recusandae nihil, architecto
                                            reprehenderit perferendis obcaecati. Lorem ipsum dolor, sit amet consectetur adipisicing elit.
                                            Distinctio sint nesciunt velit quae, quisquam ullam veritatis itaque repudiandae. Inventore quae
                                            doloribus modi nihil illum accusamus voluptas suscipit neque perferendis totam!
                                        </p>
                                        <small class="fw-bolder bg-light d-table rounded py-1 px-2">
                                            Yes, I would recommend the product
                                        </small>
                                        <div class="d-block d-md-flex mt-3 justify-content-between align-items-center">
                                            <a href="##" class="btn btn-link text-muted p-0 text-decoration-none w-100 w-md-auto fw-bolder text-start" title="">
                                                <small>
                                                    Was this review helpful?
                                                    <i class="ri-thumb-up-line ms-4"></i> 112 
                                                    <i class="ri-thumb-down-line ms-2"></i> 23</small>
                                                </a>
                                            <a href="##"  class="btn btn-link text-muted p-0 text-decoration-none w-100 w-md-auto fw-bolder text-start mt-3 mt-md-0" title="">
                                                <small>
                                                    Flag as inappropriate <i class="ri-flag-2-line ms-2"></i>
                                                </small>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </article>
                            <!-- /Single Review-->
                            <!-- Single Review-->
                            <article class="py-5 border-bottom ">
                                <div class="row">
                                    <div class="col-12 col-md-4">
                                        <small class="text-muted fw-bolder">08/12/2021</small>
                                        <p class="fw-bolder">Patricia Smith, London</p>
                                        <span class="bg-success-faded fs-xs fw-bolder text-uppercase p-2">Verified Customer</span>
                                    </div>
                                    <div class="col-12 col-md-8 mt-4 mt-md-0">
                                        <!-- Review Stars Small-->
                                        <div class="rating position-relative d-table">
                                            <div class="position-absolute stars" style="width: 80%">
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
                                        <p class="fw-bolder mt-4">Very happy with my purchase so far...</p>
                                        <p>
                                            Lorem ipsum dolor sit amet consectetur adipisicing elit. Sit sequi, architecto placeat nam officia
                                            sapiente ipsam at dolorum quisquam, ipsa earum qui laboriosam. Pariatur recusandae nihil, architecto
                                            reprehenderit perferendis obcaecati. Lorem ipsum dolor, sit amet consectetur adipisicing elit.
                                            Distinctio sint nesciunt velit quae, quisquam ullam veritatis itaque repudiandae. Inventore quae
                                            doloribus modi nihil illum accusamus voluptas suscipit neque perferendis totam!
                                        </p>
                                        <small class="fw-bolder bg-light d-table rounded py-1 px-2">
                                            Yes, I would recommend the product
                                        </small>
                                        <div class="d-block d-md-flex mt-3 justify-content-between align-items-center">
                                            <a href="##" class="btn btn-link text-muted p-0 text-decoration-none w-100 w-md-auto fw-bolder text-start" title="">
                                                <small>
                                                    Was this review helpful?
                                                    <i class="ri-thumb-up-line ms-4"></i> 112 
                                                    <i class="ri-thumb-down-line ms-2"></i> 23
                                                </small>
                                            </a>
                                            <a href="##" class="btn btn-link text-muted p-0 text-decoration-none w-100 w-md-auto fw-bolder text-start mt-3 mt-md-0" title="">
                                                <small>
                                                    Flag as inappropriate <i class="ri-flag-2-line ms-2"></i>
                                                </small>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </article>
                            <!-- /Single Review-->
                        
                            <!-- Single Review-->
                            <article class="py-5 border-bottom ">
                                <div class="row">
                                    <div class="col-12 col-md-4">
                                        <small class="text-muted fw-bolder">08/12/2021</small>
                                        <p class="fw-bolder">Jack Jones, Scotland</p>
                                        <span class="bg-success-faded fs-xs fw-bolder text-uppercase p-2">Verified Customer</span>
                                    </div>
                                    <div class="col-12 col-md-8 mt-4 mt-md-0">
                                        <!-- Review Stars Small-->
                                        <div class="rating position-relative d-table">
                                            <div class="position-absolute stars" style="width: 80%">
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
                                        <p class="fw-bolder mt-4">I wish it was a little cheaper - otherwise love this!</p>
                                        <p>
                                            Lorem ipsum dolor sit amet consectetur adipisicing elit. Sit sequi, architecto placeat nam officia
                                            sapiente ipsam at dolorum quisquam, ipsa earum qui laboriosam. Pariatur recusandae nihil, architecto
                                            reprehenderit perferendis obcaecati. Lorem ipsum dolor, sit amet consectetur adipisicing elit.
                                            Distinctio sint nesciunt velit quae, quisquam ullam veritatis itaque repudiandae. Inventore quae
                                            doloribus modi nihil illum accusamus voluptas suscipit neque perferendis totam!
                                        </p>
                                        <small class="fw-bolder bg-light d-table rounded py-1 px-2">
                                            Yes, I would recommend the product
                                        </small>
                                        <div class="d-block d-md-flex mt-3 justify-content-between align-items-center">
                                            <a href="##" class="btn btn-link text-muted p-0 text-decoration-none w-100 w-md-auto fw-bolder text-start" title="">
                                                <small>
                                                    Was this review helpful?
                                                    <i class="ri-thumb-up-line ms-4"></i> 112 
                                                    <i class="ri-thumb-down-line ms-2"></i> 23
                                                </small>
                                            </a>
                                            <a href="##" class="btn btn-link text-muted p-0 text-decoration-none w-100 w-md-auto fw-bolder text-start mt-3 mt-md-0" title="">
                                                <small>
                                                    Flag as inappropriate <i class="ri-flag-2-line ms-2"></i>
                                                </small>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </article>
                            <!-- /Single Review-->
                            <a href="##" class="btn btn-dark d-table mx-auto mt-6 mb-3 hover-lift-sm hover-boxshadow" title="">
                                Load More Reviews
                            </a>
                            <p class="text-muted text-center fw-bolder">Showing 3 of 1234</p>
                        </section>  
                    </div>
                    <!-- / Review Tab Content-->
                    
                    <!-- Delivery Tab Content-->
                    <div class="tab-pane fade py-5" id="delivery" role="tabpanel" aria-labelledby="delivery-tab">
                        <div class="col-12 col-md-10 col-lg-8 mx-auto">
                            <p>
                                We are now offering contact-free delivery so that you can still receive your parcels safely without requiring a signature. Please see below for the available delivery methods, costs and timescales.
                            </p>
                            <ul class="list-group list-group-flush mb-4">
                                <li class="list-group-item d-flex justify-content-between align-items-center px-0 py-4 bg-transparent">
                                    <div>
                                        <span class="fw-bolder d-block">Standard Delivery</span>
                                        <span class="text-muted">Delivery within 5 days of placing your order.</span>
                                    </div>
                                    <p class="m-0 lh-1 fw-bolder">$12.99</p>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center px-0 py-4 bg-transparent">
                                    <div>
                                        <span class="fw-bolder d-block">Priority Delivery</span>
                                        <span class="text-muted">Delivery within 2 days of placing your order.</span>
                                    </div>
                                    <p class="m-0 lh-1 fw-bolder">$17.99</p>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center px-0 py-4 bg-transparent">
                                    <div>
                                        <span class="fw-bolder d-block">Next Day Delivery</span>
                                        <span class="text-muted">Delivery within 24 hours of placing your order.</span>
                                    </div>
                                    <p class="m-0 lh-1 fw-bolder">$33.99</p>
                                </li>
                            </ul>
                            <div class="bg-light rounded p-3">
                                <p class="fs-6">Form more information, please see our delivery FAQs <a href="##">here</a></p>
                                <p class="m-0 fs-6">
                                    If you do not find the answer to your query, please contact our customer support team on
                                    <b>0800 123 456</b> or email us at <b>support@domain.com</b>.
                                    We aim to respond within 48 hours to queries.
                                </p>
                            </div>
                        </div>
                    </div>
                    <!-- / Delivery Tab Content-->
                
                    <!-- Returns Tab Content-->
                    <div class="tab-pane fade py-5" id="returns" role="tabpanel" aria-labelledby="returns-tab">
                        <div class="col-12 col-md-10 col-lg-8 mx-auto">
                            <p>
                                We believe you will completely happy with your item, however if you aren't, there's no need to worry. We've listed below the ways you can return your item to us.
                            </p>
                            <ul class="list-group list-group-flush mb-4">
                                <li class="list-group-item px-0 py-4 bg-transparent">
                                    <p class="fw-bolder">Return via post</p>
                                    <p class="fs-6">
                                        To return your items for free through the postal system, please complete the returns form that
                                        comes with your order. You'll find a label at the bottom of the form. Simply peel the label and head to your nearest post office.
                                    </p>
                                </li>
                                <li class="list-group-item px-0 py-4 bg-transparent">
                                    <p class="fw-bolder">Return in person</p>
                                    <p class="fs-6">
                                        To return your items for free in person, simply stop into any one of our locations and speak
                                        to a member of our in-store team.
                                    </p>
                                </li>
                            </ul>
                            <div class="bg-light rounded p-3">
                                <p class="fs-6">Form more information, please see our returns FAQs <a href="##">here</a></p>
                                <p class="m-0 fs-6">
                                    If you do not find the answer to your query, please contact our customer support team on
                                    <b>0800 123 456</b> or email us at <b>support@domain.com</b>. 
                                    We aim to respond within 48 hours to queries.
                                </p>
                            </div>
                        </div>
                    </div>
                    <!-- / Returns Tab Content-->
                </div>
                <!-- / Tab Content-->                
            </div>
        </div>
        <!-- / Product Tabs-->
    </section>
    <!--- / Product Details --->

    <!-- Related Products-->
    <div class="container my-8">
        <h3 class="fs-4 fw-bold mb-5 text-center">You May Also Like</h3>
        <!-- Swiper Latest -->
        <div class="swiper-container overflow-visible"
            data-swiper
            data-options='{
            "spaceBetween": 25,
            "cssMode": true,
            "roundLengths": true,
            "scrollbar": {
                "el": ".swiper-scrollbar",
                "hide": false,
                "draggable": true
            },      
            "navigation": {
                "nextEl": ".swiper-next",
                "prevEl": ".swiper-prev"
            },  
            "breakpoints": {
                "576": {
                "slidesPerView": 1
                },
                "768": {
                "slidesPerView": 2
                },
                "992": {
                "slidesPerView": 3
                },
                "1200": {
                "slidesPerView": 4
                }            
            }
            }'>
            <div class="swiper-wrapper pb-5 pe-1">
                <cfloop query="getRelatedProduct">
                    <div class="swiper-slide d-flex h-auto">
                        <!-- Card Product-->
                        <div class="card position-relative h-100 card-listing hover-trigger">
                            <!--- <span class="badge card-badge bg-secondary">-65%</span> --->
                            <div class="card-header">
                                <cfquery name="getProductImage">
                                    SELECT image, isDefault
                                    FROM product_image
                                    WHERE FkProductId = <cfqueryparam value="#getRelatedProduct.PkProductId#" cfsqltype = "cf_sql_integer">
                                </cfquery>
                                <cfloop query="getProductImage">
                                    <cfif getProductImage.isDefault EQ 1>
                                        <picture class="position-relative overflow-hidden d-block bg-light">
                                            <img class="vh-25 img-fluid position-relative z-index-10" title="" src="#imagePath##getProductImage.image#" width="500" height="500" alt="">
                                        </picture>
                                    <cfelse>
                                        <picture class="position-absolute z-index-20 start-0 top-0 hover-show bg-light">
                                            <img class="vh-25 img-fluid" width="500" height="500" title="" src="#imagePath##getProductImage.image#" alt="">
                                        </picture>
                                    </cfif>
                                </cfloop>
                                <!--- <div class="card-actions">
                                    <span class="small text-uppercase tracking-wide fw-bolder text-center d-block">Quick Add</span>
                                    <div class="d-flex justify-content-center align-items-center flex-wrap mt-3">
                                        <button class="btn btn-outline-dark btn-sm mx-2">S</button>
                                        <button class="btn btn-outline-dark btn-sm mx-2">M</button>
                                        <button class="btn btn-outline-dark btn-sm mx-2">L</button>
                                    </div>
                                </div> --->
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
                                <a class="mb-0 mx-2 mx-md-4 fs-p link-cover text-decoration-none d-block text-center"
                                    href="index.cfm?pg=product&id=#getRelatedProduct.PkProductId#">
                                    #getRelatedProduct.productName#
                                </a>
                                <div class="d-flex justify-content-center align-items-center mt-2">
                                    <p class="mb-0 me-2 fw-bolder">
                                        <i class="ri-heart-line"></i> 
                                        <span>#getRelatedProduct.productPrice#</span>
                                    </p>
                                    <!---   <p class="mb-0 text-muted fw-bolder"><s>$<span>1100.00</span></s></p> --->
                                </div>
                            </div>
                        </div>
                        <!--/ Card Product-->
                    </div>
                </cfloop>
                <div class="swiper-slide d-flex h-auto justify-content-center align-items-center">
                    <a href="./category.html" class="d-flex text-decoration-none flex-column justify-content-center align-items-center">
                        <span class="btn btn-dark btn-icon mb-3"><i class="ri-arrow-right-line ri-lg lh-1"></i></span>
                        <span class="lead fw-bolder">See All</span>
                    </a>
                </div>
            </div>
            <!-- Buttons-->
            <div class="swiper-btn swiper-disabled-hide swiper-prev swiper-btn-side btn-icon bg-dark text-white ms-3 shadow-lg mt-n5 ms-n4">
                <i class="ri-arrow-left-s-line ri-lg"></i></div>
            <div class="swiper-btn swiper-disabled-hide swiper-next swiper-btn-side swiper-btn-side-right btn-icon bg-dark text-white me-n4 shadow-lg mt-n5">
                <i class="ri-arrow-right-s-line ri-lg"></i>
            </div>
            <!-- Add Scrollbar -->
            <div class="swiper-scrollbar"></div>
        </div>
        <!-- / Swiper Latest-->        
    </div>
    <!--/ Related Products-->
    <script>
        var #toScript('#productQty#', 'productQty')#
        var #toScript('#productPrice#', 'productPrice')#
        var #toScript('#id#', 'productId')#
        var #toScript('#customerId#', 'customerId')#
        $(document).ready( function () { 
            $('##productQuantity').on('keyup', function() {
                if ( $(this).val() > productQty ) {
                    warnToast("Not allowed to add this product");
                    $(this).val(productQty);
                    $('.plus-btn').addClass('disabled');
                    $('.minus-btn').removeClass('disabled');
                    //( $(this).val() === productQty) && $('.plus-btn').addClass('disabled');
                }
                
            });
            $('.minus-btn').on('click', function(e) {
                e.preventDefault();
                var $input = $(this).closest('div').find('input');
                var value = parseInt($input.val());
                $('.plus-btn').removeClass('disabled');
                if ( value > 1) {
                    value = value - 1;
                    $(this).removeClass('disabled');
                    (value === 1) &&  $(this).addClass('disabled');
                }
                $input.val(value);
            });
            
            $('.plus-btn').on('click', function(e) {
                e.preventDefault();
                var $input = $(this).closest('div').find('input');
                var value = parseInt($input.val());
                $('.minus-btn').removeClass('disabled');
                if (value <= productQty) {
                    value = value + 1;
                    $(this).removeClass('disabled');
                    (value === productQty) &&  $(this).addClass('disabled');
                } else {
                    value = productQty;
                    $(this).addClass('disabled');
                }
                $input.val(value);
            });

            $('.addToCartBtn').on('click', function (e) {
                e.preventDefault();
                var quantity = $('##productQuantity').val();
                $.ajax({  
                    url: '../ajaxAddToCart.cfm?ProductId='+ productId, 
                    data: {'productQty':quantity, 'productPrice':productPrice, 'customerId' : customerId},
                    type: 'POST',
                    success: function(result) {
                        if (result.success) {
                            successToast("Great!! You were " + quantity + " product added in to cart");
                            $.ajax({  
                                url: '../ajaxAddToCart.cfm?getCartCountValue=cartCounter', 
                                type: 'GET',
                                success: function(result) {
                                    if (result.success) {
                                        $('##offcanvasCartBtn span.cartCounter').removeClass('d-none');
                                        $('##offcanvasCartBtn > span.cartCounter').text(result.cartCountValue);
                                    } else {
                                        $('##offcanvasCartBtn span.cartCounter').addClass('d-none');
                                        $('##offcanvasCartBtn span.cartCounter').text('');
                                    }
                                },
                            });  
                        }
                    },
                });  
            })
        });
    </script>
</cfoutput>