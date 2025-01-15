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

                    <!-- Maintenance Request Header -->
                    <div class="profile-header">
                        <h3>Submit Maintenance Request </h3>
                        <p>Please fill out the form below to report an issue.</p>
                    </div>

                    <!-- Maintenance Request Form -->
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/u/make_request" method="POST" id="maintenanceRequestForm">
                            <div class="section-title">Maintenance Information</div>

                            <div class="form-group mb-3">
                                <label for="incidentType">Incident Type</label>
                                <select class="form-control" id="incidentType" name="incidentType" required>
                                    <option value="">Select Incident Type</option>
                                    <option value="Water Leak">Water Leak</option>
                                    <option value="Electrical Issue">Electrical Issue</option>
                                    <option value="Heating Problem">Heating Problem</option>
                                    <option value="Air Conditioning Issue">Air Conditioning Issue</option>
                                    <option value="Broken Window">Broken Window</option>
                                    <option value="Pest Control">Pest Control</option>
                                    <option value="Internet Connectivity">Internet Connectivity</option>
                                    <option value="Appliance Repair">Appliance Repair</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>

                            <div class="form-group mb-3">
                                <label for="description">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="4" required></textarea>
                            </div>




                            <div class="text-center">
                                <button type="submit" class="submit_btn">Submit Request</button>
                                <button type="reset" class="reset_btn">Reset</button>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>
    </div>



    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>









    <script>
        var contextPath = "${pageContext.request.contextPath}"; // Get the context path
        var roomId = "${roomId}"; // Get the room ID from the JSP context
        console.log(roomId);
        $('#maintenanceRequestForm').on('submit', function(event) {
            event.preventDefault(); // Prevent the default form submission

            // Gather form data and convert it to a JSON object
            var formData = $(this).serializeArray(); // Get form data as an array
            var jsonData = {}; // Create an empty object to hold the data

            // Convert the serialized array to a JSON object
            $.each(formData, function() {
                jsonData[this.name] = this.value; // Populate the JSON object
            });

            // Add roomId to the JSON object
            jsonData.roomId = roomId;

            // AJAX request to submit the maintenance request
            $.ajax({
                url: contextPath + '/u/make_request', // Your servlet URL
                method: 'POST',
                contentType: 'application/json', // Set content type to JSON
                data: JSON.stringify(jsonData), // Convert the JSON object to a string
                dataType: 'json', // Expect JSON response
                success: function(response) {
                    if (response.status === "success") {
                        Swal.fire({
                            icon: 'success',
                            title: 'Request Submitted!',
                            text: 'Your maintenance request has been submitted successfully.',
                            showConfirmButton: false,
                            timer: 3000
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Request Failed',
                            text: response.message || 'There was an issue submitting your request. Please try again.',
                            confirmButtonText: 'Try Again'
                        });
                    }
                },
                error: function() {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'An error occurred. Please try again later.',
                        confirmButtonText: 'OK'
                    });
                }

            });
        });

    </script>



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
