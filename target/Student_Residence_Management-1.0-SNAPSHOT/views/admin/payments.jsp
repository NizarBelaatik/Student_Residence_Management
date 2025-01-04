<%
    String currentPage = "payments";  // or any dynamic value
    request.setAttribute("currentPage", currentPage);
%>

<%@ page import="java.util.List" %>
<%@ page import="model.Resident" %>
<%@ page import="model.Payment" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.*,jakarta.servlet.http.*,java.io.*,java.util.*,java.sql.*"%>

<!DOCTYPE html>
<html>
    <head>

        <title>Manage Rooms</title>
        <%@ include file="/views/common/headadminlinks.jsp" %>


    </head>
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

            <div class="row justify-content-center">

                <div class="col-md-10">
                    <div class="card_1">
                        <div class="card_1-body">
                            <h5 class="card_1-title">Overdue</h5>
                            <div class="card_1-header" style="display: flex;">
                                <input class="form-control" type="text" id="filterInput" placeholder="Search..." style="width:45%;min-width:150px;">
                            </div>
                            <div class="table-wrap">
                                <table class="table2 table-striped table-hover table-bordered" >
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
                                        <th>action</th>
                                      </tr>
                                    </thead>
                                    <tbody>
                                        <%List<Payment> P_overdue = (List<Payment>) request.getAttribute("P_overdue");
                                            for (Payment data : P_overdue) {%>
                                            <tr>
                                                <form id="sendReminder" method="post" action="${pageContext.request.contextPath}/SendPaymentReminder">
                                                <input type="hidden" name="email" value="<%= data.getEmail() %>">
                                                  <th scope="row"><%= data.getFullname() %></th>
                                                  <td><%= data.getEmail() %></td>
                                                  <td><%= data.getPaymentId() %></td>
                                                  <td><%= data.getRoomId() %></td>
                                                  <td><%= data.getAmountDue() %></td>
                                                  <td><%= data.getAmountPaid() %></td>
                                                  <td><%= data.getDueDate() %></td>
                                                  <td><%= data.getPaymentDate() %></td>
                                                  <td><%= data.getStatus() %></td>
                                                  <td><button type="submit" class="btn btn-warning" style="display: flex; align-items: center;">
                                                        <i class="fas fa-bell" style="margin-right: 8px;"></i> Send Reminder
                                                      </button>
</td>
                                              </form>
                                            </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-10">
                    <div class="card_1">
                        <div class="card_1-body">
                            <h5 class="card_1-title">Paid</h5>
                            <div class="card_1-header" style="display: flex;">
                                <input class="form-control" type="text" id="filterInput" placeholder="Search..." style="width:45%;min-width:150px;">
                            </div>
                            <div class="table-wrap">
                                <table class="table2 table-striped table-hover table-bordered" >
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
                                        <%List<Payment> P_paid = (List<Payment>) request.getAttribute("P_paid");
                                            for (Payment data : P_paid) {%>
                                            <tr>
                                              <th scope="row"><%= data.getFullname() %></th>
                                              <td><%= data.getEmail() %></td>
                                              <td><%= data.getPaymentId() %></td>
                                              <td><%= data.getRoomId() %></td>
                                              <td><%= data.getAmountDue() %></td>
                                              <td><%= data.getAmountPaid() %></td>
                                              <td><%= data.getDueDate() %></td>
                                              <td><%= data.getPaymentDate() %></td>
                                              <td><%= data.getStatus() %></td>
                                            </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="col-md-10">
                    <div class="card_1">
                        <div class="card_1-body">
                            <h5 class="card_1-title">Pending</h5>
                            <div class="card_1-header" style="display: flex;">
                                <input class="form-control" type="text" id="filterInput" placeholder="Search..." style="width:45%;min-width:150px;">
                            </div>
                            <div class="table-wrap">
                                <table class="table2 table-striped table-hover table-bordered" >
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
                                        <%List<Payment> P_pending = (List<Payment>) request.getAttribute("P_pending");
                                            for (Payment data : P_pending) {%>
                                            <tr>
                                              <th scope="row"><%= data.getFullname() %></th>
                                              <td><%= data.getEmail() %></td>
                                              <td><%= data.getPaymentId() %></td>
                                              <td><%= data.getRoomId() %></td>
                                              <td><%= data.getAmountDue() %></td>
                                              <td><%= data.getAmountPaid() %></td>
                                              <td><%= data.getDueDate() %></td>
                                              <td><%= data.getPaymentDate() %></td>
                                              <td><%= data.getStatus() %></td>
                                            </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>



            </div>

        </section>

        <script>
                var contextPath = "${pageContext.request.contextPath}";
                $(document).ready(function() {
                    // Handle form submission
                    $('#sendReminder').submit(function(e) {
                        e.preventDefault(); // Prevent default form submission

                        // Perform AJAX request
                        $.ajax({
                            url: contextPath+'/SendPaymentReminder', // The servlet URL
                            method: 'POST',
                            data: $(this).serialize(), // Serialize the form data
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

        <script src="${pageContext.request.contextPath}/component/js/tools/jquery-3.3.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/component/js/script.js"></script>
    </body>
</html>
