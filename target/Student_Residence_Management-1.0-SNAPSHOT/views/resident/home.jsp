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
   
    <%@ include file="/views/common/headerresident.jsp" %>



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
