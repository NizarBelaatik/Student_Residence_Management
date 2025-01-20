<%@ page session="true" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.*,jakarta.servlet.http.*,java.io.*,java.util.*,java.sql.*"%><!DOCTYPE html>
<%@ page import="model.MaintenanceRequests" %>
<html>
<head>
    <title>Dashboard</title>
    <%@ include file="/views/common/headerlinks.jsp" %>
</head>
<body>

    <%@ include file="/views/common/headerTech.jsp" %>


    <main class="mt-5 u_main">
        <div class="row justify-content-center">
            <div class="col-lg-12">

                <!-- Dashboard Card -->
                <div class="card dashboard-card">
                    <div class="card-header text-center">
                        <h1>Welcome, ${tech.getFullname()}</h1>
                    </div>
                    <div class="card-body">

                        <!-- Profile and Settings Links -->
                        <div class="row mb-4">
                            <div class="col-md-6 text-center">
                                <a href="profile.jsp" class="btn_1">View Profile</a>
                            </div>
                            <div class="col-md-6 text-center">
                                <a href="settings.jsp" class="btn_1">Go to Settings</a>
                            </div>
                        </div>

                        <!-- Requests Section -->
                        <div class="section-title">Requests</div>
                        <div class="card_1-header" style="display: flex;">
                            <input class="form-control" type="text" id="filterInput" placeholder="Search..." style="width:45%;min-width:150px;">
                        </div>
                        <div class="table-wrap" style="overflow: auto; width: 100%; max-width: 100%;height:100%; max-height:900px; ">
                            <table class="table2 table-striped table-hover table-bordered" >
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
                                    <% List<MaintenanceRequests> maintenanceDATA = (List<MaintenanceRequests>) request.getAttribute("maintenanceDATA");
                                       if (maintenanceDATA != null) {
                                           for (MaintenanceRequests requestData : maintenanceDATA) { %>
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
                                                        <a class="btn btn_eye " href="${pageContext.request.contextPath}/t/maintenance/maintenanceDetails?requestId=<%= requestData.getId() %>">
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
    </main>


    <%@ include file="/views/common/footer.jsp" %>
</body>
</html>
