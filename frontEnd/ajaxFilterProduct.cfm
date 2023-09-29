<!--- <cfsetting enablecfoutputonly="true" showdebugoutput="false" />
<cfheader statuscode="200" statustext="OK" />
<cfcontent reset="true" type="application/json" /> --->

<cfparam name="PkProductId" default="" />
<cfparam name="FkCategoryId" default="" />
<cfparam name="PkCategoryId" default="" />
<cfparam name="PkTagId" default="" />
<cfparam name="isDeleted" default="0" />
<cfparam name="startRow" default="">
<cfparam name="pageNum" default="1">
<cfparam name="maxRows" default="9">
<cfset startRow = ( pageNum-1 ) * maxRows>

<cffunction name="convertToObject" access="public" returntype="any" output="false"
        hint="Converts an entire query or the given record to a struct. This might return a structure (single record) or an array of structures.">
        <cfargument name="Query" type="query" required="true" />
        <cfargument name="Row" type="numeric" required="false" default="0" />
        <cfargument name="lowerCase" type="boolean" required="false" default="true" />
    
        <cfscript>
            var loc = StructNew();
			if (arguments.Query.RecordCount EQ 0){
				if (arguments.Row GT 0){
                    return(StructNew());
				}else{
                    return(arraynew(1));
				}
			}
			if (arguments.Row){
				loc.FromIndex = arguments.Row;
				loc.ToIndex = arguments.Row;
			} else {
				loc.FromIndex = 1;
				loc.ToIndex = arguments.Query.RecordCount;
			}
			if(arguments.lowerCase EQ true ){
				loc.Columns = ListToArray( LCASE(arguments.Query.ColumnList));
			}else{
				loc.Columns = ListToArray( arguments.Query.ColumnList);
			}
			loc.ColumnCount = ArrayLen( loc.Columns );
			loc.DataArray = ArrayNew( 1 );
			for (loc.RowIndex = loc.FromIndex ; loc.RowIndex LTE loc.ToIndex ; loc.RowIndex = (loc.RowIndex + 1)){
				ArrayAppend( loc.DataArray, StructNew() );
				loc.DataArrayIndex = ArrayLen( loc.DataArray );
				for (loc.ColumnIndex = 1 ; loc.ColumnIndex LTE loc.ColumnCount ; loc.ColumnIndex = (loc.ColumnIndex + 1)){
					loc.ColumnName = loc.Columns[ loc.ColumnIndex ];
					loc.DataArray[ loc.DataArrayIndex ][ loc.ColumnName ] = arguments.Query[ loc.ColumnName ][ loc.RowIndex ];
				}
			}
			if (arguments.Row){
				return( loc.DataArray[ 1 ] );
			} else {
				return( loc.DataArray );
			}
			return loc.DataArray;
    </cfscript>
