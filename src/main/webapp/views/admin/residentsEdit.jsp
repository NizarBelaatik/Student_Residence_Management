

<%
    String currentPage = "residents";  // or any dynamic value
    request.setAttribute("currentPage", currentPage);
%>
<%@ page import="java.util.List" %>
<%@ page import="model.Resident" %>
<%@ page import="model.Payment" %>
<%@ page import="model.Room" %>
<%@ page import="jakarta.servlet.*, jakarta.servlet.http.*, java.io.*, java.util.*, java.sql.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>


<!DOCTYPE html>
<html>
<head>
    <title>View Resident : ${Res.getFullname()}</title>
    
    <%@ include file="/views/common/headeradminlinks.jsp" %>
    <style>

        .table_container ,.table_container table{position:relative; overflow-x:auto;width: 100%; max-width: 100%;}

    </style>
</head>
<body>
    <%@ include file="/views/common/headeradmin.jsp" %>
    <%@ include file="/views/common/asideadmin.jsp" %>

    <!-- Main content -->
    <main class="main" id="main">
        <div class="pagetitle">
            <h1>Manage Residents</h1>
            <nav>
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Dashboard</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/residents">Residents</a></li>
                <li class="breadcrumb-item active">Edit</li>
              </ol>
            </nav>
        </div>
        <section>
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card_1">
                        <div class="card_1-body">
                            <div class="card_1-header">
                                <h5>Edit Residents | ${Res.getEmail()}</h5>
                            </div>

                            <form id="editResidentForm" method="post" action="${pageContext.request.contextPath}/admin/Residents/view">

                                <input type="hidden" class="form-control" name="inputemail" value="${Res.getEmail()}" required>

                                <div class="row mb-3">
                                  <label for="inputEmail3" class="col-sm-2 col-form-label">First name</label>
                                  <div class="col-sm-10">
                                    <input type="text" class="form-control" name="inputfirstname" value="${Res.getFirstname()}" required>
                                  </div>
                                </div>
                                
                                <div class="row mb-3">
                                  <label for="inputEmail3" class="col-sm-2 col-form-label">Firs last</label>
                                  <div class="col-sm-10">
                                    <input type="text" class="form-control" name="inputlastname" value="${Res.getLastname()}" required>
                                  </div>
                                </div>
                                
                               
                                
                                <div class="row mb-3">
                                    <label for="inputState" class="col-sm-2 col-form-label">Gender</label>
                                    <div class="col-sm-10">
                                    <select name="inputgender" class="form-select" required>
                                        <option value="male" ${Res.getGender() == 'male' ? 'selected' : ''}>Male</option>
                                        <option value="female" ${Res.getGender() == 'female' ? 'selected' : ''}>Female</option>
                                    </select>
                                  </div>
                                </div>

                                 <div class="row mb-3">
                                  <label for="inputEmail3" class="col-sm-2 col-form-label">Phone</label>
                                  <div class="col-sm-10">
                                    <input type="text" class="form-control" name="inputphone"  value="${Res.getPhone()}"required>
                                  </div>
                                </div>
                                
                                <div class="row mb-3">
                                  <label for="inputEmail3" class="col-sm-2 col-form-label">Address</label>
                                  <div class="col-sm-10">
                                    <input type="text" class="form-control" name="inputaddress" value="${Res.getAddress()}" required>
                                  </div>
                                </div>
                                


                                <div class="row mb-3">
                                    <label for="inputroomId" class="col-sm-2 col-form-label">Room</label>
                                    <div class="col-sm-10">
                                        <%
                                            Resident res = (Resident) request.getAttribute("Res");

                                            String selectedRoomId = res.getRoomId();
                                            // Retrieve the list of rooms from the request
                                            List<Room> roomList = (List<Room>) request.getAttribute("roomList");
                                        %>
                                        <select name="inputroomId" class="form-select" required>
                                            <option value="" disabled selected>Select Room</option>
                                            <%
                                                // Iterate over the room list and create the option tags
                                                for (Room room : roomList) {
                                            %>
                                                <option value="<%= room.getRoomId() %>" <%= (room.getRoomId().equals(selectedRoomId)) ? "selected" : "" %> >
                                                    ID:<%= room.getRoomId() %> | Name:<%= room.getRoomName() %> | Size:<%= room.getSize() %> | Price:<%= room.getPrice() %>
                                                </option>
                                            <%
                                                }
                                            %>
                                        </select>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <label for="inputDate" class="col-sm-2 col-form-label">Start Date</label>
                                    <div class="col-sm-3">
                                        <input type="date" class="form-control" name="inputStartDate" value="${Res.getCStartDate()}">
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <label for="inputDate" class="col-sm-2 col-form-label">End Date</label>
                                    <div class="col-sm-3">
                                        <input type="date" class="form-control" name="inputEndDate" value="${Res.getCEndDate()}">
                                    </div>
                                </div>


                                <div class="text-center">
                                  <button type="submit" class="btn1 submit_btn">Submit</button>
                                  <button type="reset" class="btn1 cancle_btn">Reset</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>


            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="card_1">
                        <div class="card_1-body">
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

    <script>
        var contextPath = "${pageContext.request.contextPath}";
        var csrfToken = $("meta[name='csrf-token']").attr("content");
        $(document).ready(function() {
            // Handle form submission
            $('#editResidentForm').submit(function(e) {
                e.preventDefault(); // Prevent default form submission
                
                // Perform AJAX request
                $.ajax({
                    url: contextPath+'/admin/residents/view', // The servlet URL
                    method: 'POST',
                    data: $(this).serialize(), // Serialize the form data
                    headers: {'X-CSRF-Token': csrfToken},

                    dataType: 'json', // Expect a JSON response
                    success: function(response) {
                        // Handle successful form submission (response will contain messageType and message)
                        if (response.messageType === "success") {
                            Swal.fire({
                                icon: 'success',
                                title: 'Success!',
                                text: response.message,
                                showConfirmButton: false,
                                timer: 3000
                            }).then(() => {
                                $('#addRoomForm')[0].reset(); // Reset the form after success
                            });
                        } else if (response.messageType === "error") {
                            Swal.fire({
                                icon: 'error',
                                title: 'Oops...',
                                text: response.message,
                                confirmButtonText: 'Try Again'
                            });
                        }
                    },
                    error: function(xhr, status, error) {
                        // Handle AJAX errors
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'An error occurred while processing your request. Please try again later.',
                            confirmButtonText: 'OK'
                        });
                    }
                });
            });
        });
    </script>


     <script>
             var contextPath = "${pageContext.request.contextPath}";
             var csrfToken = $("meta[name='csrf-token']").attr("content");
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
    <script src="${pageContext.request.contextPath}/component/js/tools/jquery-3.3.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/component/js/script.js"></script>

    <%@ include file="/views/common/footer.jsp" %>
</body>
</html>
