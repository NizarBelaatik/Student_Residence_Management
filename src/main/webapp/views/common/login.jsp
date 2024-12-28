<%-- 
    Document   : login
    Created on : Dec 11, 2024, 4:26:49 PM
    Author     : night
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Login</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/login.css">

</head>
<body>


    <div class="container">
            <div class="login-form">
                <h2>Login</h2>
                <form action="login" method="post">
                    <input type="email" name="email" placeholder="Email" required><br>
                    <input type="password" name="password" placeholder="Password" required><br>
                        <%
                            String error = (String) request.getAttribute("error");
                            if (error != null) {
                        %>
                            <p style="color:red;"><%= error %></p>
                        <% } %>
                    <button type="submit">Login</button>
                </form>
                <a href="${pageContext.request.contextPath}/forgot-password" class="forgot-password">Forgot Password?</a>
            </div>
        </div>


    <%-- Display error message if any --%>

</body>
</html>
