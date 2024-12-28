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
                              <h5 class="card-title">Payments <span>| Overdue</span></h5>
                              <div class="d-flex align-items-center">
                                <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                  <i class="bi bi-hourglass-bottom"></i>
                                </div>
                                <div class="ps-3">
                                  <h6>${overdue}</h6>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>


                        <div class="col-sm-4 col-md-4">
                          <div class="card info-card paid-card">
                            <div class="card-body">
                              <h5 class="card-title">Payments <span>| Paid</span></h5>
                              <div class="d-flex align-items-center">
                                <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                  <i class="bi bi-currency-dollar"></i>
                                </div>
                                <div class="ps-3">
                                  <h6>${paid}</h6>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>

                        <div class="col-sm-4 col-md-4">
                          <div class="card info-card pending-card">
                            <div class="card-body">
                              <h5 class="card-title">Payments <span>| Pending</span></h5>
                              <div class="d-flex align-items-center">
                                <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                  <i class="bi bi-clock-history"></i>
                                </div>
                                <div class="ps-3">
                                  <h6>${pending}</h6>
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
