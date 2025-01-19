<%
    String currentPage = "settings";  // or any dynamic value
    request.setAttribute("currentPage", currentPage);
%>

<%@ page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.*,jakarta.servlet.http.*,java.io.*,java.util.*,java.sql.*"%>

<!DOCTYPE html>
<html>
    <head>

        <title>Settings</title>
        <%@ include file="/views/common/headeradminlinks.jsp" %>


    </head>
    </head>
    <body>
        <%@ include file="/views/common/headeradmin.jsp" %>
        <%@ include file="/views/common/asideadmin.jsp" %>

    <!-- Main content -->
    <main class="main" id="main">
        <div class="pagetitle">
            <h1>Settings</h1>
            <nav>
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Dashboard</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/profile">Profile</a></li>
                <li class="breadcrumb-item active">settings</li>
              </ol>
            </nav>
          </div>
        <section>
            <div class="container mt-5 u_main">
                <div class="row justify-content-center">
                    <div class="col-lg-10">
                        <div class="edit-profile-card">

                            <!-- Profile Header -->
                            <div class="profile-header">
                                <h3>Edit Profile</h3>
                                <p>Update your information below</p>
                            </div>

                            <!-- Change Password Form -->
                            <div class="card-body card-body1">
                                <form id="change-password-form" method="post">
                                    <button class="btn_1" type="submit">Change Password</button>
                                </form>
                                <!-- Notification Box -->
                                <div id="notificationPW" style="display: none; padding: 10px; margin-top: 20px;"></div>
                            </div>

                            <!-- Profile Edit Form -->
                            <div class="card-body card-body1">
                                <form action="${pageContext.request.contextPath}/admin/settings" method="POST" id="settingsForm">
                                    <div class="section-title">Personal Information</div>
                                    <div class="form-group mb-3">
                                        <label for="firstname">First Name</label>
                                        <input type="text" class="form-control" id="firstname" name="firstname" value="${admin.getFirstname()}" required>
                                    </div>

                                    <div class="form-group mb-3">
                                        <label for="lastname">Last Name</label>
                                        <input type="text" class="form-control" id="lastname" name="lastname" value="${admin.getLastname()}" required>
                                    </div>


                                    <div class="form-group mb-3">
                                        <label for="phone">Phone</label>
                                        <input type="text" class="form-control" id="phone" name="phone" value="${admin.getPhone()}" required>
                                    </div>


                                    <div class="text-center">
                                      <button type="submit" class="submit_btn">Submit</button>
                                          <button type="reset" class="reset_btn">Reset</button>
                                    </div>

                                </form>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </section>
        <script>
            var contextPath = "${pageContext.request.contextPath}";
            $(document).ready(function() {
                // Handle form submission
                $('#settingsForm').submit(function(e) {
                    e.preventDefault(); // Prevent default form submission

                    // Perform AJAX request
                    $.ajax({
                        url: contextPath+'/admin/settings', // The servlet URL
                        method: 'POST',
                        data: $(this).serialize(), // Serialize the form data
                        dataType: 'json', // Expect a JSON response
                        success: function(response) {
                            // Handle successful form submission (response will contain messageType and message)
                            if (response.messageType === "success") {
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Success!',
                                    text: response.message,
                                    showConfirmButton: false,
                                    timer: 3000
                                }).then(() => {
                                    $('#addRoomForm')[0].reset(); // Reset the form after success
                                });
                            } else if (response.messageType === "error") {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Oops...',
                                    text: response.message,
                                    confirmButtonText: 'Try Again'
                                });
                            }
                        },
                        error: function(xhr, status, error) {
                            // Handle AJAX errors
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: 'An error occurred while processing your request. Please try again later.',
                                confirmButtonText: 'OK'
                            });
                        }
                    });
                });
            });
        </script>


        <script>
            $(document).ready(function() {
                // Handle the form submission
                $('#change-password-form').submit(function(event) {
                    event.preventDefault(); // Prevent default form submission
                    var contextPath = "${pageContext.request.contextPath}";
                    // AJAX request (email is already in the session, so no need to send it)
                    $.ajax({
                        url: contextPath+'/change-password',  // Servlet URL
                        type: 'POST',
                        dataType: 'json',  // Expecting a JSON response
                        success: function(response) {
                            // Display notification based on the response
                            var notificationBox = $('#notificationPW');
                            notificationBox.text(response.message);
                            if (response.messageType === "success") {
                                notificationBox.css('background-color', 'green').css('color', 'white');
                            } else {
                                notificationBox.css('background-color', 'red').css('color', 'white');
                            }
                            notificationBox.show();  // Show the notification box
                        },
                        error: function(xhr, status, error) {
                            // Handle errors
                            var notificationBox = $('#notificationPW');
                            notificationBox.text("An error occurred. Please try again.");
                            notificationBox.css('background-color', 'red').css('color', 'white');
                            notificationBox.show();
                        }
                    });
                });
            });
        </script>




    </main>
    <%@ include file="/views/common/footer.jsp" %>


    <script src="${pageContext.request.contextPath}/component/js/tools/jquery-3.3.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/component/js/script.js"></script>
</body>
</html>
