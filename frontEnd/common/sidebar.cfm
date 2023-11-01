<cfoutput>
    <style>
        ##sideMenu .list-group-item:hover{
            background: ##f77948 !important;
            transition: all 0.3s linear !important;
        }
    </style>
    <div class="<!--- sticky-md-top ---> top-5 z-index-1">
        <h2 class="pt-3">Others Menu</h2>
        <ul class="bg-dark px-3 list-group py-3" id="sideMenu">
            <!--- <li class="list-group-item bg-dark rounded-0">
                <a href="" class="text-white text-decoration-none">My Account</a>
            </li> --->
            <li class="list-group-item bg-dark rounded-0">
                <a href="../index.cfm?pg=account&s=editAccount" class="text-white text-decoration-none">Edit Account</a>
            </li>
            <li class="list-group-item bg-dark rounded-0">
                <a href="../index.cfm?pg=account&s=changePassword" class="text-white text-decoration-none"> Change Password</a>
            </li>
            <!--- <li class="list-group-item bg-dark rounded-0">
                <a href="" class="text-white text-decoration-none">My Addresses</a>
            </li> --->
            <li class="list-group-item bg-dark rounded-0">
                <a href="" class="text-white text-decoration-none">Wish List</a>
            </li>
            <li class="list-group-item bg-dark rounded-0">
                <a href="index.cfm?pg=orders" class="text-white text-decoration-none">My Orders</a>
            </li>
            <li class="list-group-item bg-dark rounded-0">
                <a href="../validate.cfm?formAction=logOut" class="text-white text-decoration-none">Logout</a>
            </li>
        </ul>
    </div>
</cfoutput>