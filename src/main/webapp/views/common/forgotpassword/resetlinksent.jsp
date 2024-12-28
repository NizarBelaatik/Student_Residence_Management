<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Link Sent</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/forgotpassword.css">

</head>
<body>
    <div class="container">
        <div class="message-container">
            <h2>A reset link has been sent to your email. Please check your inbox.</h2>
            <p>If you don't see it in your inbox, please check your spam or junk folder.</p>
            <button onclick="window.location.href='${pageContext.request.contextPath}/login'">Go to Login</button>
        </div>
    </div>
</body>
</html>
