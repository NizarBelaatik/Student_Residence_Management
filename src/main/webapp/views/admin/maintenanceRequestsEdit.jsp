<%@ page import="java.util.List" %>
<%@ page import="model.Resident" %>
<%@ page import="model.Payment" %>
<%@ page import="jakarta.servlet.*, jakarta.servlet.http.*, java.io.*, java.util.*, java.sql.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<%
    String currentPage = "maintenance_requests";  // or any dynamic value
    request.setAttribute("currentPage", currentPage);
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>Maintenance Requests</title>
    <%@ include file="/views/common/headeradminlinks.jsp" %>
</head>

<body>
    <%@ include file="/views/common/headeradmin.jsp" %>
    <%@ include file="/views/common/asideadmin.jsp" %>

    <!-- Main content -->
    <main class="main" id="main">
        <div class="pagetitle">
            <h1>Manage Payments</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/maintenance_requests">Maintenance Requests</a></li>
                    <li class="breadcrumb-item active">Edit</li>
                </ol>
            </nav>
        </div>
        <section>

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
                                        <p>${maintenanceR.getIssueType()}</p>
                                    </div>

                                    <div class="form-group mb-3">
                                        <label for="description">Description</label>
                                        <p>${maintenanceR.getIssueDescription()}</p>
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

        </section>
    </main>
    <%@ include file="/views/common/footer.jsp" %>

    <script src="${pageContext.request.contextPath}/component/js/tools/jquery-3.3.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/component/js/script.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>








</body>

</html>
