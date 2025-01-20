<%-- 
    Document   : dashboard
    Created on : Dec 11, 2024, 4:27:26 PM
    Author     : night
--%>
<%@ page import="model.Payment" %>
<%@ page import="model.MaintenanceRequests" %>
<%@ page import="java.util.List" %>
<%@ page import="jakarta.servlet.*, jakarta.servlet.http.*, java.io.*, java.util.*, java.sql.*" %>

<%
    String currentPage = "dashboard";  // or any dynamic value
    request.setAttribute("currentPage", currentPage);
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Dashboard</title>

        <%@ include file="/views/common/headeradminlinks.jsp" %>
        <!-- Include Chart.js library -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    </head>
    <body>
        
    <%@ include file="/views/common/headeradmin.jsp" %>
    <%@ include file="/views/common/asideadmin.jsp" %>

    <!-- Main content -->
    <main class="main" id="main">
        <div class="pagetitle">
            <h1>Dashboard</h1>
            <nav>
              <ol class="breadcrumb">
                <li class="breadcrumb-item active"><a href="${pageContext.request.contextPath}/admin">Dashboard</a></li>
              </ol>
            </nav>
        </div>
        <section class="section dashboard">
            <div class="col-12">
                <div class="row">
                    <div class="col-lg-12">

                        <div class="row">

                            <!-- Available Card -->
                            <div class="col-lg-4 col-md-4">
                                <div class="card_container available">
                                    <i class="bi bi-house card_icon"></i>
                                    <div class="card_text">Available Room</div>
                                    <div class="card_number">${available_rooms}</div>
                                </div>
                            </div>

                            <!-- Occupied Card -->
                            <div class="col-lg-4 col-md-4">
                                <div class="card_container occupied">
                                    <i class="bi bi-house-fill card_icon"></i>
                                    <div class="card_text">Occupied Room</div>
                                    <div class="card_number">${occupied_rooms}</div>
                                </div>
                            </div>

                            <!-- Maintenance Card -->
                            <div class="col-lg-4 col-md-4">
                                <div class="card_container maintenance">
                                    <i class="bi bi-house-gear-fill card_icon"></i>
                                    <div class="card_text">Room in Maintenance</div>
                                    <div class="card_number">${maintenance_rooms}</div>
                                </div>
                            </div>

                        </div>



                        <div class="row">
                            <div class="col-lg-4 col-md-4">
                                <div class="card_container overdue">
                                    <i class="bi bi-hourglass-bottom card_icon"></i>
                                    <div class="card_text">Payments |<span> Overdue</span></div>
                                    <div class="card_number">${overdue}</div>
                                    <div class="card_subtext">${total_payments_overdue}</div>
                                </div>
                            </div>


                            <div class="col-lg-4 col-md-4">
                                <div class="card_container paid">
                                    <i class="bi bi-currency-dollar card_icon"></i>
                                    <div class="card_text">Payments |<span> Paid</span></div>
                                    <div class="card_number">${paid}</div>
                                    <div class="card_subtext">${total_payments_paid}</div>
                                </div>
                            </div>

                            <div class="col-lg-4 col-md-4">
                                <div class="card_container pending">
                                    <i class="bi bi-clock-history card_icon"></i>
                                    <div class="card_text">Payments |<span> Pending</span></div>
                                    <div class="card_number">${pending}</div>
                                    <div class="card_subtext">${total_payments_pending}</div>
                                </div>
                            </div>


                        </div>

                    </div>




                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="card_1">
                                    <div class="card_1-body">
                                        <h5 class="card_1-title">Payments for last 30 days</h5>
                                        <canvas id="paymentChart" ></canvas>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="card_1">
                                    <div class="card_1-body">
                                        <div class="card_1-header" style="display: flex;    justify-content: space-between;">
                                            <h5 class="card_1-title">Recent Payments</h5>
                                            <a class="btn_1 " href="${pageContext.request.contextPath}/admin/payments" style="margin-top:auto;margin-bottom:auto;">Show More</a>
                                        </div>
                                        <div class="table-wrap">
                                            <table class="table2 table-striped table-hover table-bordered">
                                                <thead>
                                                    <tr>
                                                        <th>Resident Full name</th>
                                                        <th>Payment ID</th>
                                                        <th>Due Date</th>
                                                        <th>Payment Date</th>
                                                        <th>Status</th>

                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <% List<Payment> paymentsN = (List<Payment>) request.getAttribute("paymentsN");
                                                        if (paymentsN != null) {
                                                            for (Payment data : paymentsN) { %>
                                                                <tr>
                                                                    <td><%= data.getFullname() %></td>
                                                                    <td><%= data.getPaymentId() %></td>
                                                                    <td><%= data.getDueDate() %></td>
                                                                    <td><%= data.getPaymentDate() != null ? data.getPaymentDate() : "" %></td>

                                                                    <td><span class="StatusSpan" data-badge='<%= data.getStatus() %>'><%= data.getStatus() %></span></td>

                                                                </tr>
                                                    <% } } %>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg-6">
                                <div class="card_1">
                                    <div class="card_1-body">
                                        <h5 class="card_1-title">Maintenance Requests Status - Last 30 Days</h5>
                                        <canvas id="maintenanceChart" width="400" height="200"></canvas>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="card_1">
                                        <div class="card_1-body">
                                            <div class="card_1-header" style="display: flex;    justify-content: space-between;">
                                                <h5 class="card_1-title">Recent Maintenance Requests</h5>
                                                <a class="btn_1 " href="${pageContext.request.contextPath}/admin/maintenance" style="margin-top:auto;margin-bottom:auto;">Show More</a>
                                            </div>
                                            <div class="table-wrap">
                                                <table class="table2 table-striped table-hover table-bordered">
                                                    <thead>
                                                        <tr>
                                                            <th>Requests ID</th>

                                                            <th>Issue Type</th>
                                                            <th>Issue Description</th>
                                                            <th>Status</th>
                                                            <th>Technician Name</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <% List<MaintenanceRequests> maintenance_requestsN = (List<MaintenanceRequests>) request.getAttribute("maintenance_requestsN");
                                                           if (maintenance_requestsN != null) {
                                                               for (MaintenanceRequests requestData : maintenance_requestsN) { %>
                                                                   <tr>
                                                                        <td><%= requestData.getId() %></td>
                                                                       <td><%= requestData.getIssueType() %></td>
                                                                       <td><%= requestData.getIssueDescription() %></td>
                                                                       <td><span class="StatusSpan" data-badge='<%= requestData.getStatus() %>'><%= requestData.getStatus() %></span></td>
                                                                       <td><%= requestData.getTechnicianName() != null ? requestData.getTechnicianName() : "N/A" %></td>
                                                                   </tr>
                                                        <% } } %>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
    </main>

    <%@ include file="/views/common/footer.jsp" %>
    <script>
        var contextPath = "${pageContext.request.contextPath}";
        // Fetch data from the Servlet
        fetch(contextPath + '/admin-api/getPaymentGraph')
            .then(response => response.json())
            .then(data => {
                console.log('Fetched data:', data);  // Log to see what data we receive

                // Ensure all the data is present
                const dates = data.dates;
                const pending = data.pending;
                const paid = data.paid;
                const overdue = data.overdue;

                if (!dates || !pending || !paid || !overdue) {
                    console.error('Data is missing some fields!');
                    return;
                }

                // Create the chart using Chart.js
                const ctx = document.getElementById('paymentChart').getContext('2d');
                const paymentChart = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: dates,  // X-axis (dates)
                        datasets: [
                            {
                                label: 'Pending Payments',
                                data: pending, // Y-axis (pending counts)
                                borderColor: '#ff771d',
                                fill: false
                            },
                            {
                                label: 'Paid Payments',
                                data: paid, // Y-axis (paid counts)
                                borderColor: 'rgb(0, 255, 0)',
                                fill: false
                            },
                            {
                                label: 'Overdue Payments',
                                data: overdue, // Y-axis (overdue counts)
                                borderColor: 'rgb(255, 0, 0)',
                                fill: false
                            }
                        ]
                    },
                    options: {
                        responsive: true,
                        scales: {
                            x: {
                                title: {
                                    display: true,
                                    text: 'Date'
                                }
                            },
                            y: {
                                title: {
                                    display: true,
                                    text: 'Number of Payments'
                                },
                                beginAtZero: true,
                                ticks: {
                                    stepSize: 1,  // Force Y-axis ticks to be integers
                                    callback: function(value) {
                                        return value % 1 === 0 ? value : '';  // Display only integer values
                                    }
                                }
                            }
                        }
                    }
                });
            })
            .catch(error => {
                console.error('Error fetching data:', error);
            });
    </script>





   <script>
       var contextPath = "${pageContext.request.contextPath}";
       // Fetch data from the Servlet
       fetch(contextPath + '/admin-api/getMaintenanceRequestsGraph')
           .then(response => response.json())
           .then(data => {
               console.log('Fetched data:', data);  // Log to see what data we receive

               // Ensure all the data is present
               const dates = data.dates;
               const pending = data.pending;
               const resolved = data.resolved;
               const inProgress = data.in_progress;

               if (!dates || !pending || !resolved || !inProgress) {
                   console.error('Data is missing some fields!');
                   return;
               }

               // Reverse the arrays to display the most recent date on the left
               const reversedDates = dates.reverse();
               const reversedPending = pending.reverse();
               const reversedResolved = resolved.reverse();
               const reversedInProgress = inProgress.reverse();

               // Create the chart using Chart.js
               const ctx = document.getElementById('maintenanceChart').getContext('2d');
               const maintenanceChart = new Chart(ctx, {
                   type: 'bar',
                   data: {
                       labels: reversedDates,  // X-axis (dates)
                       datasets: [
                           {
                               label: 'Pending Requests',
                               data: reversedPending, // Y-axis (pending counts)
                               backgroundColor: 'rgba(255, 0, 0, 0.9)',
                           },
                           {
                               label: 'Resolved Requests',
                               data: reversedResolved, // Y-axis (resolved counts)
                               backgroundColor: 'rgba(0, 200, 0, 0.9)',
                           },
                           {
                               label: 'In Progress Requests',
                               data: reversedInProgress, // Y-axis (in progress counts)
                               backgroundColor: 'rgba(255, 206, 86, 0.9)',
                           }
                       ]
                   },
                   options: {
                       responsive: true,
                       scales: {
                           x: {
                               title: {
                                   display: true,
                                   text: 'Date'
                               }
                           },
                           y: {
                               title: {
                                   display: true,
                                   text: 'Number of Requests'
                               },
                               beginAtZero: true
                           }
                       },
                       plugins: {
                           legend: {
                               position: 'top',
                           },
                           title: {
                               display: true,
                               text: 'Maintenance Requests Over the Last 30 Days',
                           },
                       },
                   }
               });
           })
           .catch(error => {
               console.error('Error fetching data:', error);
           });
   </script>


    <script src="${pageContext.request.contextPath}/component/js/tools/jquery-3.3.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/component/js/script.js"></script>

    </body>
</html>
