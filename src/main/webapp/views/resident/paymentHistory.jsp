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
    <title>Payment History</title>
    <%@ include file="/views/common/headerlinks.jsp" %>
</head>
<body>

    <%@ include file="/views/common/headerresident.jsp" %>



    <main class=" mt-5 u_main">
        <div class="row justify-content-center">
            <div class="col-lg-12">
                <div class="card-header text-center">
                    <h1>Payment History</h1>
                </div>
                <!-- Dashboard Card -->
                <div class="card-body">
                    <div class="section-title"><span class="StatusSpan" data-badge='overdue'>Overdue</span></div>
                    <div class="table_container">
                        <table class="table table-striped table-hover" style="overflow-x: auto; width: 100%; max-width: 100%;">
                            <thead>
                                <tr>
                                    <th>Payment ID</th>
                                    <th>Room ID</th>
                                    <th>Amount Due</th>
                                    <th>Amount Paid</th>
                                    <th>Due Date</th>
                                    <th>Payment Date</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% List<Payment> P_overdue = (List<Payment>) request.getAttribute("P_overdue");
                                    if (P_overdue != null) {
                                        for (Payment data : P_overdue) { %>
                                            <tr>
                                                <td><%= data.getPaymentId() %></td>
                                                <td><%= data.getRoomId() %></td>
                                                <td><%= data.getAmountDue() %></td>
                                                <td><%= data.getAmountPaid() %></td>
                                                <td><%= data.getDueDate() %></td>
                                                <td><%= data.getPaymentDate() %></td>
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
                    </div>


                    <div class="section-title"><span class="StatusSpan" data-badge='pending'>Pending</span></div>
                    <div class="table_container">
                        <table class="table table-striped table-hover" style="overflow-x: auto; width: 100%; max-width: 100%;">
                        <thead>
                                <tr>
                                    <th>Payment ID</th>
                                    <th>Room ID</th>
                                    <th>Amount Due</th>
                                    <th>Amount Paid</th>
                                    <th>Due Date</th>
                                    <th>Payment Date</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% List<Payment> P_pending = (List<Payment>) request.getAttribute("P_pending");;
                                    if (P_pending != null) {
                                        for (Payment data : P_pending) { %>
                                            <tr>
                                                <td><%= data.getPaymentId() %></td>
                                                <td><%= data.getRoomId() %></td>
                                                <td><%= data.getAmountDue() %></td>
                                                <td><%= data.getAmountPaid() %></td>
                                                <td><%= data.getDueDate() %></td>
                                                <td><%= data.getPaymentDate() %></td>
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
                    </div>

                    <div class="section-title"><span class="StatusSpan" data-badge='paid'>Paid</span></div>
                    <div class="table_container">
                        <table class="table table-striped table-hover" style="overflow-x: auto; width: 100%; max-width: 100%;">
                            <thead>
                                <tr>
                                    <th>Payment ID</th>
                                    <th>Room ID</th>
                                    <th>Amount Due</th>
                                    <th>Amount Paid</th>
                                    <th>Due Date</th>
                                    <th>Payment Date</th>
                                    <th>Status</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% List<Payment> P_paid = (List<Payment>) request.getAttribute("P_paid");
                                    if (P_paid != null) {
                                        for (Payment data : P_paid) { %>
                                            <tr>

                                                <td><%= data.getPaymentId() %></td>
                                                <td><%= data.getRoomId() %></td>
                                                <td><%= data.getAmountDue() %></td>
                                                <td><%= data.getAmountPaid() %></td>
                                                <td><%= data.getDueDate() %></td>
                                                <td><%= data.getPaymentDate() %></td>
                                                <td><span class="StatusSpan" data-badge='<%= data.getStatus() %>'><%= data.getStatus() %></span></td>
                                                <td>
                                                    <a class="btn btn_eye " href="<%= request.getContextPath() %>/downloadReceipt?paymentId=<%= data.getPaymentId() %>" >
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
