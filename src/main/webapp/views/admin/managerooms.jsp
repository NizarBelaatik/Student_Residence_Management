<%
    String currentPage = "rooms";  // or any dynamic value
    request.setAttribute("currentPage", currentPage);
%>

<%@ page import="java.util.List" %>
<%@ page import="model.Room" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Rooms</title>

        <!-- Google Fonts -->
        <link href="https://fonts.gstatic.com" rel="preconnect">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,700">
        
        
        <link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/fontawesome.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/bootstrap.min.css"> 
        
        <link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/bootstrap-icons/bootstrap-icons.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/bootstrap-icons/bootstrap-icons.min.css">
        
        <link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/style.css">

        <!-- Boxicons CSS -->
        <link href='https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css' rel='stylesheet'>
        
    </head>
    </head>
    <body>
        <%@ include file="/views/header.jsp" %>
        <%@ include file="/views/asideadmin.jsp" %>

    <!-- Main content -->
    <main class="main" id="main">
        <div class="pagetitle">
            <h1>Manage Rooms</h1>
            <nav>
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="">Home</a></li>
                <li class="breadcrumb-item">Dashboard</li>
                <li class="breadcrumb-item active">Rooms</li>
              </ol>
            </nav>
          </div>
        <section>
            <div class="row">
                <div class="col-lg-12">
                    
                    
                    Table with room details (ID, size, status).
                    Buttons for Add Room, Edit, Delete.
                    Form for adding/editing a room.

                </div>
                

                
            </div>
           
            <div class="row">
                <div class="col-12">
                    <div class="card_1">
                        <div class="card_1-body">
                            <div class="card_1-header">
                                
                                <input class="form-control" type="text" id="filterInput" placeholder="Search..." style="width:30%;min-width:100px;">
                                <div class="row add_btn_container"><a href="${pageContext.request.contextPath}/admin/rooms/addRoom" class="add_btn btn btn-success">ADD</a></div>
                            </div>
                            <div class="table-wrap">

                                <table class="table table-striped">
                                    <thead>
                                      <tr>
                                        <th>ID</th>
                                        <th>size</th>
                                        <th>Price</th>
                                        <th>Amenities</th>
                                        <th>Status</th>
                                        <th></th>
                                      </tr>
                                    </thead>
                                    <tbody>
                                      <tr>
                                        <th scope="row">1001</th>
                                        <td>Single</td>
                                        <td>$3000</td>
                                        <td>.....</td>
                                        <td><sapn class="StatusSpan" data-badge='Available'>Available</sapn></td>
                                        <td>
                                            <a class="btn btn-warning">Edit</a>
                                            <a class="btn btn-danger">Delete</a>
                                        </td>
                                      </tr>
                                      
                                        <% List<Room> roomList = (List<Room>) request.getAttribute("roomList");
                                            for (Room data : roomList) {%>
                                            
                                            <tr>
                                              <th scope="row"><%= data.getRoomId() %></th>
                                              <td><%= data.getSize() %></td>
                                              <td><%= data.getPrice() %></td>
                                              <td><%= data.getAmenities() %></td>
                                              <td><sapn class="StatusSpan" data-badge='<%= data.getState() %>'><%= data.getState() %></sapn></td>
                                              <td>
                                                  <a class="btn btn-warning">Edit</a>
                                                  <a class="btn btn-danger">Delete</a>
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
