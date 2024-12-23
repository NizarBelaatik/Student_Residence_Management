<%-- 
    Document   : login
    Created on : Dec 23, 2024, 4:31:56 PM
    Author     : night
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
</head>
<body>

<h2>Login</h2>

<!-- Login Form -->
<form action="login" method="post">
    <label for="email">Email:</label>
    <input type="text" id="email" name="email" required><br><br>

    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required><br><br>

    <button type="submit">Login</button>
</form>

<%-- Display error message if any --%>
<% 
    String error = (String) request.getAttribute("error"); 
    if (error != null) {
%>
    <p style="color:red;"><%= error %></p>
<% } %>

</body>
</html>
