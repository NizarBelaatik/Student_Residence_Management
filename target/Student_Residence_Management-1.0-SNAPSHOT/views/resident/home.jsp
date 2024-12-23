<%-- 
    Document   : index
    Created on : Dec 11, 2024, 4:46:56 PM
    Author     : night
--%>

<%@ page session="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Start Page</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
        
        <link href="https://fonts.gstatic.com" rel="preconnect">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,700">


        <link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/fontawesome.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/vendor/bootstrap.min.css"> 

        <link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/vendor/bootstrap-icons/bootstrap-icons.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/vendor/bootstrap-icons/bootstrap-icons.min.css">

        <!-- Boxicons CSS -->
        <link href='https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css' rel='stylesheet'>
        <!-- SweetAlert2 for notifications -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        
        <link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/fontawesome.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/vendor/bootstrap.min.css"> 
        <link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/style2.css">

        

        
        <style>
   
        </style>


        <!-- Boxicons CSS -->
        <link href='https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css' rel='stylesheet'>

    </head>
    <body>

        
        
        
        
<body >
   
    <header>
        <div class="left-tabs " >
            <a class="tab-button">Home</a>
            <a class="tab-button">Profile</a>
            <a class="tab-button">Messages</a>
        </div>
        <button class="hamburger-menu" onclick="toggleMenu()">&#9776;</button>
        <div class="right-header">
            <!-- Hamburger Menu -->

            <div class="notification">
                <div class="dropdown">
                    <a class="dropdown-btn notification-button"><i class="bi bi-bell"> <span class="badge badge-number">4</span></i></a>
                    <ul class="dropdown-notifications">
                        <li class="notification-item">
                            <img src="https://via.placeholder.com/30" alt="Icon" class="notification-icon">
                            <div class="notification-content">
                                <strong>New Message</strong>
                                <p>You have a new message from Jane.</p>
                            </div>
                        </li>
                        <!-- Other notifications go here -->
                        <li class="notification-divider"></li>
                        <li><a href="#all-notifications" class="show-all-notifications">Show All Notifications</a></li>
                    </ul>
                </div>
            </div>

            <div class="profile">
                <div class="dropdown">
                    <i class="bi bi-person-fill" style="font-size:28px;"></i>
                    <a class="dropbtn"><span class="username">${resident.getFirstname()} ${resident.getLastname()}</span><i class="bi bi-caret-down-fill"></i></a>
                    <ul class="dropdown-profile">
                        <li class="dropdown-header">${resident.getFirstname()} ${resident.getLastname()}</li>
                        <li class="dropdown-header">${resident.getEmail()}</li>
                        <li class="dropdown-divider"></li>
                        <li><a href="#profile" class="dropdown-item">Profile</a></li>
                        <li><a href="#settings" class="dropdown-item">Settings</a></li>
                        <li><a href="#logout" class="dropdown-item" onclick="logout()">Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>


    </header>

    <!-- Menu Items (Hidden by Default) -->
    <div class="menu-items">
        <a href="#">Home</a>
        <a href="#">Profile</a>
        <a href="#">Messages</a>
        <a href="#">Settings</a>
    </div>



    <div class="" id="home">
        

       
    </div>

    <script src="js/tools/jquery-3.3.1.min.js"></script>
    <!-- https://jquery.com/download/ -->
    <script src="js/tools/moment.min.js"></script>
    <!-- https://momentjs.com/ -->
    <script src="js/tools/Chart.min.js"></script>
    <!-- http://www.chartjs.org/docs/latest/ -->
    <script src="js/tools/bootstrap.min.js"></script>
    <!-- https://getbootstrap.com/ -->
    <script src="js/tools/tooplate-scripts.js"></script>
    
    <script>
        function toggleMenu() {
            const menuItems = document.querySelector('.menu-items');
            menuItems.classList.toggle('active');
        }
    </script>

</body>

        
        
        <script src="${pageContext.request.contextPath}/component/js/script.js"></script>
        <script src="${pageContext.request.contextPath}/component/js/tooplate-scripts.js"></script>
        
        <script src="${pageContext.request.contextPath}/component/js/script.js"></script>
        <script src="${pageContext.request.contextPath}/component/js/script.js"></script>
        <script src="${pageContext.request.contextPath}/component/js/script.js"></script>
        
        <script src="${pageContext.request.contextPath}/component/js/tools/jquery-3.3.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/component/js/tools/moment.min.js"></script>
        <script src="${pageContext.request.contextPath}/component/js/tools/Chart.min.js"></script>
        <script src="${pageContext.request.contextPath}/component/js/tools/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/component/js/tools/tooplate-scripts.js"></script>
    </body>
</html>
