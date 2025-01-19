<%@ page session="true" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.*,jakarta.servlet.http.*,java.io.*,java.util.*,java.sql.*"%><!DOCTYPE html>
<html>
<head>
    <title>Profile</title>
    <%@ include file="/views/common/headerlinks.jsp" %>
</head>
<body>

    <%@ include file="/views/common/headerTech.jsp" %>


    <div class="container mt-5 u_main">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <!-- Profile Card -->
                <div class="card profile-card">
                    <div class="card-header profile-header text-center">
                        <!-- Profile Image -->
                        <h3>${tech.getFullname()}</h3>
                        <p>Member since:  ${user_since}</p>
                        <a href="${pageContext.request.contextPath}/t/settings" class="btn_2">Edit Profile</a>
                    </div>
                    <div class="card-body">
                        <!-- Personal Information Section -->
                        <div class="section-title">Personal Information</div>
                        <ul class="list-group">
                            <li class="list-group-item"><strong>Email:</strong> ${tech.getEmail()}</li>
                            <li class="list-group-item"><strong>First name:</strong> ${tech.getFirstname()}</li>
                            <li class="list-group-item"><strong>Last name:</strong> ${tech.getLastname()}</li>
                            <li class="list-group-item"><strong>Phone:</strong> ${tech.getPhone()}</li>
                        </ul>



                    </div>
                </div>
            </div>
        </div>
    </div>


    <%@ include file="/views/common/footer.jsp" %>
</body>
</html>
