<%-- 
    Document   : dashboard
    Created on : Dec 11, 2024, 4:27:26 PM
    Author     : night
--%>
<%
    String currentPage = "dashboard";  // or any dynamic value
    request.setAttribute("currentPage", currentPage);
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Dashboard</title>

        <%@ include file="/views/common/headadminlinks.jsp" %>
        
        
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
            <div class="row">
                <div class="col-lg-8">
                    <div class="row">
                        <div class="col-sm-4 col-md-4">
                          <div class="card info-card overdue-card">
                            <div class="card-body">
                              <h5 class="card-title">Payments |<span> Overdue</span></h5>
                              <div class="d-flex align-items-center">
                                <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                  <i class="bi bi-hourglass-bottom"></i>
                                </div>
                                <div class="ps-3">
                                    <h6>${overdue}</h6>
                                    <h7>${total_payments_overdue}</h7>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>


                        <div class="col-sm-4 col-md-4">
                          <div class="card info-card paid-card">
                            <div class="card-body">
                              <h5 class="card-title">Payments |<span> Paid</span></h5>
                              <div class="d-flex align-items-center">
                                <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                  <i class="bi bi-currency-dollar"></i>
                                </div>
                                <div class="ps-3">
                                  <h6>${paid}</h6>
                                  <h7>${total_payments_paid}</h7>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>

                        <div class="col-sm-4 col-md-4">
                          <div class="card info-card pending-card">
                            <div class="card-body">
                              <h5 class="card-title">Payments |<span> Pending</span></h5>
                              <div class="d-flex align-items-center">
                                <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                  <i class="bi bi-clock-history"></i>
                                </div>
                                <div class="ps-3">
                                    <h6>${pending}</h6>
                                    <h7>${total_payments_pending}</h7>

                                </div>
                              </div>
                            </div>
                          </div>
                        </div>

                        <div class="col-sm-4 col-md-4">
                          <div class="card info-card maintenance-requests-card">
                            <div class="card-body">
                              <h5 class="card-title">Maintenance Requests</h5>
                              <div class="d-flex align-items-center">
                                <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                  <i class="bi bi-tools"></i>
                                </div>
                                <div class="ps-3">
                                  <h6>${maintenance_requests}</h6>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                    </div>

                    <div class="row">


                    <canvas id="paymentChart" width="400" height="200"></canvas>

                        <script>
                            // Fetch data from the Servlet
                            var contextPath = "${pageContext.request.contextPath}";
                            fetch(contextPath+'/PaymentStatsServlet')  // URL of the servlet
                                .then(response => response.json())
                                .then(data => {
                                    // Extract data from the JSON response
                                    const pending = data.pending;
                                    const overdue = data.overdue;
                                    const paid = data.paid;

                                    // Set up the chart
                                    const ctx = document.getElementById('paymentChart').getContext('2d');
                                    const chart = new Chart(ctx, {
                                        type: 'bar',  // Bar chart
                                        data: {
                                            labels: ['Pending', 'Overdue', 'Paid'],  // X-axis labels
                                            datasets: [{
                                                label: 'Amount',
                                                data: [pending, overdue, paid],  // Data points
                                                backgroundColor: ['#FFDD00', '#FF6347', '#32CD32'],  // Colors for the bars
                                                borderColor: ['#FFD700', '#FF4500', '#228B22'],
                                                borderWidth: 1
                                            }]
                                        },
                                        options: {
                                            responsive: true,
                                            scales: {
                                                y: {
                                                    beginAtZero: true
                                                }
                                            }
                                        }
                                    });
                                })
                                .catch(error => console.error('Error fetching data: ', error));
                        </script>

                    </div>

                    <h1>Welcome</h1>
                        <p>This is the main content area.</p>
                        Total Rooms.
                        Occupancy Rate.
                        Pending Payments.
                        Pending Maintenance Requests.

                        Statistics: occupancy rates, overdue payments, pending maintenance requests.
                Quick links to manage rooms, residents, payments, and maintenance.

                </div>
                
                
                <div class="col-lg-4">
                    recent activity
                </div>
                
            </div>
            
        </section>
        
        
        
    </main>

    
    
    <script src="${pageContext.request.contextPath}/component/js/tools/jquery-3.3.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/component/js/script.js"></script>
    </body>
</html>
