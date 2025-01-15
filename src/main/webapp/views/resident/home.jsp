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
                                <h5>Status: <span class="StatusSpanReverse" data-badge='${room.getState()}'> ${room.getState()} </span></h5>
                            </div>
                        </div>

                        <!-- Payment History Section -->
                        <div class="section-title">Payment History</div>
                        <div class="table_container">
                        <%   List<Payment> P_overdue = (List<Payment>) request.getAttribute("P_overdue");
                            List<Payment> P_pending = (List<Payment>) request.getAttribute("P_pending");
                            if (P_overdue != null) { %>

                                <table class="table table-striped table-hover" style="overflow-x: auto; width: 100%; max-width: 100%;">
                                    <thead>
                                        <tr>
                                            <th>Payment ID</th>
                                            <th>Room ID</th>
                                            <th>Amount Due</th>
                                            <th>Amount Paid</th>
                                            <th>Due Date</th>
                                            <th>Status</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% if (P_overdue != null) {
                                                for (Payment data : P_overdue) { %>
                                                    <tr>
                                                        <td><%= data.getPaymentId() %></td>
                                                        <td><%= data.getRoomId() %></td>
                                                        <td><%= data.getAmountDue() %></td>
                                                        <td><%= data.getAmountPaid() %></td>
                                                        <td><%= data.getDueDate() %></td>
                                                        <td><span class="StatusSpan" data-badge='<%= data.getStatus() %>'><%= data.getStatus() %></span></td>
                                                        <td>
                                                            <button class="btn btn-success makePaymentBtn" data-paymentid="<%= data.getPaymentId() %>">
                                                                <i class="bi bi-currency-dollar"></i> Make Payment
                                                            </button>
                                                        </td>
                                                    </tr>
                                        <% } } %>

                                        <% if (P_pending != null) {
                                                for (Payment data : P_pending) { %>
                                                    <tr>
                                                        <td><%= data.getPaymentId() %></td>
                                                        <td><%= data.getRoomId() %></td>
                                                        <td><%= data.getAmountDue() %></td>
                                                        <td><%= data.getAmountPaid() %></td>
                                                        <td><%= data.getDueDate() %></td>
                                                        <td><span class="StatusSpan" data-badge='<%= data.getStatus() %>'><%= data.getStatus() %></span></td>
                                                        <td>
                                                            <button class="btn btn-success makePaymentBtn" data-paymentid="<%= data.getPaymentId() %>">
                                                                <i class="bi bi-currency-dollar"></i> Make Payment
                                                            </button>
                                                        </td>
                                                    </tr>
                                        <% } } %>
                                    </tbody>
                                </table>

                              <%  } %>

                            <!-- Show More Button -->
                            <div class="text-center">
                                <a id="show-more-btn" class="btn_1" href="${pageContext.request.contextPath}/u/payment_history">Show History</a>
                            </div>
                        </div>




                        <!-- Maintenance Request Section -->
                        <div class="section-title">Maintenance Requests
                            <a id="show-more-btn" class="btn_1" href="${pageContext.request.contextPath}/u/make_request?roomId=${room.getRoomId()}">Make Request</a>
                        </div>
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

    <script>
        $(document).on('click', '.makePaymentBtn', function() {
            var paymentId = $(this).data('paymentid');
            location.href = "<%= request.getContextPath() %>/u/make_payment?paymentId="+paymentId;
        });
    </script>
    <%@ include file="/views/common/footer.jsp" %>
</body>
</html>
