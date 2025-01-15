<%--
    Document   : index
    Created on : Dec 11, 2024, 4:46:56 PM
    Author     : night
--%>

<%@ page session="true" %>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.*,jakarta.servlet.http.*,java.io.*,java.util.*,java.sql.*"%><!DOCTYPE html>
<html>
<head>
    <title>Settings</title>
    <%@ include file="/views/common/headerresidentlinks.jsp" %>

</head>
<body>







    <%@ include file="/views/common/headerresident.jsp" %>



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
                    <div class="card-body">
                        <form id="change-password-form" method="post">
                            <button class="btn_1" type="submit">Change Password</button>
                        </form>
                        <!-- Notification Box -->
                        <div id="notificationPW" style="display: none; padding: 10px; margin-top: 20px;"></div>
                    </div>

                    <!-- Profile Edit Form -->
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/u/settings" method="POST" id="settingsForm">
                            <div class="section-title">Personal Information</div>
                            <div class="form-group mb-3">
                                <label for="firstname">First Name</label>
                                <input type="text" class="form-control" id="firstname" name="firstname" value="${Res.getFirstname()}" required>
                            </div>

                            <div class="form-group mb-3">
                                <label for="lastname">Last Name</label>
                                <input type="text" class="form-control" id="lastname" name="lastname" value="${Res.getLastname()}" required>
                            </div>


                            <div class="form-group mb-3">
                                <label for="phone">Phone</label>
                                <input type="text" class="form-control" id="phone" name="phone" value="${Res.getPhone()}" required>
                            </div>
                            <div class="form-group mb-3">
                                <label for="gender">Gender</label>
                                <select class="form-control col-3" id="gender" name="gender" required>
                                    <option value="male" ${Res.getGender() == 'male' ? 'selected' : ''}>Male</option>
                                    <option value="female" ${Res.getGender() == 'female' ? 'selected' : ''}>Female</option>
                                </select>
                            </div>

                            <div class="form-group mb-3">
                                <label for="address">Address</label>
                                <input type="text" class="form-control" id="address" name="address" value="${Res.getAddress()}" required>
                            </div>

                            <!--<div class="form-group mb-3">
                                <label for="notifications" class="form-label">Enable Notifications</label>
                                <div class="form-check form-switch">
                                    <input class="form-check-input custom-checkbox" type="checkbox" id="notifications" name="notifications" checked>
                                </div>
                            </div>-->
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

        <script>
            var contextPath = "${pageContext.request.contextPath}";
            $(document).ready(function() {
                // Handle form submission
                $('#settingsForm').submit(function(e) {
                    e.preventDefault(); // Prevent default form submission

                    // Perform AJAX request
                    $.ajax({
                        url: contextPath+'/u/settings', // The servlet URL
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



    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>








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
    <%@ include file="/views/common/footer.jsp" %>
</body>
</html>
