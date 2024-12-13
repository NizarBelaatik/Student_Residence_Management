<%-- 
    Document   : dashboard
    Created on : Dec 13, 2024, 9:54:43 PM
    Author     : night
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
        

                <!-- Google Fonts -->
        <link href="https://fonts.gstatic.com" rel="preconnect">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,700">
        
        
        <link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/fontawesome.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/bootstrap.min.css"> 
        <link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/template-style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/style.css">

        

        
        


        <!-- Boxicons CSS -->
        <link href='https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css' rel='stylesheet'>
        
    </head>
    <body>
        <!-- Header -->
    <header>
        <div class="logo"> <a class="toggle-btn" id="toggleBtn"><i class="fas fa-bars"></i></a> Logo</div>
        <div class="profile">
            <div class="dropdown">
                Profile
                <div class="dropdown-content">
                    <a href="#">Settings</a>
                    <a href="#">Logout</a>
                </div>
            </div>
            <div class="notifications">Notifications</div>
        </div>
    </header>

    <!-- Sidebar -->
    <aside class="sidebar" id="sidebar">
        <a href="#" class="<%= request.getAttribute("currentPage").equals("dashboard") ? "active" : "" %>" >Home</a>
        <a href="#" class="<%= request.getAttribute("currentPage").equals("Rooms") ? "active" : "" %>">Rooms</a>
        <a href="#" class="<%= request.getAttribute("currentPage").equals("Residents") ? "active" : "" %>">Residents</a>
        <a href="#" class="<%= request.getAttribute("currentPage").equals("Payments") ? "active" : "" %>">Payments</a>
        <a href="#" class="<%= request.getAttribute("currentPage").equals("Maintenance") ? "active" : "" %>">Maintenance</a>
        <a href="#" class="<%= request.getAttribute("currentPage").equals("Statistics") ? "active" : "" %>">Statistics</a>
    </aside>

    <!-- Main content -->
    <main class="main" id="main">
        
        <h1>Welcome</h1>
        <p>This is the main content area.</p>
    </main>

    <script>
        const toggleBtn = document.getElementById('toggleBtn');
        const sidebar = document.getElementById('sidebar');
        const main = document.getElementById('main');

        toggleBtn.addEventListener('click', () => {
            sidebar.classList.toggle('active');
            main.classList.toggle('sidebar-open');
        });
    </script>
    
    
    </body>
</html>
