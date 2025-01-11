<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invalid Token</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/forgotpassword.css">

</head>
<body>
    <div class="container">
        <div class="message-container">
            <h2>The reset token is invalid or expired. Please try again.</h2>
            <p>If you didn't request a password reset or are having trouble, please contact support.</p>
            <button onclick="window.location.href='forgot-password-email.html'">Back to Forgot Password</button>
        </div>
    </div>
    <%@ include file="/views/common/footer.jsp" %>
</body>
</html>
