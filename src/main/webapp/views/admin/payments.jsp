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

            <div class="row">
                <div class="col-lg-6">
                    <div class="card_1">
                        <div class="card_1-body">
                            <h5 class="card_1-title">Payments for this month</h5>
                            <div class="card_1-header" style="display: flex;">

                                <input class="form-control" type="text" id="filterInput" placeholder="Search..." style="width:45%;min-width:150px;">
                            </div>
                            <div class="table-wrap">

                                <table class="table2 table-striped table-hover table-bordered" >
                                    <thead>
                                      <tr>
                                        <th>Email</th>
                                        <th>First name</th>
                                        <th>Last name</th>
                                        <th>Gender</th>
                                        <th>Phone</th>
                                        <th>Room Id</th>
                                        <th>Contract Start Date</th>
                                        <th>Contract End Date</th>
                                      </tr>
                                    </thead>
                                    <tbody>


                                        <% List<Resident> residentList = (List<Resident>) request.getAttribute("residentList");
                                            for (Resident data : residentList) {%>

                                            <tr>
                                              <th scope="row"><%= data.getEmail() %></th>
                                              <td><%= data.getFirstname() %></td>
                                              <td><%= data.getLastname() %></td>
                                              <td><%= data.getGender() %></td>
                                              <td><%= data.getPhone() %></td>
                                              <td><%= data.getRoomId() %></td>
                                              <td><%= data.getCStartDate() %></td>
                                              <td><%= data.getCEndDate() %></td>


                                            </tr>

                                        <% } %>



                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
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
                                        <%List<Payment> P_overdue = (List<Payment>) request.getAttribute("P_overdue");
                                            for (Payment data : P_overdue) {%>
                                            <tr>
                                              <th scope="row"><%= data.getEmail() %></th>
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

                <div class="col-lg-6">
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
                                              <th scope="row"><%= data.getEmail() %></th>
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


                <div class="col-lg-6">
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
                                              <th scope="row"><%= data.getEmail() %></th>
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



        <script src="${pageContext.request.contextPath}/component/js/tools/jquery-3.3.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/component/js/script.js"></script>
    </body>
</html>
