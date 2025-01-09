<%
    String currentPage = "users";  // or any dynamic value
    request.setAttribute("currentPage", currentPage);
%>

<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
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
            <h1>Manage Users</h1>
            <nav>
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Dashboard</a></li>
                <li class="breadcrumb-item active">Users</li>
              </ol>
            </nav>
          </div>
        <section>


            <div class="row justify-content-center">
                <div class=" ">
                    <div class="card_1">
                        <div class="card_1-body">
                            <div class="card_1-header" style="display: flex;">

                                <input class="form-control" type="text" id="filterInput" placeholder="Search..." style="width:45%;min-width:150px;">
                                <div class="row add_btn_container"><a href="${pageContext.request.contextPath}/admin/users/userAdd" class="add_btn btn btn-success"><i class="bi bi-person-add fs-3"></i></a></div>
                            </div>
                            <div class="table-wrap">

                                <table class="table table-striped table-hover">
                                    <thead>
                                      <tr>
                                        <th>Email</th>
                                        <th>Role</th>
                                        <th>Active </th>
                                        <th>Creation date</th>
                                        <th></th>
                                      </tr>
                                    </thead>
                                    <tbody>

                                        <% List<User> usersList = (List<User>) request.getAttribute("usersList");
                                            for (User data : usersList) {%>
                                            <tr>
                                              <th scope="row"><%= data.getEmail() %></th>
                                              <td><%= data.getRole() %></td>
                                              <td><span class="StatusSpan" data-badge='<%= data.isActive() %>'><%= data.isActive() %></span></td>
                                              <td><%= data.getCreatedAt() %></td>
                                              <td>
                                                  <a class="actions_button" href="${pageContext.request.contextPath}/admin/users/editUser?email=<%= data.getEmail() %>"><i class="bi bi-pencil-square actions_button_orange"></i></a>
                                              </td>
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
