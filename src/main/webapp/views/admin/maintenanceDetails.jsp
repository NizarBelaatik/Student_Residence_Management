<%@ page import="java.util.List" %>
<%@ page import="model.Resident" %>
<%@ page import="model.Payment" %>
<%@ page import="jakarta.servlet.*, jakarta.servlet.http.*, java.io.*, java.util.*, java.sql.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="model.UserAdminTInfo" %>
<%
    String currentPage = "maintenance";  // or any dynamic value
    request.setAttribute("currentPage", currentPage);
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>Maintenance Details</title>
    <%@ include file="/views/common/headeradminlinks.jsp" %>
</head>

<body>
    <%@ include file="/views/common/headeradmin.jsp" %>
    <%@ include file="/views/common/asideadmin.jsp" %>

    <!-- Main content -->
    <main class="main" id="main">
        <div class="pagetitle">
            <h1>Manage Maintenance Requests</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/maintenance">Manage Maintenance Requests</a></li>
                    <li class="breadcrumb-item active">Maintenance Details</li>
                </ol>
            </nav>
        </div>
        <section>
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card_1">
                        <div class="card_1-body">
                            <div class="card_1-header">
                                <h5>Edit Maintenance Request | ${M_data.getId()}</h5>
                            </div>

                            <form id="editMaintenanceRequestForm" method="post" action="${pageContext.request.contextPath}/admin/maintenance/maintenanceDetails">
                                <input type="hidden" class="form-control" name="inputRequestId" value="${M_data.getId()}">

                                <div class="row mb-3">
                                    <label for="inputResidentEmail" class="col-sm-2 col-form-label">Resident Email</label>
                                    <div class="col-sm-10">
                                        <input type="email" class="form-control" name="inputResidentEmail" value="${M_data.getResidentEmail()}" required readonly>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <label for="inputRoomId" class="col-sm-2 col-form-label">Room ID</label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" name="inputRoomId" value="${M_data.getRoomId()}" required readonly>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <label for="inputIssueType" class="col-sm-2 col-form-label">Issue Type</label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" name="inputIssueType" value="${M_data.getIssueType()}" required readonly>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <label for="inputIssueDescription" class="col-sm-2 col-form-label">Issue Description</label>
                                    <div class="col-sm-10">
                                        <textarea class="form-control" name="inputIssueDescription" required readonly>${M_data.getIssueDescription()}</textarea>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <label for="inputTechnician" class="col-sm-2 col-form-label">Technician</label>
                                    <div class="col-sm-10">
                                        <%
                                            // Retrieve the technician list and selected technician name from the request
                                            List<UserAdminTInfo> technicians = (List<UserAdminTInfo>) request.getAttribute("technician");
                                            String selectedTechnicianEmail = (String) request.getAttribute("getTechnicianName");
                                        %>

                                        <select name="inputTechnician" class="form-select" required>
                                            <option value="" disabled selected>Select Technician</option>
                                            <%
                                                // Iterate over the technicians list and create the option tags
                                                for (UserAdminTInfo technician : technicians) {
                                            %>
                                                <option value="<%= technician.getEmail() %>" <%= (technician.getEmail().equals(selectedTechnicianEmail)) ? "selected" : "" %> >
                                                    <%= technician.getFullname() %> (<%= technician.getEmail() %>)
                                                </option>
                                            <%
                                                }
                                            %>
                                        </select>

                                    </div>
                                </div>



                                <div class="row mb-3">
                                    <label for="inputStatus" class="col-sm-2 col-form-label">Status</label>
                                    <div class="col-sm-10">
                                        <select name="inputStatus" class="form-select" required>
                                            <option value="pending" ${M_data.getStatus().equals("pending") ? 'selected' : ''}>Pending</option>
                                            <option value="in_progress" ${M_data.getStatus().equals("in_progress") ? 'selected' : ''}>In Progress</option>
                                            <option value="resolved" ${M_data.getStatus().equals("resolved") ? 'selected' : ''}>Resolved</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="text-center">
                                    <button type="submit" class="btn1 submit_btn">Submit</button>
                                    <button type="reset" class="btn1 cancel_btn">Reset</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>

    </main>

    <script>
            var contextPath = "${pageContext.request.contextPath}";
            var csrfToken = $("meta[name='csrf-token']").attr("content");
            $(document).ready(function() {
                // Handle form submission
                $('#editMaintenanceRequestForm').submit(function(e) {
                    e.preventDefault(); // Prevent default form submission

                    // Perform AJAX request
                    $.ajax({
                        url: contextPath+'/admin/maintenance/maintenanceDetails', // The servlet URL
                        method: 'POST',
                        data: $(this).serialize(), // Serialize the form data
                        headers: {'X-CSRF-Token': csrfToken},

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
    <%@ include file="/views/common/footer.jsp" %>

    <script src="${pageContext.request.contextPath}/component/js/tools/jquery-3.3.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/component/js/script.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>








</body>

</html>
