<%
    String currentPage = "residents";  // or any dynamic value
    request.setAttribute("currentPage", currentPage);
%>

<%@ page import="java.util.List" %>
<%@ page import="model.Resident" %>
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
            <h1>Manage Residents</h1>
            <nav>
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Dashboard</a></li>
                <li class="breadcrumb-item active">Residents</li>
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
                                <div class="row add_btn_container"><a href="${pageContext.request.contextPath}/admin/residents/addResident" class="add_btn btn btn-success">ADD</a></div>
                            </div>
                            <div class="table-wrap">

                                <table class="table table-striped table-hover">
                                    <thead>
                                      <tr>
                                        <th>Email</th>
                                        <th>First name</th>
                                        <th>Last name</th>
                                        <th>Gender</th>
                                        <th>Phone</th>
                                        <th>Address</th>
                                        <th>Room Id</th>
                                        <th>Contract Start Date</th>
                                        <th>Contract End Date</th>
                                        <th></th>
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
                                              <td><%= data.getAddress() %></td>
                                              <td><%= data.getRoomId() %></td>
                                              <td><%= data.getCStartDate() %></td>
                                              <td><%= data.getCEndDate() %></td>
                                              
                                              <td>
                                                  <a class="actions_button" href="${pageContext.request.contextPath}/admin/residents/editResident?email=<%= data.getEmail() %>"><i class="bi bi-pencil-square actions_button_orange"></i></a>                                              </td>
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
