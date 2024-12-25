<%
    String currentPage = "rooms";  // or any dynamic value
    request.setAttribute("currentPage", currentPage);
%>

<%@ page import="java.util.List" %>
<%@ page import="model.Room" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.*,jakarta.servlet.http.*,java.io.*,java.util.*,java.sql.*"%>

<!DOCTYPE html>
<html>
    <head>
        
        <title>Manage Rooms</title>
        <%@ include file="/views/common/head.jsp" %>
        
        
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
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Dashboard</a></li>
                <li class="breadcrumb-item active">Rooms</li>
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
                                <div class="row add_btn_container"><a href="${pageContext.request.contextPath}/admin/rooms/addRoom" class="add_btn btn btn-success">ADD</a></div>
                            </div>
                            <div class="table-wrap">

                                <table class="table table-striped table-hover">
                                    <thead>
                                      <tr>
                                        <th>ID</th>
                                        <th>Name</th>
                                        <th>Size</th>
                                        <th>Price</th>
                                        <th>Equipments</th>
                                        <th>Status</th>
                                        <th></th>
                                      </tr>
                                    </thead>
                                    <tbody>
                                      
                                      
                                        <% List<Room> roomList = (List<Room>) request.getAttribute("roomList");
                                            for (Room data : roomList) {%>
                                            
                                            <tr>
                                              <th scope="row"><%= data.getRoomId() %></th>
                                              <td><%= data.getRoomName() %></td>
                                              <td><%= data.getSize() %></td>
                                              <td><%= data.getPrice() %></td>
                                              <td><%= data.getEquipment() %></td>
                                              <td><sapn class="StatusSpan" data-badge='<%= data.getState() %>'><%= data.getState() %></sapn></td>
                                              <td>
                                                  <a class="actions_button" href="${pageContext.request.contextPath}/admin/rooms/editRoom?roomId=<%= data.getRoomId() %>"><i class="bi bi-pencil-square actions_button_orange"></i></a>
                                                  <a class="actions_button" onclick="deleteRoom('<%= data.getRoomId() %>')"><i class="bi bi-trash3-fill actions_button_red"></i></a>
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
        
        <script>
            var contextPath = "${pageContext.request.contextPath}";

            function deleteRoom(roomId) {
                // Confirm deletion before proceeding
                Swal.fire({
                    title: 'Are you sure?',
                    text: "This action cannot be undone.",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonText: 'Yes, delete it!',
                    cancelButtonText: 'No, cancel!',
                    reverseButtons: true
                }).then((result) => {
                    if (result.isConfirmed) {
                        // Perform AJAX request to delete the room
                        $.ajax({
                            url: contextPath + '/admin/rooms/roomsDelete', // The servlet URL
                            method: 'GET', // We are using GET for this case
                            data: { roomId: roomId }, // Send roomId in the data
                            dataType: 'json', // Expect JSON response
                            success: function(response) {
                                // Handle the response
                                if (response.messageType === "success") {
                                    Swal.fire({
                                        icon: 'success',
                                        title: 'Deleted!',
                                        text: response.message,
                                        showConfirmButton: false,
                                        timer: 3000
                                    }).then(() => {
                                        // Optionally, remove the room from the DOM or refresh the page
                                        location.reload(); // You can also manually remove the element from the DOM
                                    });
                                } else if (response.messageType === "error") {
                                    Swal.fire({
                                        icon: 'error',
                                        title: 'Oops...',
                                        text: response.message,
                                        confirmButtonText: 'Try Again'
                                    });
                                }
                            },
                            error: function(xhr, status, error) {
                                // Handle AJAX errors
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Error',
                                    text: 'An error occurred while processing your request. Please try again later.',
                                    confirmButtonText: 'OK'
                                });
                            }
                        });
                    }
                });
            }
        </script>

        <script src="${pageContext.request.contextPath}/component/js/tools/jquery-3.3.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/component/js/script.js"></script>
    </body>
</html>
