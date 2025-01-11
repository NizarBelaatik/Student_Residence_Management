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
    <title>Home</title>
    <%@ include file="/views/common/headerresidentlinks.jsp" %>
</head>
<body>

    <%@ include file="/views/common/headerresident.jsp" %>



    <div class="container mt-5 u_main">
        <div class="row justify-content-center">
            <div class="col-md-10">

                <!-- Dashboard Card -->
                <div class="card dashboard-card">
                    <div class="card-header text-center">
                        <h3>Welcome, John Doe</h3>
                        <p>Resident of Room 101</p>
                    </div>
                    <div class="card-body">

                        <!-- Room Status Section -->
                        <div class="section-title">Room Status</div>
                        <div class="row">
                            <div class="col-md-6">
                                <h5>Room Type: Large</h5>
                                <p>Contract Start: <strong>2024-01-01</strong></p>
                                <p>Contract End: <strong>2025-01-01</strong></p>
                            </div>
                            <div class="col-md-6 text-end">
                                <h5>Status: <span class="status-badge status-occupied">Occupied</span></h5>
                            </div>
                        </div>

                        <!-- Payment History Section -->
                        <div class="section-title">Payment History</div>
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Date</th>
                                    <th>Amount</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>2024-01-05</td>
                                    <td>$500</td>
                                    <td>Paid</td>
                                    <td><button class="btn btn-info btn-sm">Download Receipt</button></td>
                                </tr>
                                <tr>
                                    <td>2024-02-05</td>
                                    <td>$500</td>
                                    <td>Paid</td>
                                    <td><button class="btn btn-info btn-sm">Download Receipt</button></td>
                                </tr>
                            </tbody>
                        </table>

                        <!-- Maintenance Request Section -->
                        <div class="section-title">Maintenance Requests</div>
                        <ul class="list-group">
                            <li class="list-group-item">
                                <strong>Issue:</strong> Leaky Faucet
                                <span class="badge badge-pill status-badge status-maintenance float-end">Resolved</span>
                            </li>
                            <li class="list-group-item">
                                <strong>Issue:</strong> No Hot Water
                                <span class="badge badge-pill status-badge status-maintenance float-end">Pending</span>
                            </li>
                        </ul>

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

    <%@ include file="/views/common/footer.jsp" %>
</body>
</html>
