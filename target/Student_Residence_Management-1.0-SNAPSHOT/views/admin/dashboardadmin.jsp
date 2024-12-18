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

        <%@ include file="/views/common/head.jsp" %>
        
        
    </head>
    <body>
        
    <%@ include file="/views/header.jsp" %>
    <%@ include file="/views/asideadmin.jsp" %>

    <!-- Main content -->
    <main class="main" id="main">
        <div class="pagetitle">
            <h1>Dashboard</h1>
            <nav>
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="">Home</a></li>
                <li class="breadcrumb-item active">Dashboard</li>
              </ol>
            </nav>
          </div>
        <section>
            <div class="row">
                <div class="col-lg-8">
                    
                    
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
