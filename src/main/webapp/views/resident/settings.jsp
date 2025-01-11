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



    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="edit-profile-card">

                    <!-- Profile Header -->
                    <div class="profile-header">
                        <h3>Edit Profile</h3>
                        <p>Update your information below</p>
                    </div>

                    <!-- Profile Edit Form -->
                    <div class="card-body">
                        <form action="/update-profile" method="POST">
                            <div class="section-title">Personal Information</div>
                            <div class="form-group mb-3">
                                <label for="firstname">First Name</label>
                                <input type="text" class="form-control" id="firstname" name="firstname" value="John" required>
                            </div>

                            <div class="form-group mb-3">
                                <label for="lastname">Last Name</label>
                                <input type="text" class="form-control" id="lastname" name="lastname" value="Doe" required>
                            </div>


                            <div class="form-group mb-3">
                                <label for="phone">Phone</label>
                                <input type="text" class="form-control" id="phone" name="phone" value="+1234567890" required>
                            </div>
                            <div class="form-group mb-3">
                                <label for="gender">Gender</label>
                                <select class="form-control col-3" id="gender" name="gender" required>
                                    <option value="male" >Male</option>
                                    <option value="female">Female</option>

                                </select>
                            </div>

                            <div class="form-group mb-3">
                                <label for="address">Address</label>
                                <input type="text" class="form-control" id="address" name="address" value="123 Main Street, City" required>
                            </div>

                            <div class="form-group mb-3">
                                <label for="notifications" class="form-label">Enable Notifications</label>
                                <div class="form-check form-switch">
                                    <input class="form-check-input custom-checkbox" type="checkbox" id="notifications" name="notifications" checked>
                                </div>
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



    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>


    <script src="js/tools/jquery-3.3.1.min.js"></script>
    <!-- https://jquery.com/download/ -->
    <script src="js/tools/moment.min.js"></script>
    <!-- https://momentjs.com/ -->
    <script src="js/tools/Chart.min.js"></script>
    <!-- http://www.chartjs.org/docs/latest/ -->
    <script src="js/tools/bootstrap.min.js"></script>
    <!-- https://getbootstrap.com/ -->
    <script src="js/tools/tooplate-scripts.js"></script>













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
</body>
</html>
