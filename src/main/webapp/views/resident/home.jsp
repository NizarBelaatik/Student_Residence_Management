<%-- 
    Document   : index
    Created on : Dec 11, 2024, 4:46:56 PM
    Author     : night
--%>

<%@ page session="true" %>
<%@ page import="model.Notification" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.*,jakarta.servlet.http.*,java.io.*,java.util.*,java.sql.*"%><!DOCTYPE html>
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
                    <a class="dropdown-btn notification-button">
                        <i class="bi bi-bell">
                            <span class="badge badge-number"
                                  <% Integer unreadCount = (Integer) request.getAttribute("unreadCount");
                                    if (unreadCount == 0) { %>
                                      style="display: none;" <%
                                  } %> >
                                <%= unreadCount > 0 ? unreadCount : "" %>
                            </span>
                        </i>
                    </a>
                    <ul class="dropdown-notifications">
                        <%
                            List<Notification> notifications = (List<Notification>) request.getAttribute("notifications");
                            for (Notification notif : notifications) {
                        %>
                            <li class="notification-item <%= notif.getStatus() ?  "" : "unchecked" %>">
                                <% if ("reminder".equals(notif.getType())) { %>
                                    <!-- Reminder icon -->
                                    <i class="notification-icon icon-reminder bi bi-exclamation-triangle-fill"></i>
                                <% } else if ("danger".equals(notif.getType())) { %>
                                    <!-- Danger icon -->
                                    <i class="notification-icon icon-danger bi bi-exclamation-octagon"></i>
                                <% } else if ("success".equals(notif.getType())) { %>
                                    <!-- Danger icon -->
                                    <i class="notification-icon icon-success bi bi-check-circle"></i>
                                <% } %>
                                <div class="notification-content">
                                    <strong><%= notif.getSubject() %></strong>
                                    <p><%= notif.getMsg() %></p>
                                </div>
                            </li>
                        <%
                            }
                        %>

                        <!-- Other notifications go here -->
                        <li class="notification-divider"></li>
                        <li style="display:none;"><a href="#all-notifications" class="show-all-notifications">Show All Notifications</a></li>
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
                        <li><a href="${pageContext.request.contextPath}/logout" class="dropdown-item" >Logout</a></li>
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

<script>
// Function to toggle dropdown visibility with animation and remove the notification count
function toggleDropdown(event) {
    const dropdown = event.currentTarget; // Get the clicked dropdown element
    const dropdownContent = dropdown.querySelector('.dropdown-notifications'); // Find the dropdown content inside

    // Find the badge element inside the dropdown
    const badge = dropdown.querySelector('.badge');

    // Check if the badge is visible (i.e., unread notifications are present)
    if (badge && badge.offsetHeight > 0 && badge.offsetWidth > 0) {
        sendNotificationStatusUpdate('${resident.getEmail()}');
    }

    // Remove the notification badge (span) when the dropdown is clicked
    if (badge) {
        badge.remove(); // Remove the badge when clicking the dropdown
    }

    // Close other dropdowns if open
    const allDropdowns = document.querySelectorAll('.dropdown');
    allDropdowns.forEach((d) => {
        if (d !== dropdown) {
            d.classList.remove('active'); // Remove active class from other dropdowns
        }
    });

    // Toggle the active class to trigger the animation
    dropdown.classList.toggle('active');
}

// Function that performs some other task, like making an API call
    var contextPath = "${pageContext.request.contextPath}";
    function sendNotificationStatusUpdate(email) {
        $.ajax({
            url: contextPath+'/u/updateNotificationStatus',  // Correct URL to the servlet
            type: 'POST',                      // Use POST for sending data
            data: {
                email: email                  // Send email as a parameter
            },
            success: function(response) {
                console.log('Success:', response);  // Handle success response
            },
            error: function(xhr, status, error) {
                console.error('Error:', error);  // Handle error response
            }
        });
    }

// Event listener for the dropdown
document.querySelectorAll('.dropdown').forEach((dropdown) => {
    dropdown.addEventListener('click', toggleDropdown);
});

// Close dropdowns when clicking outside
document.addEventListener('click', function (event) {
    const dropdowns = document.querySelectorAll('.dropdown');
    dropdowns.forEach((dropdown) => {
        const dropdownContent = dropdown.querySelector('.dropdown-notifications');
        if (!dropdown.contains(event.target) && !event.target.closest('.dropdown')) {
            dropdown.classList.remove('active'); // Remove active class when clicked outside
        }
    });
});

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
