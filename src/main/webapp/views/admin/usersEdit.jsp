<%
    String currentPage = "users";  // or any dynamic value
    request.setAttribute("currentPage", currentPage);
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.*,jakarta.servlet.http.*,java.io.*,java.util.*,java.sql.*"%>


<!DOCTYPE html>
<html>
<head>
    <title>Edit User</title>

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
                <li class="breadcrumb-item active">Edit</li>
              </ol>
            </nav>
        </div>
        <section>
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card_1">
                        <div class="card_1-body">
                            <div class="card_1-header">
                                <h5>Edit User | ${user.getEmail()}</h5>
                            </div>

                            <form id="addUserForm" method="post" action="${pageContext.request.contextPath}/admin/users/addUser">
                                <div class="row mb-3">
                                  <label for="inputEmail3" class="col-sm-2 col-form-label">Email</label>
                                  <div class="col-sm-10">
                                    <input type="email" class="form-control" name="inputemail" value="${user.getEmail()}" required>
                                  </div>
                                </div>



                                <div class="row mb-3">
                                    <label for="inputRole" class="col-sm-2 col-form-label">Role</label>
                                    <div class="col-sm-10">
                                        <select name="inputRole" class="form-select" required>
                                            <option value="admin" ${user.getRole() == 'admin' ? 'selected' : ''}>Admin</option>
                                            <option value="tech" ${user.getRole() == 'tech' ? 'selected' : ''}>Technician</option>
                                        </select>
                                  </div>
                                </div>

                                <div class="row mb-3">
                                    <label for="inputRole" class="col-sm-2 col-form-label">is Active</label>
                                    <div class="col-sm-10">
                                        <label class="switch">
                                          <input type="checkbox" name="inputisactive" ${user.isActive()  ? 'checked' : ''}>
                                          <span class="slider round"></span>
                                        </label>

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
        <%@ include file="/views/common/footer.jsp" %>
    </main>

    <script>
        var contextPath = "${pageContext.request.contextPath}";
        $(document).ready(function() {
            // Handle form submission
            $('#addUserForm').submit(function(e) {
                e.preventDefault(); // Prevent default form submission

                // Perform AJAX request
                $.ajax({
                    url: contextPath+'/admin/users/editUser', // The servlet URL
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

</body>
</html>
