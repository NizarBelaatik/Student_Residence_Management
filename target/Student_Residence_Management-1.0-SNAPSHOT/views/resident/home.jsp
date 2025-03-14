<%-- 
    Document   : index
    Created on : Dec 11, 2024, 4:46:56 PM
    Author     : night
--%>

<%@ page session="true" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.*,jakarta.servlet.http.*,java.io.*,java.util.*,java.sql.*"%><!DOCTYPE html>
<%@ page import="model.Payment" %>
<html>
<head>
    <title>Home</title>
    <%@ include file="/views/common/headerresidentlinks.jsp" %>
</head>
<body>

    <%@ include file="/views/common/headerresident.jsp" %>



    <main class=" mt-5 u_main">
        <div class="row justify-content-center">
            <div class="col-lg-12">

                <!-- Dashboard Card -->
                <div class="card dashboard-card">
                    <div class="card-header text-center">
                        <h1>Welcome, ${resident.getFullname()}</h1>
                        <p>Resident of Room ${room.getRoomName()}</p>
                    </div>
                    <div class="card-body">

                        <!-- Room Status Section -->
                        <div class="section-title">Room Status</div>
                        <div class="row">
                            <div class="col-md-6">
                                <h5>Room Size: ${room.getSize()}</h5>
                                <p>Contract Start: <strong>${resident.getCStartDate()}</strong></p>
                                <p>Contract End: <strong>${resident.getCEndDate()}</strong></p>
                            </div>
                            <div class="col-md-6 text-end">
                                <h5>Status: <sapn class="StatusSpanReverse" data-badge='${room.getState()}'> ${room.getState()} </sapn></h5>
                            </div>
                        </div>

                        <!-- Payment History Section -->
                        <div class="section-title">Payment History</div>
                        <div class="table_container">
                            <table class="table table-striped" style="overflow-x: auto; width: 100%; max-width: 100%;">
                                <thead>
                                    <tr>
                                        <th>Payment ID</th>
                                        <th>Room ID</th>
                                        <th>Amount Due</th>
                                        <th>Amount Paid</th>
                                        <th>Due Date</th>
                                        <th>Payment Date</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% List<Payment> P = (List<Payment>) request.getAttribute("P_overdue");
                                        if (P != null) {
                                            for (Payment data : P) { %>
                                                <tr>
                                                    <td><%= data.getPaymentId() %></td>
                                                    <td><%= data.getRoomId() %></td>
                                                    <td><%= data.getAmountDue() %></td>
                                                    <td><%= data.getAmountPaid() %></td>
                                                    <td><%= data.getDueDate() %></td>
                                                    <td><%= data.getPaymentDate() %></td>
                                                    <td><sapn class="StatusSpan" data-badge='<%= data.getStatus() %>'><%= data.getStatus() %></sapn></td>

                                                </tr>
                                    <% } } %>

                                    <% List<Payment> P_pending = (List<Payment>) request.getAttribute("P_pending");
                                        if (P_pending != null) {
                                            for (Payment data : P_pending) { %>
                                                <tr>
                                                    <td><%= data.getPaymentId() %></td>
                                                    <td><%= data.getRoomId() %></td>
                                                    <td><%= data.getAmountDue() %></td>
                                                    <td><%= data.getAmountPaid() %></td>
                                                    <td><%= data.getDueDate() %></td>
                                                    <td><%= data.getPaymentDate() %></td>
                                                    <td><sapn class="StatusSpan" data-badge='<%= data.getStatus() %>'><%= data.getStatus() %></sapn></td>

                                                </tr>
                                    <% } } %>
                                </tbody>


                            </table>
                             <!-- Show More Button -->
                                <div class="text-center">
                                    <a id="show-more-btn" class="btn_1" href="${pageContext.request.contextPath}/u/payment_history">Show More</a>
                                </div>
                        </div>




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
    </main>

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