</cffunction>
<cfset data = {}>
<cfset data['success'] = true>
<cfset imagePath = "http://127.0.0.1:50847/assets/productImage/">
<cftry>
    <cfquery name="getProduct">
        SELECT P.PkProductId, P.productQty, P.productName, P.productPrice, PT.PkTagId, PT.tagName 
        FROM product P
        LEFT JOIN product_tags PT ON PT.PkTagId = P.product_tags 
        WHERE P.isDeleted = <cfqueryparam value="#isDeleted#" cfsqltype = "cf_sql_bit">
        AND P.FkCategoryId = <cfqueryparam value="#url.catId#" cfsqltype = "cf_sql_integer">
        <cfif structKeyExists(url, "productTagValue") AND len(url.productTagValue) GT 0>
            AND (
                P.product_tags LIKE (<cfqueryparam value="%#url.productTagValue#%">)
                <cfloop list="#productTagValue#" item="item">
                    OR P.product_tags LIKE (<cfqueryparam value="%#item#%">)
                </cfloop>
            )
        </cfif>
        <cfif (structKeyExists(url, "minPrice") AND len(url.minPrice) GT 0) AND (structKeyExists(url, "maxPrice") AND len(url.maxPrice) GT 0)>
            AND P.productPrice BETWEEN <cfqueryparam value="#url.minPrice#" cfsqltype = "cf_sql_float"> AND <cfqueryparam value="#url.maxPrice#" cfsqltype = "cf_sql_float"> 
        </cfif>
        <cfif structKeyExists(url, "sorting") AND len(url.sorting) GT 0>
            ORDER BY #url.sorting#
        </cfif>
    </cfquery>
    <cfset totalPages = ceiling( getProduct.recordCount/maxRows )>
    <cfquery name="getProductBaseedTag">
        SELECT P.PkProductId, P.product_tags, P.productQty, P.productName, P.productPrice, PT.PkTagId, PT.tagName 
        FROM product P
        LEFT JOIN product_tags PT ON PT.PkTagId = P.product_tags 
        WHERE P.isDeleted = <cfqueryparam value="#isDeleted#" cfsqltype = "cf_sql_bit">
        AND P.FkCategoryId = <cfqueryparam value="#url.catId#" cfsqltype = "cf_sql_integer">
        <cfif structKeyExists(url, "productTagValue") AND  len(url.productTagValue) GT 0>
            AND (
                P.product_tags LIKE (<cfqueryparam value="%#url.productTagValue#%">)
                <cfloop list="#productTagValue#" item="item">
                    OR P.product_tags LIKE (<cfqueryparam value="%#item#%">)
                </cfloop>
            )
        </cfif>
        <cfif (structKeyExists(url, "minPrice") AND len(url.minPrice) GT 0) AND (structKeyExists(url, "maxPrice") AND len(url.maxPrice) GT 0)>
            AND P.productPrice BETWEEN <cfqueryparam value="#url.minPrice#" cfsqltype = "cf_sql_float"> AND <cfqueryparam value="#url.maxPrice#" cfsqltype = "cf_sql_float"> 
        </cfif>
        <cfif structKeyExists(url, "sorting") AND len(url.sorting) GT 0>
            ORDER BY #url.sorting#
        </cfif>
        LIMIT #startRow#, #maxRows#
    </cfquery>
    <cfquery name="getProductTag">
        SELECT PT.PkTagId, PT.FkCategoryId, PT.tagName, PT.isActive, PT.isDeleted
        FROM product_tags PT
        WHERE PT.isDeleted = <cfqueryparam value="0" cfsqltype = "cf_sql_bit">
        AND PT.isActive = <cfqueryparam value="1" cfsqltype = "cf_sql_bit">
        AND PT.FkCategoryId = <cfqueryparam value="#url.catId#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfdump  var="#url#">
    <cfsavecontent variable="data['html']">
        <cfoutput>
            <style>
                img {
                    width: 200px;
                    height: 300px;
                    object-fit: contain;
                }
            </style>
            <cfdump  var="#getProductBaseedTag#"> <cfabort>
            <!--- <div class="d-flex align-items-center flex-column flex-md-row justify-content-between" id="sortingFilterContainer">
                <small class="d-inline-block fw-bolder">Filtered by:</small>
                <div class="d-flex justify-content-start align-items-center flex-grow-1 mb-4 mb-md-0" id="productTagContainer">
                    <cfif tructKeyExists(url, "productTagValue") AND len(url.productTagValue) GT 0>
                        <cfquery name="qryGetTagName" dbtype="query">
                            SELECT tagName, PkTagId
                            FROM getProductTag
                            WHERE PkTagId IN (<cfqueryparam value="#url.productTagValue#" list="true">)
                        </cfquery>
                        <!--- <cfset tagList = valueList(qryGetTagName.tagName)>
                        <cfset tagNameList = listRemoveDuplicates(tagList)> --->
                        <ul class="list-unstyled d-inline-block mb-0 ms-2" id="productTypeUl">
                            <cfloop query="qryGetTagName">
                                <li class="bg-light py-1 fw-bolder px-2 cursor-pointer d-inline-block">
                                    #qryGetTagName.tagName#
                                    <i class="ri-close-circle-line align-bottom mt-1 deleteProductTag" data-id="#qryGetTagName.PkTagId#"></i>
                                </li>
                            </cfloop>
                            <!---  <cfloop list="#tagNameList#" index="item">
                                <li class="bg-light py-1 fw-bolder px-2 cursor-pointer d-inline-block">
                                    #item#
                                    <i class="ri-close-circle-line align-bottom mt-1" id="deleteProductTag" data-id="#getProductTag.PkTagId#"></i>
                                </li>
                            </cfloop> --->
                        </ul>
                        <span class="fw-bolder text-muted-hover text-decoration-underline ms-2 cursor-pointer small" id="deleteAllProductTag">
                            Clear All
                        </span>
                    </cfif>
                </div>
                <!-- Filter Trigger-->
                <button class="btn bg-light p-3 d-flex d-lg-none align-items-center fs-xs fw-bold text-uppercase w-100 mb-2 mb-md-0 w-md-auto" type="button" data-bs-toggle="offcanvas" data-bs-target="##offcanvasFilters" aria-controls="offcanvasFilters">
                    <i class="ri-equalizer-line me-2"></i> Filters
                </button>
                <!-- / Filter Trigger-->
                <div class="dropdown ms-md-2 lh-1 p-3 bg-light w-100 mb-2 mb-md-0 w-md-auto">
                    <p class="fs-xs fw-bold text-uppercase text-muted-hover p-0 m-0" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Sort By <i class="ri-arrow-drop-down-line ri-lg align-bottom"></i>
                    </p>
                    <ul class="dropdown-menu" id="sortingFilterUl">
                        <li>
                            <a class="dropdown-item fs-xs fw-bold text-uppercase text-muted-hover mb-2 sortingFilter" data-order="productPrice DESC">
                                Price: Hi Low
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item fs-xs fw-bold text-uppercase text-muted-hover mb-2 sortingFilter" data-order="productPrice ASC">
                                Price: Low Hi
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item fs-xs fw-bold text-uppercase text-muted-hover mb-2 sortingFilter" data-order="productName ASC">
                                Name
                            </a>
                        </li>
                    </ul>
                </div>
            </div> --->
            <!-- Top Toolbar-->
                <!--- <div class="mb-4 d-md-flex justify-content-between align-items-center">
                    <div class="d-flex justify-content-start align-items-center flex-grow-1 mb-4 mb-md-0">
                        <small class="d-inline-block fw-bolder">Filtered by:</small>
                        <cfif len(url.productTagValue) GT 0>
                            <cfquery name="qryGetTagName" dbtype="query">
                                SELECT tagName, PkTagId
                                FROM getProductTag
                                WHERE PkTagId IN (<cfqueryparam value="#url.productTagValue#" list="true">)
                            </cfquery>
                            <!--- <cfset tagList = valueList(qryGetTagName.tagName)>
                            <cfset tagNameList = listRemoveDuplicates(tagList)> --->
                            <ul class="list-unstyled d-inline-block mb-0 ms-2" id="productTypeUl">
                                <cfloop query="qryGetTagName">
                                    <li class="bg-light py-1 fw-bolder px-2 cursor-pointer d-inline-block">
                                        #qryGetTagName.tagName#
                                        <i class="ri-close-circle-line align-bottom mt-1 deleteProductTag" data-id="#qryGetTagName.PkTagId#"></i>
                                    </li>
                                </cfloop>
                                <!---  <cfloop list="#tagNameList#" index="item">
                                    <li class="bg-light py-1 fw-bolder px-2 cursor-pointer d-inline-block">
                                        #item#
                                        <i class="ri-close-circle-line align-bottom mt-1" id="deleteProductTag" data-id="#getProductTag.PkTagId#"></i>
                                    </li>
                                </cfloop> --->
                            </ul>
                            <span class="fw-bolder text-muted-hover text-decoration-underline ms-2 cursor-pointer small" id="deleteAllProductTag">
                                Clear All
                            </span>
                        </cfif>
                    </div>
                    <div class="d-flex align-items-center flex-column flex-md-row" >
                        <!-- Filter Trigger-->
                        <button class="btn bg-light p-3 d-flex d-lg-none align-items-center fs-xs fw-bold text-uppercase w-100 mb-2 mb-md-0 w-md-auto" type="button" data-bs-toggle="offcanvas" data-bs-target="##offcanvasFilters" aria-controls="offcanvasFilters">
                            <i class="ri-equalizer-line me-2"></i> Filters
                        </button>
                        <!-- / Filter Trigger-->
                        <div class="dropdown ms-md-2 lh-1 p-3 bg-light w-100 mb-2 mb-md-0 w-md-auto">
                            <p class="fs-xs fw-bold text-uppercase text-muted-hover p-0 m-0" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Sort By <i class="ri-arrow-drop-down-line ri-lg align-bottom"></i>
                            </p>
                            <ul class="dropdown-menu" id="sortingFilterUl">
                                <li class="dropdown-list-item">
                                    <a class="dropdown-item fs-xs fw-bold text-uppercase text-muted-hover mb-2 sortingFilter <cfif structKeyExists(url, 'sorting') AND url.sorting EQ 'productPrice DESC'>active</cfif>" data-order="productPrice DESC">
                                        Price: Hi Low
                                    </a>
                                </li>
                                <li class="dropdown-list-item">
                                    <a class="dropdown-item fs-xs fw-bold text-uppercase text-muted-hover mb-2 sortingFilter <cfif structKeyExists(url, 'sorting') AND url.sorting EQ 'productPrice ASC'>active</cfif>" data-order="productPrice ASC">
                                        Price: Low Hi
                                    </a>
                                </li>
                                <li class="dropdown-list-item">
                                    <a class="dropdown-item fs-xs fw-bold text-uppercase text-muted-hover mb-2 sortingFilter <cfif structKeyExists(url, 'sorting') AND url.sorting EQ 'productName ASC'>active</cfif>" data-order="productName ASC">
                                        Name
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div> 
                </div> --->                    
            <!-- / Top Toolbar-->
            <!-- Products-->
            <div class="row g-4 mb-5">
                <cfif getProductBaseedTag.recordCount GT 0>
                    <cfloop query="getProductBaseedTag">
                        <cfquery name="getProductImage">
                            SELECT image, isDefault
                            FROM product_image
                            WHERE FkProductId = <cfqueryparam value="#getProductBaseedTag.PkProductId#" cfsqltype = "cf_sql_integer">
                        </cfquery>
                        <div class="col-12 col-sm-6 col-md-4">
                            <!-- Card Product-->
                            <div class="card position-relative h-100 card-listing hover-trigger">
                                <div class="card-header d-flex align-self-center">
                                    <cfloop query="getProductImage">
                                        <cfif getProductImage.isDefault GT 0>
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
                                        #getProductBaseedTag.productName#
                                    </a>
                                    <p class="fw-bolder m-0 mt-2"><i class="fa fa-rupee"></i> #getProductBaseedTag.productPrice#</p>
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
            <!-- Products-->
            <!-- Pagination-->
            <nav class="border-top mt-5 pt-5 d-flex justify-content-between align-items-center" aria-label="Category Pagination">
                <ul class="pagination">
                    <li class="page-item <cfif pageNum EQ 1>disabled</cfif>">
                        <a class="page-link prev" href="index.cfm?pg=category&id=#url.catId#&pageNum=#pageNum-1#<cfif structKeyExists(url, 'productTagValue')>&tags=#url.productTagValue#</cfif><cfif structKeyExists(url, 'sorting')>&sorting=#url.sorting#</cfif>" data-id="#pageNum#" >
                            <i class="ri-arrow-left-line align-bottom"></i>
                            Prev
                        </a>
                    </li>
                </ul>
                <ul class="pagination">
                    <cfloop from="1" to="#totalPages#" index="i">
                        <li class="page-item <cfif pageNum EQ i>active</cfif> mx-1">
                            <a class="page-link" href="index.cfm?pg=category&id=#url.catId#&pageNum=#i#<cfif structKeyExists(url, 'productTagValue')>&tags=#url.productTagValue#</cfif><cfif structKeyExists(url, 'sorting')>&sorting=#url.sorting#</cfif>">
                                #i#
                            </a>
                        </li>
                    </cfloop>
                </ul>
                <ul class="pagination">
                    <li class="page-item <cfif pageNum EQ totalPages>disabled</cfif>">
                        <a class="page-link next" href="index.cfm?pg=category&id=#url.catId#&pageNum=#pageNum+1#<cfif structKeyExists(url, 'productTagValue')>&tags=#url.productTagValue#</cfif><cfif structKeyExists(url, 'sorting')>&sorting=#url.sorting#</cfif>">Next 
                            <i class="ri-arrow-right-line align-bottom"></i>
                        </a>
                    </li>
                </ul>
            </nav>                    
            <!-- / Pagination-->
        </cfoutput>
    </cfsavecontent>
    <cfcatch>
        <cfset data['success'] = false>
        <cfset data['error'] = cfcatch>
    </cfcatch>
</cftry>
<cfset output =  serializeJSON(data)/>
<cfoutput>#output#</cfoutput>


