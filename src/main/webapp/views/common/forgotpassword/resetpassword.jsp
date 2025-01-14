<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/forgotpassword.css">
</head>
<body>
    <div class="container">
        <div class="form-container">
            <h2>Reset Password</h2>
            <form action="reset-password" method="POST">
                <input type="hidden" name="email" value="${param.email}">
                <input type="hidden" name="token" value="${param.token}">


                <label for="newPassword">Enter New Password:</label>
                <input type="password" id="newPassword" name="newPassword" required>

                <label for="conPassword">Confirm New Password:</label>
                <input type="password" id="conPassword" name="conPassword" required>

                <button type="submit">Reset Password</button>
            </form>

            <!-- Example error message (can be dynamically populated) -->
            <p class="error" id="error-message" style="display: none;">Passwords do not match. Please try again.</p>

        </div>
    </div>

    <script>
        const form = document.querySelector('form');
        form.addEventListener('submit', function(event) {
            const newPassword = document.querySelector('#newPassword').value;
            const conPassword = document.querySelector('#conPassword').value;

            if (newPassword !== conPassword) {
                event.preventDefault(); // Prevent form submission
                document.getElementById('error-message').style.display = 'block'; // Show error message
            }
        });
    </script>
</body>
</html>
