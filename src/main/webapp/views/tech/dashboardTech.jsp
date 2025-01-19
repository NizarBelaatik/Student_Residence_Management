<%@ page session="true" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.*,jakarta.servlet.http.*,java.io.*,java.util.*,java.sql.*"%><!DOCTYPE html>
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
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Description</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>

                                %>
                            </tbody>
                        </table>

                    </div>
                </div>

            </div>
        </div>
    </main>


    <%@ include file="/views/common/footer.jsp" %>
</body>
</html>
