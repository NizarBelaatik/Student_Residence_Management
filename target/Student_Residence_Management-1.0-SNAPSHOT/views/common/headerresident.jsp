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
                <span id="unread-count">0</span> <!-- Display unread count here -->
                <ul class="dropdown-notifications">
                    <!-- Notifications will be inserted dynamically by JS -->
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
                    <li><a href="${pageContext.request.contextPath}/u/profile" class="dropdown-item">Profile</a></li>
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


<script>
    // Function to fetch notifications and update the dropdown
    var contextPath = "${pageContext.request.contextPath}";

    function fetchNotifications() {
        fetch(contextPath + '/u/notification') // Adjust this URL to match your servlet's URL
            .then(response => response.json())
            .then(data => {
                if (data.notifications) {
                    const notificationList = document.querySelector('.dropdown-notifications');
                    notificationList.innerHTML = ''; // Clear the current notifications

                    // Iterate over notifications and append them to the list
                    data.notifications.forEach(notif => {
                        const li = document.createElement('li');
                        li.classList.add('notification-item');
                        if (!notif.status) {
                            li.classList.add('unchecked');
                        }

                        // Add icon based on notification type
                        let icon = '';
                        if (notif.type === 'reminder') {
                            icon = '<i class="notification-icon icon-reminder bi bi-exclamation-triangle-fill"></i>';
                        } else if (notif.type === 'danger') {
                            icon = '<i class="notification-icon icon-danger bi bi-exclamation-octagon"></i>';
                        } else if (notif.type === 'success') {
                            icon = '<i class="notification-icon icon-success bi bi-check-circle"></i>';
                        }

                        li.innerHTML = `${icon}
                                        <div class="notification-content">
                                            <strong>${notif.subject}</strong>
                                            <p>${notif.msg}</p>
                                        </div>`;

                        notificationList.appendChild(li);
                    });

                    // Update unread count
                    document.getElementById('unread-count').textContent = data.unreadCount;
                }
            })
            .catch(error => console.error('Error fetching notifications:', error));
    }

    // Call fetchNotifications on page load to get the initial notifications
    window.addEventListener('DOMContentLoaded', fetchNotifications);
</script>
