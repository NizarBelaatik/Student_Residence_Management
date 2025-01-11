<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Successful</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/forgotpassword.css">

</head>
<body>
    <div class="container">
        <div class="message-container">
            <h2>Your password has been reset successfully! You can now log in with your new password.</h2>
            <p>If you have any issues logging in, please contact support for assistance.</p>
            <button onclick="window.location.href='${pageContext.request.contextPath}/login'">Go to Login</button>
        </div>
    </div>

    <%@ include file="/views/common/footer.jsp" %>
</body>
</html>
