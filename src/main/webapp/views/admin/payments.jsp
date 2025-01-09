<%@ page import="java.util.List" %>
<%@ page import="model.Resident" %>
<%@ page import="model.Payment" %>
<%@ page import="jakarta.servlet.*, jakarta.servlet.http.*, java.io.*, java.util.*, java.sql.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<%
    String currentPage = "payments";  // or any dynamic value
    request.setAttribute("currentPage", currentPage);
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>Manage Payments</title>
    <%@ include file="/views/common/headadminlinks.jsp" %>
</head>

<body>
    <%@ include file="/views/common/headeradmin.jsp" %>
    <%@ include file="/views/common/asideadmin.jsp" %>

    <!-- Main content -->
    <main class="main" id="main">
        <div class="pagetitle">
            <h1>Manage Payments</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Dashboard</a></li>
                    <li class="breadcrumb-item active">Payments</li>
                </ol>
            </nav>
        </div>
        <section>
            <div class="row">


                <div class="col-sm-4 col-md-4">
                    <div class="col-lg-12">
                        <div class="card_1" id="paymentStatusBox" >
                            <div class="card_1-header text-center">
                                <h4 class="card_1-title">Payment Status for Current Month</h4>
                            </div>
                            <div class="card_1-body">
                                <!-- Dynamic content for payment status -->
                                <div id="paymentMessage" class="alert" role="alert">
                                    <!-- This message will change based on whether payments are generated or not -->
                                    Payments have been <strong>generated</strong> for this month.
                                </div>

                                <!-- Button to trigger action (for generating payments if not yet done) -->
                                <button id="generatePaymentButton" class="btn1 submit_btn w-100" onclick="generatePayment()">Generate Payments</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-sm-4 col-md-4">
                    <div class="card info-card overdue-card">
                        <div class="card-body">
                            <h5 class="card-title">Payments</h5>
                            <div class="d-flex align-items-center">
                                <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                    <i class="bi bi-hourglass-bottom"></i>
                                </div>
                                <div class="ps-3">
                                    <h6>${total_payments}</h6>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


            </div>

            <!-- Overdue Payments -->
            <div class="row justify-content-center">
                <div class="col-lg-11">
                    <div class="card_1">
                        <div class="card_1-body">
                            <h5 class="card_1-title">Overdue</h5>
                            <div class="card_1-header" style="display: flex;">
                                <input class="form-control" type="text" id="filterInput" placeholder="Search..." style="width:45%;min-width:150px;">
                            </div>
                            <div class="table-wrap">
                                <table class="table2 table-striped table-hover table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Resident Full name</th>
                                            <th>Resident Email</th>
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
                                                        <td><%= data.getFullname() %></td>
                                                        <td><%= data.getEmail() %></td>
                                                        <td><%= data.getPaymentId() %></td>
                                                        <td><%= data.getRoomId() %></td>
                                                        <td><%= data.getAmountDue() %></td>
                                                        <td><%= data.getAmountPaid() %></td>
                                                        <td><%= data.getDueDate() %></td>
                                                        <td><%= data.getPaymentDate() %></td>
                                                        <td><sapn class="StatusSpan" data-badge='<%= data.getStatus() %>'><%= data.getStatus() %></sapn></td>

                                                        <td>
                                                            <button class="btn btn-warning sendReminderBtn" data-email="<%= data.getEmail() %>">
                                                                <i class="fas fa-bell"></i> Send Reminder
                                                            </button>
                                                            <button class="btn btn-success makePaymentBtn" data-paymentid="<%= data.getPaymentId() %>">
                                                                <i class="bi bi-currency-dollar"></i> Make Payment
                                                            </button>
                                                        </td>
                                                    </tr>
                                        <% } } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Pending Payments -->
                <div class="col-md-11">
                    <div class="card_1">
                        <div class="card_1-body">
                            <h5 class="card_1-title">Pending</h5>
                            <div class="card_1-header" style="display: flex;">
                                <input class="form-control" type="text" id="filterInput" placeholder="Search..." style="width:45%;min-width:150px;">
                            </div>
                            <div class="table-wrap">
                                <table class="table2 table-striped table-hover table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Resident Full name</th>
                                            <th>Resident Email</th>
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
                                        <% List<Payment> P_pending = (List<Payment>) request.getAttribute("P_pending");
                                            if (P_pending != null) {
                                                for (Payment data : P_pending) { %>
                                                    <tr>
                                                        <td><%= data.getFullname() %></td>
                                                        <td><%= data.getEmail() %></td>
                                                        <td><%= data.getPaymentId() %></td>
                                                        <td><%= data.getRoomId() %></td>
                                                        <td><%= data.getAmountDue() %></td>
                                                        <td><%= data.getAmountPaid() %></td>
                                                        <td><%= data.getDueDate() %></td>
                                                        <td><%= data.getPaymentDate() %></td>
                                                        <td><sapn class="StatusSpan" data-badge='<%= data.getStatus() %>'><%= data.getStatus() %></sapn></td>
                                                        <td>
                                                            <button class="btn btn-warning sendReminderBtn" data-email="<%= data.getEmail() %>">
                                                                <i class="fas fa-bell"></i> Send Reminder
                                                            </button>
                                                            <button class="btn btn-success makePaymentBtn" data-paymentid="<%= data.getPaymentId() %>">
                                                                <i class="bi bi-currency-dollar"></i> Make Payment
                                                            </button>
                                                        </td>
                                                    </tr>
                                        <% } } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Paid Payments -->
                <div class="col-md-11">
                    <div class="card_1">
                        <div class="card_1-body">
                            <h5 class="card_1-title">Paid</h5>
                            <div class="card_1-header" style="display: flex;">
                                <input class="form-control" type="text" id="filterInput" placeholder="Search..." style="width:45%;min-width:150px;">
                            </div>
                            <div class="table-wrap">
                                <table class="table2 table-striped table-hover table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Full name</th>
                                            <th>Email</th>
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
                                        <% List<Payment> P_paid = (List<Payment>) request.getAttribute("P_paid");
                                            if (P_paid != null) {
                                                for (Payment data : P_paid) { %>
                                                    <tr>
                                                        <td><%= data.getFullname() %></td>
                                                        <td><%= data.getEmail() %></td>
                                                        <td><%= data.getPaymentId() %></td>
                                                        <td><%= data.getRoomId() %></td>
                                                        <td><%= data.getAmountDue() %></td>
                                                        <td><%= data.getAmountPaid() %></td>
                                                        <td><%= data.getDueDate() %></td>
                                                        <td><%= data.getPaymentDate() %></td>
                                                        <td><sapn class="StatusSpan" data-badge='<%= data.getStatus() %>'><%= data.getStatus() %></sapn></td>
                                                        <td>

                                                            <a class="btn btn-info" href="<%= request.getContextPath() %>/downloadReceipt?paymentId=<%= data.getPaymentId() %>" class="btn btn-success">
                                                                <i class="bi bi-file-earmark-pdf"></i> Download Receipt
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

    <script src="${pageContext.request.contextPath}/component/js/tools/jquery-3.3.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/component/js/script.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
        var contextPath = "${pageContext.request.contextPath}";

        $(document).ready(function() {

            // Function to handle Send Reminder request
            $(document).on('click', '.sendReminderBtn', function() {
                var email = $(this).data('email');
                $.ajax({
                    url: contextPath + '/admin-api/SendPaymentReminder',  // Endpoint for sending reminder
                    method: 'POST',
                    data: { email: email },
                    dataType: 'json',
                    success: function(response) {
                        if (response.messageType === "success") {
                            Swal.fire({
                                icon: 'success',
                                title: 'Reminder Sent!',
                                text: response.message,
                                showConfirmButton: false,
                                timer: 3000
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: response.message,
                                confirmButtonText: 'Try Again'
                            });
                        }
                    },
                    error: function() {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'An error occurred. Please try again later.',
                            confirmButtonText: 'OK'
                        });
                    }
                });
            });

            // Function to handle Make Payment request with confirmation
            $(document).on('click', '.makePaymentBtn', function() {
                var paymentId = $(this).data('paymentid');

                // Show confirmation dialog before proceeding with the payment
                Swal.fire({
                    title: 'Are you sure?',
                    text: "Do you want to proceed with the payment?",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonText: 'Yes, make payment',
                    cancelButtonText: 'No, cancel',
                    reverseButtons: true
                }).then((result) => {
                    if (result.isConfirmed) {
                        // Proceed with the payment if admin confirms
                        $.ajax({
                            url: contextPath + '/admin-api/MakePayments',  // Endpoint for making payment
                            method: 'POST',
                            data: { paymentID: paymentId },
                            dataType: 'json',
                            success: function(response) {
                                if (response.messageType === "success") {
                                    Swal.fire({
                                        icon: 'success',
                                        title: 'Payment Successful!',
                                        text: response.message,
                                        showConfirmButton: false,
                                        timer: 3000
                                    });
                                } else {
                                    Swal.fire({
                                        icon: 'error',
                                        title: 'Payment Error',
                                        text: response.message,
                                        confirmButtonText: 'Try Again'
                                    });
                                }
                            },
                            error: function() {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Error',
                                    text: 'An error occurred. Please try again later.',
                                    confirmButtonText: 'OK'
                                });
                            }
                        });
                    } else {
                        // Handle cancel action (optional)
                        Swal.fire({
                            icon: 'info',
                            title: 'Payment Cancelled',
                            text: 'The payment has not been processed.',
                            showConfirmButton: false,
                            timer: 2000
                        });
                    }
                });
            });

        });
    </script>

    <script>
        let paymentsGenerated = ${isPaymentsGeneratedForCurrentMonth}; // Change this value dynamically based on your backend logic
        function checkPaymentStatus() {
            const paymentMessageElement = document.getElementById('paymentMessage');
            const generatePaymentButton = document.getElementById('generatePaymentButton');

            if (paymentsGenerated) {
                // Payments have been generated
                paymentMessageElement.innerHTML = 'Payments have already <strong>been generated</strong> for this month.';
                paymentMessageElement.classList.add('alert-success');
                paymentMessageElement.classList.remove('alert-danger');
                generatePaymentButton.style.display = 'none'; // Hide the button
            } else {
                // Payments have not been generated
                paymentMessageElement.innerHTML = 'Payments have <strong>not yet been generated</strong> for this month.';
                paymentMessageElement.classList.add('alert-danger');
                paymentMessageElement.classList.remove('alert-success');
                generatePaymentButton.style.display = 'block'; // Show the button
            }
        }

        // AJAX call to generate payments
        function generatePayment() {
           $.ajax({
                url: contextPath + '/admin-api/generateMonthlyPayments',  // Endpoint for making payment
                method: 'POST',
                data: { paymentID: "paymentId" },
                dataType: 'json',
                success: function(response) {
                    if (response.success) {
                        paymentsGenerated = true;
                        checkPaymentStatus();
                    } else {
                        alert('An error occurred while generating payments.');
                    }
                },
                error: function(xhr, status, error) {

                    alert('There was an error processing your request. Check the console for details.');
                }
            });
        }

        // Initially check payment status
        checkPaymentStatus();
    </script>





    <script>
        $(document).on('click', '.downloadReceiptBtn', function() {
            var paymentId = $(this).data('paymentid');
            var downloadUrl = '/downloadReceipt?paymentId=' + paymentId;

            window.location.href = downloadUrl; // This will start the download
        });
    </script>

</body>

</html>
