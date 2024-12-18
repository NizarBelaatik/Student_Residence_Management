<%
    String currentPage = "rooms";  // or any dynamic value
    request.setAttribute("currentPage", currentPage);
%>
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
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/rooms">Rooms</a></li>
                <li class="breadcrumb-item active">ADD</li>
              </ol>
            </nav>
          </div>
        <section>

           
            <div class="row">
                <div class="col-12">
                    <div class="card_1">
                        <div class="card_1-body">
                            <div class="card_1-header">
                                <h5>Edit Room</h5>
                            </div>
                         
                            <form  action="addRoom" method="post">
                                <div class="row mb-3">
                                  <label for="inputEmail3" class="col-sm-2 col-form-label">Size</label>
                                  <div class="col-sm-10">
                                    <input type="text" class="form-control" name="inputSize" value="${room.Size}" required>
                                  </div>
                                </div>
                                
                                
                                <div class="row mb-3">
                                  <label for="inputEmail3" class="col-sm-2 col-form-label">Amenities</label>
                                  <div class="col-sm-10">
                                    <input type="text" class="form-control" name="inputAmenities" value="${room.Amenities}" required>
                                  </div>
                                </div>
                                
                                
                                <div class="row mb-3">
                                  <label for="inputEmail3" class="col-sm-2 col-form-label">Price</label>
                                  <div class="col-sm-10">
                                      <input type="number" class="form-control" name="inputPrice" value="${room.Price}" step="0.01" required>
                                  </div>
                                </div>
                                
                                
                                <div class="row mb-3">
                                    <label for="inputState" class="col-sm-2 col-form-label">State</label>
                                    <div class="col-sm-10">
                                        <select name="inputState" class="form-select" required>
                                            <option value="Available" ${room.state == 'Available' ? 'selected' : ''}>Available</option>
                                            <option value="Occupied" ${room.state == 'Occupied' ? 'selected' : ''}>Occupied</option>
                                            <option value="Maintenance" ${room.state == 'Maintenance' ? 'selected' : ''}>Maintenance</option>
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
        
        
        <script src="${pageContext.request.contextPath}/component/js/tools/jquery-3.3.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/component/js/script.js"></script>
    </body>
</html>
