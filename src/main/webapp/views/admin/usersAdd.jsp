<%
    String currentPage = "users";  // or any dynamic value
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
            <h1>Manage Users</h1>
            <nav>
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Dashboard</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/users">Users</a></li>
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
                                <h5>Add User</h5>
                            </div>

                            <form id="addUserForm" method="post" action="${pageContext.request.contextPath}/admin/users/userAdd">
                                <div class="row mb-3">
                                  <label for="firstname" class="col-sm-2 col-form-label">First Name</label>
                                  <div class="col-sm-10">
                                    <input type="text" class="form-control" name="firstname" required>
                                  </div>
                                </div>
                                <div class="row mb-3">
                                  <label for="lastname" class="col-sm-2 col-form-label">Last Name</label>
                                  <div class="col-sm-10">
                                    <input type="text" class="form-control" name="lastname" required>
                                  </div>
                                </div>
                                <div class="row mb-3">
                                  <label for="phone" class="col-sm-2 col-form-label">Phone</label>
                                  <div class="col-sm-10">
                                    <input type="text" class="form-control" name="phone" required>
                                  </div>
                                </div>
                                <div class="row mb-3">
                                  <label for="inputEmail3" class="col-sm-2 col-form-label">Email</label>
                                  <div class="col-sm-10">
                                    <input type="email" class="form-control" name="inputemail" required>
                                  </div>
                                </div>

                                <div class="row mb-3">
                                    <label for="inputState" class="col-sm-2 col-form-label">Role</label>
                                    <div class="col-sm-10">
                                    <select name="inputRole" class="form-select" required>
                                      <option value="admin">Admin</option>
                                      <option value="tech">Technician</option>
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
        var csrfToken = $("meta[name='csrf-token']").attr("content");
        $(document).ready(function() {
            // Handle form submission
            $('#addUserForm').submit(function(e) {
                e.preventDefault(); // Prevent default form submission

                // Perform AJAX request
                $.ajax({
                    url: contextPath+'/admin/users/userAdd', // The servlet URL
                    method: 'POST',
                    data: $(this).serialize(), // Serialize the form data
                    headers: {'X-CSRF-Token': csrfToken},
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
