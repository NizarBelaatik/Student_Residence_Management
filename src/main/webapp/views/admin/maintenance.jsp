<%@ page import="java.util.List" %>
<%@ page import="model.MaintenanceRequests" %>
<%@ page import="jakarta.servlet.*, jakarta.servlet.http.*, java.io.*, java.util.*, java.sql.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<%
    String currentPage = "maintenance";  // or any dynamic value
    request.setAttribute("currentPage", currentPage);
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>Manage Maintenance Requests</title>
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
                    <li class="breadcrumb-item active">Manage Maintenance Requests</li>
                </ol>
            </nav>
        </div>
        <section>
            <!-- Pending Maintenance Requests -->
            <div class="row justify-content-center">
                <div class="col-lg-12">
                    <div class="card_1">
                        <div class="card_1-body">
                            <h5 class="card_1-title clr_orange">Pending Requests</h5>
                            <div class="card_1-header" style="display: flex;">
                                <input class="form-control" type="text" id="filterInput" placeholder="Search..." style="width:45%;min-width:150px;">
                            </div>
                            <div class="table-wrap">
                                <table class="table2 table-striped table-hover table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Requests ID</th>
                                            <th>Resident Email</th>
                                            <th>Room ID</th>
                                            <th>Issue Type</th>
                                            <th>Issue Description</th>
                                            <th>Status</th>
                                            <th>Technician Name</th>
                                            <th>Created Date</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% List<MaintenanceRequests> M_pending = (List<MaintenanceRequests>) request.getAttribute("M_pending");
                                           if (M_pending != null) {
                                               for (MaintenanceRequests requestData : M_pending) { %>
                                                   <tr>
                                                        <td><%= requestData.getId() %></td>
                                                       <td><%= requestData.getResidentEmail() %></td>
                                                       <td><%= requestData.getRoomId() %></td>
                                                       <td><%= requestData.getIssueType() %></td>
                                                       <td><%= requestData.getIssueDescription() %></td>
                                                       <td><span class="StatusSpan" data-badge='<%= requestData.getStatus() %>'><%= requestData.getStatus() %></span></td>
                                                       <td><%= requestData.getTechnicianName() != null ? requestData.getTechnicianName() : "N/A" %></td>
                                                       <td><%= requestData.getCreatedAt() %></td>
                                                       <td>
                                                            <a class="btn btn_eye " href="${pageContext.request.contextPath}/admin/maintenance/maintenanceDetails?requestId=<%= requestData.getId() %>">
                                                                <i class="bi bi-eye-fill fa-2x"></i>
                                                            </a>
                                                       </td>
                                                   </tr>
                                        <% } } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- In Progress Maintenance Requests -->
                <div class="col-lg-12">
                    <div class="card_1">
                        <div class="card_1-body">
                            <h5 class="card_1-title clr_blue">In Progress Requests</h5>
                            <div class="card_1-header" style="display: flex;">
                                <input class="form-control" type="text" id="filterInput" placeholder="Search..." style="width:45%;min-width:150px;">
                            </div>
                            <div class="table-wrap">
                                <table class="table2 table-striped table-hover table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Requests ID</th>
                                            <th>Resident Email</th>
                                            <th>Room ID</th>
                                            <th>Issue Type</th>
                                            <th>Issue Description</th>
                                            <th>Status</th>
                                            <th>Technician Name</th>
                                            <th>Created Date</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% List<MaintenanceRequests> M_in_progress = (List<MaintenanceRequests>) request.getAttribute("M_in_progress");
                                           if (M_in_progress != null) {
                                               for (MaintenanceRequests requestData : M_in_progress) { %>
                                                   <tr>
                                                        <td><%= requestData.getId() %></td>
                                                       <td><%= requestData.getResidentEmail() %></td>
                                                       <td><%= requestData.getRoomId() %></td>
                                                       <td><%= requestData.getIssueType() %></td>
                                                       <td><%= requestData.getIssueDescription() %></td>
                                                       <td><span class="StatusSpan" data-badge='<%= requestData.getStatus() %>'><%= requestData.getStatus() %></span></td>
                                                       <td><%= requestData.getTechnicianName() != null ? requestData.getTechnicianName() : "N/A" %></td>
                                                       <td><%= requestData.getCreatedAt() %></td>
                                                       <td>
                                                            <a class="btn btn_eye " href="${pageContext.request.contextPath}/admin/maintenance/maintenanceDetails?requestId=<%= requestData.getId() %>">
                                                               <i class="bi bi-eye-fill fa-2x"></i>
                                                           </a>
                                                       </td>
                                                   </tr>
                                        <% } } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Resolved Maintenance Requests -->
                <div class="col-lg-12">
                    <div class="card_1">
                        <div class="card_1-body">
                            <h5 class="card_1-title clr_green">Resolved Requests</h5>
                            <div class="card_1-header" style="display: flex;">
                                <input class="form-control" type="text" id="filterInput" placeholder="Search..." style="width:45%;min-width:150px;">
                            </div>
                            <div class="table-wrap">
                                <table class="table2 table-striped table-hover table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Requests ID</th>
                                            <th>Resident Email</th>
                                            <th>Room ID</th>
                                            <th>Issue Type</th>
                                            <th>Issue Description</th>
                                            <th>Status</th>
                                            <th>Technician Name</th>
                                            <th>Resolved Date</th>
                                            <th>Created Date</th>
                                            <th>Resolved Date</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% List<MaintenanceRequests> M_resolved = (List<MaintenanceRequests>) request.getAttribute("M_resolved");
                                           if (M_resolved != null) {
                                               for (MaintenanceRequests requestData : M_resolved) { %>
                                                   <tr>
                                                        <td><%= requestData.getId() %></td>
                                                       <td><%= requestData.getResidentEmail() %></td>
                                                       <td><%= requestData.getRoomId() %></td>
                                                       <td><%= requestData.getIssueType() %></td>
                                                       <td><%= requestData.getIssueDescription() %></td>
                                                       <td><span class="StatusSpan" data-badge='<%= requestData.getStatus() %>'><%= requestData.getStatus() %></span></td>
                                                       <td><%= requestData.getTechnicianName() != null ? requestData.getTechnicianName() : "N/A" %></td>
                                                       <td><%= requestData.getResolvedDate() != null ? requestData.getResolvedDate() : "N/A" %></td>
                                                       <td><%= requestData.getCreatedAt() %></td>
                                                       <td><%= requestData.getResolvedDate() %></td>
                                                       <td>
                                                           <a class="btn btn_eye " href="${pageContext.request.contextPath}/admin/maintenance/maintenanceDetails?requestId=<%= requestData.getId() %>">
                                                               <i class="bi bi-eye-fill fa-2x"></i>
                                                           </a>
                                                       </td>
                                                   </tr>
                                        <% } } %>
                                    </tbody>
                                </table>
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
