<%
    String currentPage = "residents";  // or any dynamic value
    request.setAttribute("currentPage", currentPage);
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.*,jakarta.servlet.http.*,java.io.*,java.util.*,java.sql.*"%>
<%@ page import="model.Room" %>


<!DOCTYPE html>
<html>
<head>
    <title>Add Room</title>
    
    <%@ include file="/views/common/headeradminlinks.jsp" %>
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
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/residents">Residents</a></li>
                <li class="breadcrumb-item active">ADD</li>
              </ol>
            </nav>
        </div>
        <section>
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card_1">
                        <div class="card_1-body">
                            <div class="card_1-header">
                                <h5>Add Residents</h5>
                            </div>

                            <form id="addResidentForm" method="post" action="${pageContext.request.contextPath}/admin/Residents/addResident">
                                <div class="row mb-3">
                                  <label for="inputEmail3" class="col-sm-2 col-form-label">Email</label>
                                  <div class="col-sm-10">
                                    <input type="email" class="form-control" name="inputemail" required>
                                  </div>
                                </div>
                                
                                <div class="row mb-3">
                                  <label for="inputEmail3" class="col-sm-2 col-form-label">First name</label>
                                  <div class="col-sm-10">
                                    <input type="text" class="form-control" name="inputfirstname" required>
                                  </div>
                                </div>
                                
                                <div class="row mb-3">
                                  <label for="inputEmail3" class="col-sm-2 col-form-label">Firs last</label>
                                  <div class="col-sm-10">
                                    <input type="text" class="form-control" name="inputlastname" required>
                                  </div>
                                </div>
                                
                               
                                
                                <div class="row mb-3">
                                    <label for="inputState" class="col-sm-2 col-form-label">Gender</label>
                                    <div class="col-sm-10">
                                    <select name="inputgender" class="form-select" required>
                                      <option value="male">Male</option>
                                      <option value="female">Female</option>
                                    </select>
                                  </div>
                                </div>
                                
                                 <div class="row mb-3">
                                  <label for="inputEmail3" class="col-sm-2 col-form-label">Phone</label>
                                  <div class="col-sm-10">
                                    <input type="text" class="form-control" name="inputphone" required>
                                  </div>
                                </div>
                                
                                <div class="row mb-3">
                                  <label for="inputEmail3" class="col-sm-2 col-form-label">Address</label>
                                  <div class="col-sm-10">
                                    <input type="text" class="form-control" name="inputaddress" required>
                                  </div>
                                </div>

                                <div class="row mb-3">
                                    <label for="inputroomId" class="col-sm-2 col-form-label">Room</label>
                                    <div class="col-sm-10">
                                        <select name="inputroomId" class="form-select" required>
                                            <option value="" disabled selected>Select Room</option>
                                            <%
                                                // Retrieve the list of rooms from the request
                                                List<Room> roomList = (List<Room>) request.getAttribute("roomList");

                                                for (Room room : roomList) {
                                            %>
                                                <option value="<%= room.getRoomId() %>" >
                                                    ID:<%= room.getRoomId() %> | Name:<%= room.getRoomName() %> | Size:<%= room.getSize() %> | Price:<%= room.getPrice() %>
                                                </option>
                                            <%
                                                }
                                            %>
                                        </select>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label for="inputDate" class="col-sm-2 col-form-label">Start Date</label>
                                    <div class="col-sm-3">
                                        <input type="date" class="form-control" name="inputStartDate">
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <label for="inputDate" class="col-sm-2 col-form-label">End Date</label>
                                    <div class="col-sm-3">
                                        <input type="date" class="form-control" name="inputEndDate">
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
            $('#addResidentForm').submit(function(e) {
                e.preventDefault(); // Prevent default form submission
                
                // Perform AJAX request
                $.ajax({
                    url: contextPath+'/admin/residents/addResident', // The servlet URL
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
                                $('#')[0].reset(); // Reset the form after success
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

    <%@ include file="/views/common/footer.jsp" %>
</body>
</html>
