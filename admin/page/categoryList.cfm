<cfoutput>
    <cfquery name="getCategoryData">
        SELECT PkCategoryId, categoryName, categoryImage, isActive, createdBy, updatedBy, dateCreated, dateUpdated, isDeleted
        FROM category
    </cfquery>
    <div class="page-heading">
        <div class="page-title">
            <div class="row">
                <div class="col-12 col-md-6 order-md-1 order-last">
                    <h1>Category</h1>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="index.cfm?pg=category&s=categoryList">Category</a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">
                                Categories
                            </li>
                        </ol>
                    </nav>
                </div>
                <cfif structKeyExists(session.user, 'categorySave') AND session.user.categorySave EQ 1>
                    <div class="alert alert-light-success alert-dismissible show fade">
                        <i class="bi bi-check-circle"></i> Category Data successfully inserted..!!!
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <cfset StructDelete(session.user,'categorySave')>
                <cfelseif structKeyExists(session.user, 'categoryUpdate') AND session.user.categoryUpdate EQ 1>
                    <div class="alert alert-light-success alert-dismissible show fade">
                        <i class="bi bi-check-circle"></i> Category Data successfully updated..!!!
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <cfset StructDelete(session.user,'categoryUpdate')>

                </cfif>
            </div>
        </div>
        <!-- Data Tables start -->
        <section class="section">
            <div class="card">
                <div class="card-header d-flex justify-content-end">
                    <a href="index.cfm?pg=category&s=categoryAdd&PkCategoryId=0" class="" >
                        <button class="btn btn-primary" name="addCategory" id="addCategory">
                            <i class="bi bi-plus-lg"></i>
                        </button>
                    </a>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table" id="categoryDataTable">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Image</th>
                                    <th>Create By</th>
                                    <th>Create Date</th>
                                    <th>Update By</th>
                                    <th>Update Date</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <cfloop query="getCategoryData">
                                    <tr>
                                        <td>#getCategoryData.categoryName#</td>
                                        <td>#getCategoryData.categoryImage#</td>
                                        <td>#getCategoryData.createdBy#</td>
                                        <td>#getCategoryData.dateCreated#</td>
                                        <td>#getCategoryData.updatedBy#</td>
                                        <td>#getCategoryData.dateUpdated#</td>
                                        <td>#getCategoryData.isActive#</td>
                                    </tr>
                                </cfloop>
                                <!--- <tr>
                                    <td>Harding</td>
                                    <td>Lorem.ipsum.dolor@etnetuset.com</td>
                                    <td>0800 1111</td>
                                    <td>Obaix</td>
                                    <td>
                                    <span class="badge bg-success">Active</span>
                                    </td>
                                </tr> --->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </section>
        <!-- Data Tables end -->
    </div>
</cfoutput>
<script>
    $(document).ready( function () {
        /* $('#categoryDataTable').DataTable(); */
        $('#categoryDataTable').DataTable({
            processing: true,
            pageLength: 10,
            pagination: 'datatablePagination',
            order: [[0, 'asc']],
            responsive: true,
        });
    });
</script>