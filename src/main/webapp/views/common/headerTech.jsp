<%@ page import="model.Notification" %>
    <header>

        <a class="dashboard_btn_T" href="${pageContext.request.contextPath}/t">Dashboard</a>
        <div class="right-header">
            <!-- Hamburger Menu -->

            <div class="notification">
                <div class="dropdown">
                    <a class="dropdown-btn notification-button">
                        <i class="bi bi-bell">
                            <span class="badge badge-number" id="unread-count">
                                <!-- Unread count will be dynamically set here -->
                            </span>
                        </i>
                    </a>
                    <ul class="dropdown-notifications" id="notification-list">
                        <!-- Notifications will be dynamically loaded here -->
                    </ul>
                </div>
            </div>

            <div class="profile">
                <div class="dropdown">
                    <i class="bi bi-person-fill" style="font-size:28px;"></i>
                    <a class="dropbtn"><span class="username">${tech.getFirstname()} ${tech.getLastname()}</span><i class="bi bi-caret-down-fill"></i></a>
                    <ul class="dropdown-profile">
                        <li class="dropdown-header">${tech.getFirstname()} ${tech.getLastname()}</li>
                        <li class="dropdown-header">${tech.getEmail()}</li>
                        <li class="dropdown-divider"></li>
                        <li><a href="${pageContext.request.contextPath}/t/profile" class="dropdown-item"><i class="bi bi-person icon"></i> Profile</a></li>
                        <li><a href="${pageContext.request.contextPath}/t/settings" class="dropdown-item"><i class="bi bi-gear icon"></i> Settings</a></li>
                        <li><a href="${pageContext.request.contextPath}/logout" class="dropdown-item power_off_btn" ><i class="bi bi-power icon "></i> Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>


    </header>


<!-- Include jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- JavaScript to handle AJAX call -->
<script>
    // Get the context path (you can use this for the server URL)
    var contextPath = "${pageContext.request.contextPath}";
    var csrfToken = $("meta[name='csrf-token']").attr("content");
    // Function to fetch notifications
    function fetchNotifications() {
        $.ajax({
            url: contextPath + '/api/notification',  // Send the GET request to the servlet
            method: 'GET',
            headers: {'X-CSRF-Token': csrfToken},
            dataType: 'json',
            success: function(data) {
                const notifications = data.notifications;
                const notificationList = $('#notification-list');
                notificationList.empty();  // Clear the list before updating

                // Update the unread count
                const unreadCount = data.unreadCount;
                const unreadCountElement = $('#unread-count');
                if (unreadCount > 0) {
                    unreadCountElement.text(unreadCount).show();  // Show the unread count if greater than 0
                } else {
                    unreadCountElement.hide();  // Hide the badge if there are no unread notifications
                }

                // Loop through the notifications and append them to the list
                notifications.forEach(notif => {
                    const li = $('<li>', { class: 'notification-item' });
                    if (!notif.status) {
                        li.addClass('unchecked');  // Mark as unread if status is false
                    }

                    // Set the correct icon based on the notification type
                    const icon = $('<i>', { class: 'notification-icon' });
                    if (notif.type === 'reminder' || notif.type ==='pending' ) {
                        icon.addClass('notification-icon icon-reminder bi bi-exclamation-triangle-fill');
                   } else if (notif.type ==='in_progress') {
                   icon.addClass('notification-icon icon-reminder bi bi-arrow-repeat');

                    } else if (notif.type === 'danger' || notif.type ==='in_progress') {
                        icon.addClass('notification-icon icon-danger bi bi-exclamation-octagon');
                    } else if (notif.type === 'success' || notif.type === 'resolved') {
                        icon.addClass('notification-icon icon-success bi bi-check-circle');
                    }

                    // Add the icon to the list item
                    li.append(icon);

                    // Add notification content
                    const contentDiv = $('<div>', { class: 'notification-content' });
                    contentDiv.append($('<strong>').text(notif.subject));
                    contentDiv.append($('<p>').text(notif.msg));

                    li.append(contentDiv);

                    // Append the notification item to the list
                    notificationList.append(li);
                });
            },
            error: function(error) {
                console.error('Error fetching notifications:', error);
            }
        });
    }

    // Call the fetchNotifications function when the page loads
    $(document).ready(function() {
        fetchNotifications();
    });

</script>


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
        var csrfToken = $("meta[name='csrf-token']").attr("content");
        function sendNotificationStatusUpdate(email) {
            $.ajax({
                url: contextPath+'/api/updateNotificationStatus',  // Correct URL to the servlet
                type: 'POST',                      // Use POST for sending data
                data: {
                    email: email                  // Send email as a parameter
                },
                headers: {'X-CSRF-Token': csrfToken},
                dataType: 'json',
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