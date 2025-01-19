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
    <title>Profile</title>
    <%@ include file="/views/common/headerlinks.jsp" %>
</head>
<body>







    <%@ include file="/views/common/headerresident.jsp" %>



    <div class="container mt-5 u_main">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <!-- Profile Card -->
                <div class="card profile-card">
                    <div class="card-header profile-header text-center">
                        <!-- Profile Image -->
                        <img src="https://via.placeholder.com/100" alt="Resident Photo" class="profile-img">
                        <h3>${resident.getFullname()}</h3>
                        <p>Resident of Room ${room.getRoomName()}</p>
                        <p>Member since:  ${user_since}</p>
                        <a href="${pageContext.request.contextPath}/u/settings" class="btn_2">Edit Profile</a>
                    </div>
                    <div class="card-body">
                        <!-- Personal Information Section -->
                        <div class="section-title">Personal Information</div>
                        <ul class="list-group">
                            <li class="list-group-item"><strong>Email:</strong> ${resident.getEmail()}</li>
                            <li class="list-group-item"><strong>Phone:</strong> ${resident.getPhone()}</li>
                            <li class="list-group-item"><strong>Gender:</strong> ${resident.getGender()}</li>
                            <li class="list-group-item"><strong>Address:</strong> ${resident.getAddress()}</li>
                        </ul>

                        <!-- Room Assignment Section -->
                        <div class="section-title">Room Details</div>
                        <ul class="list-group">
                            <li class="list-group-item"><strong>Room ID:</strong> ${room.getRoomName()}</li>
                            <li class="list-group-item"><strong>Room Size:</strong> ${room.getSize()}</li>
                            <li class="list-group-item"><strong>Room Equipment:</strong> ${room.getEquipment()}</li>
                            <li class="list-group-item"><strong>Contract Start Date:</strong> ${resident.getCStartDate()}</li>
                            <li class="list-group-item"><strong>Contract End Date:</strong> ${resident.getCEndDate()}</li>
                            <li class="list-group-item"><strong>Status:</strong>
                                <span class="StatusSpanIcon" data-badge='${room.getState()}'>
                                  <i class="
                                    ${room.getState() == 'Occupied' ? 'bi bi-check-circle color_green' :
                                      room.getState() == 'Available' ? 'bi bi-ban color_red' :
                                      room.getState() == 'Maintenance' ? 'bi bi-tools color_orange' : ''}">
                                  </i>
                                </span>
                        </ul>

                    </div>
                </div>
            </div>
        </div>
    </div>


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
