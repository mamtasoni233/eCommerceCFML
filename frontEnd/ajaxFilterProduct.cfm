<cfsetting enablecfoutputonly="true" showdebugoutput="false" />
<cfheader statuscode="200" statustext="OK" />
<cfcontent reset="true" type="application/json" />

<cfparam name="PkProductId" default="" />
<cfparam name="FkCategoryId" default="" />
<cfparam name="PkCategoryId" default="" />
<cfparam name="PkTagId" default="" />
<cfparam name="isDeleted" default="0" />
<cfparam name="startRow" default="">
<cfparam name="pageNum" default="1">
<cfparam name="maxRows" default="9">
<cfparam name="sorting" default="P.productName ASC">
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
        <cfif structKeyExists(url, 'sorting') AND len(url.sorting) GT 0>
            ORDER BY #url.sorting#
        <cfelse>
            ORDER BY #sorting#
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
        <cfif (structKeyExists(url, "minPrice") AND url.minPrice GT 0) OR (structKeyExists(url, "maxPrice") AND url.maxPrice GT 0)>
            AND P.productPrice BETWEEN <cfqueryparam value="#url.minPrice#" cfsqltype = "cf_sql_float"> AND <cfqueryparam value="#url.maxPrice#" cfsqltype = "cf_sql_float"> 
        </cfif>
        <cfif structKeyExists(url, 'sorting') AND len(url.sorting) GT 0>
            ORDER BY #url.sorting#
        <cfelse>
            ORDER BY #sorting#
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
    <cfsavecontent variable="data['html']">
        <cfoutput>
            <style>
                img {
                    width: 200px;
                    height: 300px;
                    object-fit: contain;
                }
            </style>
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
                        <a class="page-link prev" href="index.cfm?pg=category&id=#url.catId#&pageNum=#pageNum-1#<cfif structKeyExists(url, 'productTagValue')>&tags=#url.productTagValue#</cfif><cfif structKeyExists(url, 'sorting')>&sorting=#url.sorting#</cfif><cfif structKeyExists(url, 'minPrice')>&minPrice=#url.minPrice#</cfif><cfif structKeyExists(url, 'maxPrice')>&maxPrice=#url.maxPrice#</cfif>" data-id="#pageNum#" >
                            <i class="ri-arrow-left-line align-bottom"></i>
                            Prev
                        </a>
                    </li>
                </ul>
                <ul class="pagination">
                    <cfloop from="1" to="#totalPages#" index="i">
                        <li class="page-item <cfif pageNum EQ i>active</cfif> mx-1">
                            <a class="page-link" href="index.cfm?pg=category&id=#url.catId#&pageNum=#i#<cfif structKeyExists(url, 'productTagValue')>&tags=#url.productTagValue#</cfif><cfif structKeyExists(url, 'sorting')>&sorting=#url.sorting#</cfif><cfif structKeyExists(url, 'minPrice')>&minPrice=#url.minPrice#</cfif><cfif structKeyExists(url, 'maxPrice')>&maxPrice=#url.maxPrice#</cfif>">
                                #i#
                            </a>
                        </li>
                    </cfloop>
                </ul>
                <ul class="pagination">
                    <li class="page-item <cfif pageNum EQ totalPages>disabled</cfif>">
                        <a class="page-link next" href="index.cfm?pg=category&id=#url.catId#&pageNum=#pageNum+1#<cfif structKeyExists(url, 'productTagValue')>&tags=#url.productTagValue#</cfif><cfif structKeyExists(url, 'sorting')>&sorting=#url.sorting#</cfif><cfif structKeyExists(url, 'minPrice')>&minPrice=#url.minPrice#</cfif><cfif structKeyExists(url, 'maxPrice')>&maxPrice=#url.maxPrice#</cfif>">Next 
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


