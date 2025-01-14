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
                    <div class="col-lg-8">

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

                        <div class="row">
                            <div class="col-lg-12">
                                <div class="card_1">
                                    <div class="card_1-body">
                                        <h5 class="card_1-title">Payments for last 30 days</h5>
                                        <canvas id="paymentChart" ></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg-12">
                                <div class="card_1">
                                    <div class="card_1-body">
                                        <h5 class="card_1-title">Maintenance Requests Status - Last 30 Days</h5>
                                        <canvas id="stakedBarChart" style="max-height: 400px; display: block;"></canvas>
                                    </div>
                                </div>
                            </div>
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
    document.addEventListener("DOMContentLoaded", () => {
        var contextPath = "${pageContext.request.contextPath}";

        fetch(contextPath+'/admin-api/getRequestData')
            .then(response => {
                if (!response.ok) {
                    // If the response is not OK, show the status text
                    throw new Error('Network response was not ok: ' + response.statusText);
                }
                return response.json();  // Parse the JSON
            })
            .then(data => {
                let labels = data.labels;  // Dates (last 30 days)
                const datasets = [];

                // Reverse the labels to show from the most recent to the oldest
                labels = labels.reverse();

                // Reverse each dataset to match the reversed labels
                for (const status in data.datasets) {
                    datasets.push({
                        label: status,  // Status name
                        data: data.datasets[status].reverse(), // Reverse the counts for each date
                        backgroundColor: getColorForStatus(status), // Get specific color based on the status
                    });
                }

                // Create the stacked bar chart
                new Chart(document.querySelector('#stakedBarChart'), {
                    type: 'bar',
                    data: {
                        labels: labels,  // X-axis labels (dates, now in reversed order)
                        datasets: datasets // Data for each status, also in reversed order
                    },
                    options: {
                        plugins: {
                            title: {
                                display: true
                            }
                        },
                        responsive: true,
                        scales: {
                            x: {
                                stacked: true,  // Stack bars on the X-axis
                                reverse: true,  // Reverse the X-axis so the most recent date appears on the right
                            },
                            y: {
                                stacked: true,  // Stack bars on the Y-axis
                                ticks: {
                                    beginAtZero: true,  // Start from zero
                                    stepSize: 1,  // Increment by 1
                                    callback: function(value) {  // Ensure the ticks are integers
                                        return value % 1 === 0 ? value : '';
                                    }
                                }
                            }
                        }
                    }
                });
            })
            .catch(error => {
                console.error('Error fetching data:', error);
                alert('Error fetching data: ' + error.message);
            });

        // Helper function to return specific color based on status
        function getColorForStatus(status) {
            switch (status) {
                case 'pending':
                    return 'red';  // Red for pending
                case 'resolved':
                    return 'rgb(0, 200, 0)';  // Green for resolved
                case 'in_progress':
                    return 'orange';  // Yellow for in progress
                default:
                    return 'rgb(201, 203, 207)';  // Default gray for unknown status
            }
        }
    });
</script>




    <script src="${pageContext.request.contextPath}/component/js/tools/jquery-3.3.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/component/js/script.js"></script>

    </body>
</html>
