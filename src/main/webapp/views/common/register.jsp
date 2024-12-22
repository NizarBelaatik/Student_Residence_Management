<%-- 
    Document   : register
    Created on : Dec 20, 2024, 2:52:28 PM
    Author     : night
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registre</title>


        <!-- Google Fonts -->
        <link href="https://fonts.gstatic.com" rel="preconnect">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,700">


        <link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/fontawesome.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/vendor/bootstrap.min.css"> 

        <link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/vendor/bootstrap-icons/bootstrap-icons.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/vendor/bootstrap-icons/bootstrap-icons.min.css">

        <!-- Boxicons CSS -->
        <link href='https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css' rel='stylesheet'>
        <!-- SweetAlert2 for notifications -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


        <link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/style_register.css">
        
    </head>
    <body>
        <div class="container" id="Registration">
            <!-- Title section -->
            <div class="title">Registration</div>
            <div class="content">
              <!-- Registration form -->
              <form id="registrationForm" method="post" action="${pageContext.request.contextPath}/register" >
                    <div class="user-details">
                      <!-- Input for First Name -->
                      <div class="input-box">
                        <span class="details">First Name</span>
                        <input type="text" name="firstname"  placeholder="Enter your First Name" required>
                      </div>
                      <!-- Input for Last Name -->
                      <div class="input-box">
                        <span class="details">Last Name</span>
                        <input type="text" name="lastname"  placeholder="Enter your Last Name" required>
                      </div>
                    </div>
                    
                    <div class="user-details">
                        <!-- Input for Phone Number -->
                        <div class="input-box">
                            <span class="details">Phone Number</span>
                            <input type="text" name="phone"  placeholder="Enter your Phone Number" required>
                        </div>
                        
                        <!-- Input for Address -->
                        <div class="input-box">
                            <span class="details">Address</span>
                            <input type="text" name="address"  placeholder="Enter your Address" required>
                        </div>
                    </div>
                    
                    <div class="user-details">
                        <div class="input-box">
                        <span class="details">Email</span>
                        <input type="email" name="email"  placeholder="Enter your Email" required>
                      </div>
                    </div>
                    
                    <div class="user-details">
                        <!-- Input for Password -->
                        <div class="input-box">
                            <span class="details">Password</span>
                            <input type="password" id="password" name="password" placeholder="Enter your password" required>
                        </div>
                        <!-- Input for Confirm Password -->
                        <div class="input-box">
                            <span class="details">Confirm Password</span>
                            <input type="password" id="confirm-password" name="confirm_password" placeholder="Confirm your password" required>
                            <span id="error-message" style="color: red; display: none;">Passwords do not match!</span>
                        </div>
                    </div>
                    
                    
                    <div class="gender-details">
                      <!-- Radio buttons for gender selection -->
                      <input type="radio" name="gender" id="dot-1" value="male" required>
                      <input type="radio" name="gender" id="dot-2" value="female">
                      <span class="gender-title">Gender</span>
                      <div class="category">
                        <!-- Label for Male -->
                        <label for="dot-1">
                          <span class="dot one"></span>
                          <span class="gender">Male</span>
                        </label>
                        <!-- Label for Female -->
                        <label for="dot-2">
                          <span class="dot two"></span>
                          <span class="gender">Female</span>
                        </label>                  
                      </div>
                    </div>

                
                    <!-- Submit button -->
                    <div class="button">
                      <input type="submit" value="Register">
                    </div>
              </form>
            </div>
        </div>
        
        
        
        <div class="container" id="Verification">
            <!-- Title section -->
            <div class="title">Confirmation</div>
            <div class="content">
            
              
              <form id="validationForm" method="post" action="${pageContext.request.contextPath}/registerV">
                  <div class="user-details">
                        <h3>Enter the Validation Key</h3>
                        <p>We've sent a validation key to your email. Please enter it below to activate your account.</p>
                        <p></p>
                      
                  </div>
                <div class="user-details">
                  <div class="input-box">
                    <span class="details">Key</span>
                    <input class="" type="text" name="tokenKey" placeholder="KEY" maxlength="10" required>
                  </div>
                </div>
                
                <!-- Submit button -->
                <div class="button">
                  <input type="submit" value="Register">
                </div>
              </form>
            </div>
        </div>
        
        <div class="container" id="RegistrationSu" style="display: none;">
            <!-- Title section -->
            <div class="title">Confirmation</div>
            <div class="content">
            
              
              
            </div>
        </div>
        
        <script src="${pageContext.request.contextPath}/component/js/tools/jquery-3.3.1.min.js"></script>
        <script>var contextPath = "${pageContext.request.contextPath}";</script>
        <script src="${pageContext.request.contextPath}/component/js/register.js"></script>

    </body>
</html>
