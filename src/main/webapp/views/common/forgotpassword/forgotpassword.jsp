</html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/forgotpassword.css">

</head>
<body>

    <div class="container">
        <div class="form-container">
            <h2>Forgot Password</h2>
            <form action="forgot-password" method="POST">
                <label for="email">Enter your email:</label>
                <input type="email" id="email" name="email" required>

                <button type="submit">Send Reset Link</button>
            </form>

            <!-- Example error message (can be dynamically populated) -->
            <p class="error" id="error-message" style="display: none;">Email not found. Please try again.</p>

        </div>
    </div>
    <script>
        const form = document.querySelector('form');
        form.addEventListener('submit', function(event) {
            const email = document.querySelector('#email').value;

            // Simulate checking if email exists
            if (email === "") {
                event.preventDefault(); // Prevent form submission
                document.getElementById('error-message').style.display = 'block'; // Show error message
            }
        });
    </script>

    <%@ include file="/views/common/footer.jsp" %>
</body>
</html>
