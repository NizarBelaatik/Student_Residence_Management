<%
    String currentPage = "profile";  // or any dynamic value
    request.setAttribute("currentPage", currentPage);
%>

<%@ page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.*,jakarta.servlet.http.*,java.io.*,java.util.*,java.sql.*"%>

<!DOCTYPE html>
<html>
    <head>

        <title>Profile</title>
        <%@ include file="/views/common/headeradminlinks.jsp" %>


    </head>
    </head>
    <body>
        <%@ include file="/views/common/headeradmin.jsp" %>
        <%@ include file="/views/common/asideadmin.jsp" %>

    <!-- Main content -->
    <main class="main" id="main">
        <div class="pagetitle">
            <h1>Profile</h1>
            <nav>
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Dashboard</a></li>
                <li class="breadcrumb-item active">Profile</li>
              </ol>
            </nav>
          </div>
        <section>
        <div class="container mt-5 ">
                <div class="row justify-content-center">
                    <div class="col-lg-10">
                        <!-- Profile Card -->
                        <div class="card profile-card">
                            <div class="card-header profile-header text-center">
                                <!-- Profile Image -->
                                <h3>${admin.getFullname()}</h3>
                                <p>Member since:  ${user_since}</p>
                                <a href="${pageContext.request.contextPath}/admin/settings" class="btn_2">Edit Profile</a>
                            </div>
                            <div class="card-body">
                                <!-- Personal Information Section -->
                                <div class="section-title">Personal Information</div>
                                <ul class="list-group">
                                    <li class="list-group-item"><strong>Email:</strong> ${admin.getEmail()}</li>
                                    <li class="list-group-item"><strong>First name:</strong> ${admin.getFirstname()}</li>
                                    <li class="list-group-item"><strong>Last name:</strong> ${admin.getLastname()}</li>
                                    <li class="list-group-item"><strong>Phone:</strong> ${admin.getPhone()}</li>
                                </ul>



                            </div>
                        </div>
                    </div>
                </div>
            </div>


        </section>

    </main>
    <%@ include file="/views/common/footer.jsp" %>


    <script src="${pageContext.request.contextPath}/component/js/tools/jquery-3.3.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/component/js/script.js"></script>
</body>
</html>
