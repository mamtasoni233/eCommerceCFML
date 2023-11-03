<cfparam name="PkWishListId" default="" />
<cfparam name="FkCustomerId" default="" />
<cfparam name="FkProductId" default="" />
<cfparam name="isLike" default="" />
<cfparam name="productName" default="" />
<cfparam name="image" default="">
<cfparam name="pageNum" default="1">
<cfparam name="maxRows" default="9">
<cfparam name="customerId" default="#session.customer.isLoggedIn#">
<cfset startRow = ( pageNum-1 ) * maxRows>
<cfquery name="getWishListDataRows">
    SELECT
        W.PkWishListId, W.FkProductId, W.FkCustomerId, W.isLike, PI.image, P.productName, P.productDescription
    FROM
        product_wishlist W
    LEFT JOIN product P ON
        W.FkProductId = P.PkProductId
        LEFT JOIN product_image PI ON W.FkProductId = PI.FkProductId AND PI.isDefault = 1
    WHERE W.isLike = <cfqueryparam value = "1" cfsqltype = "cf_sql_bit">
    AND W.FkCustomerId = <cfqueryparam value="#customerId#" cfsqltype = "cf_sql_bit">
    ORDER BY W.PkWishListId DESC
</cfquery>
<cfset totalPages = ceiling( getWishListDataRows.recordCount/maxRows )>
<cfquery name="getWishListData">
    SELECT
        W.PkWishListId, W.FkProductId, W.FkCustomerId, W.isLike, PI.image, P.productName, P.productDescription
    FROM
        product_wishlist W
    LEFT JOIN product P ON
        W.FkProductId = P.PkProductId
        LEFT JOIN product_image PI ON W.FkProductId = PI.FkProductId AND PI.isDefault = 1
    WHERE W.isLike = <cfqueryparam value = "1" cfsqltype = "cf_sql_bit">
    AND W.FkCustomerId = <cfqueryparam value="#customerId#" cfsqltype = "cf_sql_bit">
    ORDER BY W.PkWishListId DESC
    LIMIT #startRow#, #maxRows#
</cfquery>
<cfoutput>
    <cfset imagePath = "http://127.0.0.1:50847/assets/productImage/">
    <section class="container">
        <!-- Breadcrumbs-->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="index.cfm?pg=dashboard">Home</a></li>
                <li class="breadcrumb-item active" aria-current="page">My Wishlist</li>
            </ol>
        </nav>           
        <!-- /Breadcrumbs-->
        <!-- Data Tables start -->
        <div class="row">
                <h1>MY Wishlist</h1>
                <div class="col-md-9">
                    <table class="table-responsive table table-bordered bordered-3 table-hover align-middle mt-3 shadow-lg" id="orderDataTable">
                        <thead >
                            <tr class="text-capitalize fw-bold">
                                <th class="ps-5">Product Name</th>
                                <th class="text-center">Image</th>
                                <th class="text-center">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <cfif getWishListData.recordCount EQ 0>
                                <tr>
                                    <td colspan="3" class="text-center text-muted">No record found</td></tr>
                                </tr>
                            <cfelse>
                                <cfloop query="getWishListData">
                                    <tr>
                                        <td class="ps-5">
                                            <a style="cursor:pointer;" class="text-decoration-none" href="index.cfm?pg=product&id=#getWishListData.FkProductId#" data-bs-toggle="tooltip" title="View">
                                                #getWishListData.productName#
                                            </a>
                                        </td>
                                        <td class="text-center">
                                            <img data-fancybox="group" class="image" src="#imagePath##getWishListData.image#" width="50" height="50">
                                        </td>
                                        <td class="text-center">
                                            <a class="btn btn-sm btn-danger removeBtn" data-id=#getWishListData.FkProductId# data-name="#getWishListData.productName#" data-bs-toggle="tooltip" title="Remove">
                                                <i class="fa fa-remove"></i>
                                            </a>
                                        </td>
                                    </tr>

                                </cfloop>
                            </cfif>
                        </tbody>
                    </table>
                    <cfif getWishListData.recordCount GT 5>
                        <ul class="pagination pagination-sm justify-content-end">
                            <li class="page-item <cfif pageNum EQ 1>disabled</cfif>">
                                <a  href="index.cfm?pg=account&s=wishList&pageNum=#pageNum-1#" data-id="#pageNum#" class="page-link prev" >Previous</a>
                            </li>
                            <cfloop from="#max(1, pageNum - 2)#" to="#min(totalPages, pageNum + 2)#" index="i">
                                <li class="page-item <cfif pageNum EQ i>active</cfif>">
                                    <a class="page-link mr-2" href="index.cfm?pg=account&s=wishList&pageNum=#i#">
                                        #i#
                                    </a>
                                </li>
                            </cfloop>
                            <li class="page-item <cfif pageNum EQ totalPages>disabled</cfif>">
                                <a href="index.cfm?pg=account&s=wishList&pageNum=#pageNum+1#" data-id="#pageNum#" class="page-link next">Next</a>
                            </li>
                        </ul> 
                    </cfif>
                </div>
                <div class="col-md-3">
                    <cfinclude template="../common/sidebar.cfm">
                </div>
            </div>
        <!-- Data Tables end -->
    </section>

    <script>
        $( document ).ready(function() {
            $(".removeBtn").click(function(){
                var id = $(this).attr("data-id");
                var name = $(this).data("name");
                Swal.fire({
                    title: 'Are you sure?',
                    text: 'You want to remove wishlist for' + ' "'+name +'" ',
                    icon: 'warning',
                    showCancelButton: true,
                    showCancelButton: true,
                    confirmButtonColor: 'rgb(239 88 32)',
                    confirmButtonText: 'Yes, remove it!'
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({
                            type: "POST",
                            url: '../ajaxAddToCart.cfm?formAction=removeWishList', 
                            data :{ 'productId':id},
                            success: function(result) {
                                setTimeout(() => {
                                    location.reload();
                                }, 200);
                            }
                        });
                    }
                })
            });
        });
    </script>                                                                        
</cfoutput>
