

<header>
        <div class="logo"> <a class="toggle-btn" id="toggleBtn"><i class="fas fa-bars"></i></a> <a class="header_home_btn"href="${pageContext.request.contextPath}/admin/dashboard"></a></div>
        <div class="profile">
            <div class="dropdown">
                <i class="bi bi-person-fill" style="font-size:28px;"></i>
                <a class="dropbtn"><span class="username">${admin.getFirstname()} ${admin.getLastname()}</span><i class="bi bi-caret-down-fill"></i></a>
                <div class="dropdown-content">
                    <a href="${pageContext.request.contextPath}/admin/profile">Profile</a>
                    <a href="${pageContext.request.contextPath}/admin/settings">Settings</a>
                    <a class=" power_off_btn"href="${pageContext.request.contextPath}/logout">Logout</a>
                </div>
            </div>

        </div>

</header>