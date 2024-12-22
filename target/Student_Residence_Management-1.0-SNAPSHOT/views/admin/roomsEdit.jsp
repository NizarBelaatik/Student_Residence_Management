<%
    String currentPage = "rooms";  // or any dynamic value
    request.setAttribute("currentPage", currentPage);
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.*,jakarta.servlet.http.*,java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Room: ${room.getRoomId()}</title>

    <%@ include file="/views/common/head.jsp" %>

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
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/rooms">Rooms</a></li>
                <li class="breadcrumb-item active">Edit</li>
              </ol>
            </nav>
        </div>
        <section>
            <div class="row">
                <div class="col-12">
                    <div class="card_1">
                        <div class="card_1-body">
                            <div class="card_1-header">
                                <h5>Edit Room | ${room.getRoomId()}</h5>
                            </div>

                            <form id="editRoomForm" method="post" action="${pageContext.request.contextPath}/admin/rooms/editRoom">
                                <input type="hidden" class="form-control" name="inputRoomId" value="${room.getRoomId()}">

                                <div class="row mb-3">
                                  <label for="inputEmail3" class="col-sm-2 col-form-label">Size</label>
                                  <div class="col-sm-10">
                                    <input type="text" class="form-control" name="inputSize" value="${room.getSize()}" required>
                                  </div>
                                </div>
                                <div class="row mb-3">
                                  <label for="inputEmail3" class="col-sm-2 col-form-label">Room Name</label>
                                  <div class="col-sm-10">
                                    <input type="text" class="form-control" name="inputName" value="${room.getRoomName()}" required>
                                  </div>
                                </div>
                                
                                <div class="row mb-3">
                                  <label for="inputEmail3" class="col-sm-2 col-form-label">Equipment</label>
                                  <div class="col-sm-10">
                                    <input type="text" class="form-control" name="inputAmenities" value="${room.getEquipment()}" required>
                                  </div>
                                </div>
                                
                                
                                <div class="row mb-3">
                                  <label for="inputEmail3" class="col-sm-2 col-form-label">Price</label>
                                  <div class="col-sm-10">
                                      <input type="number" class="form-control" name="inputPrice" value="${room.getPrice()}" step="0.01" required>
                                  </div>
                                </div>
                                
                                
                                <div class="row mb-3">
                                    <label for="inputState" class="col-sm-2 col-form-label">State</label>
                                    <div class="col-sm-10">
                                        <select name="inputState" class="form-select" required>
                                            <option value="Available" ${room.getState() == 'Available' ? 'selected' : ''}>Available</option>
                                            <option value="Occupied" ${room.getState() == 'Occupied' ? 'selected' : ''}>Occupied</option>
                                            <option value="Maintenance" ${room.getState() == 'Maintenance' ? 'selected' : ''}>Maintenance</option>
                                        </select>
                                  </div>
                                </div>
                                
                                <div class="text-center">
                                  <button type="submit" class="btn1 submit_btn">Submit</button>
                                  <button type="reset" class="btn1 cancle_btn">Reset</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <script>
        var contextPath = "${pageContext.request.contextPath}";
        $(document).ready(function() {
            // Handle form submission
            $('#editRoomForm').submit(function(e) {
                e.preventDefault(); // Prevent default form submission
                
                // Perform AJAX request
                $.ajax({
                    url: contextPath+'/admin/rooms/editRoom', // The servlet URL
                    method: 'POST',
                    data: $(this).serialize(), // Serialize the form data
                    dataType: 'json', // Expect a JSON response
                    success: function(response) {
                        // Handle successful form submission (response will contain messageType and message)
                        if (response.messageType === "success") {
                            Swal.fire({
                                icon: 'success',
                                title: 'Success!',
                                text: response.message,
                                showConfirmButton: false,
                                timer: 3000
                            }).then(() => {
                                $('#addRoomForm')[0].reset(); // Reset the form after success
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
            });
        });
    </script>
    
    <script src="${pageContext.request.contextPath}/component/js/tools/jquery-3.3.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/component/js/script.js"></script>
</body>
</html>
