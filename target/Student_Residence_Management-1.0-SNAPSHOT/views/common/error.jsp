<%-- 
    Document   : error
    Created on : Dec 11, 2024, 4:27:02 PM
    Author     : night
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error Page</title>
    <style>
        :root {
            --clr0: #fff; /* #f8f9faLight background color */
            --clr1: #000226; /* Dark primary color */
            --clr2: #6c757d; /* Secondary gray color */
            --clr3: #fff;     /* White color */
            --clr-primary: #000226; /* Primary blue color */
            --clr-success: #28a745; /* Success green color */
            --clr-info: #17a2b8; /* Info color (light blue) */
            --clr-danger: #dc3545; /* Danger color (red) */
            --clr-warning: #ffc107; /* Warning yellow color */

            --clr_Available: rgb(0, 200, 0);
            --clr_Occupied: red;
            --clr_Maintenance: orange;
        }

        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--clr0);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: var(--clr1);
        }

        .error-container {
            text-align: center;
            padding: 20px;
            max-width: 600px;
            margin: 20px;
            border-radius: 8px;
            background-color: var(--clr3);
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .error-header {
            font-size: 3rem;
            font-weight: bold;
            color: var(--clr-danger);
        }

        .error-message {
            font-size: 1.2rem;
            margin: 20px 0;
            color: var(--clr2);
        }

        .error-details {
            font-size: 1rem;
            color: var(--clr2);
            margin-bottom: 20px;
        }

        .error-buttons {
            display: flex;
            justify-content: center;
            gap: 10px;
        }

        /* btn_1 Button */
        .btn_body {
            display: inline-block;
            font-weight: 400;
            text-align: center;
            white-space: nowrap;
            vertical-align: middle;
            user-select: none;
            border: 1px solid transparent;
            padding: .375rem .75rem;
            font-size: 1rem;
            line-height: 1.5;
            border-radius: .25rem;
            transition: color .15s ease-in-out, background-color .15s ease-in-out, border-color .15s ease-in-out, box-shadow .15s ease-in-out;

            border: 1px solid var(--clr-primary); /* Border color matches primary color */
            text-decoration: none;
        }

        .btn_1{
            color: #fff;
            background-color: var(--clr-primary); /* Use primary color */
        }
        .btn_1:hover,
        .btn_1:active {
            color: var(--clr-primary); /* Text color changes on hover/active */
            background-color: #fff; /* Background turns white */
            border-color: var(--clr-primary); /* Border remains primary color */
            text-decoration: none;
        }
        .btn_1:active {
            outline: 0;
            box-shadow: 0 0 0 .2rem rgba(0, 2, 38, .25); /* Custom focus box-shadow */
        }

        /* Submit Button Hover and Active */
        .btn_2{
            color: var(--clr-primary);
            background-color: #fff; /* Use primary color */
        }
        .btn_2:hover,
        .btn_2:active {
            color: #fff; /* Text color changes on hover/active */
            background-color: var(--clr-primary); /* Background turns white */
            border-color: #fff; /* Border remains primary color */
            text-decoration: none;
        }
        .btn_2:active {
            outline: 0;
            box-shadow: 0 0 0 .2rem rgba(0, 2, 38, .25); /* Custom focus box-shadow */
        }



    </style>
</head>

<body>
    <div class="error-container">
        <div class="error-header">
            Error 404
        </div>
        <div class="error-message">
            Oops! Page Not Found
        </div>
        <div class="error-details">
            The page you are looking for might have been removed or is temporarily unavailable.
        </div>
        <div class="error-buttons">
            <button class="btn_body btn_1" onclick="window.location.href='${pageContext.request.contextPath}/'">Go to Homepage</button>
            <button class="btn_body btn_2" onclick="window.history.back()">Go Back</button>
        </div>
    </div>
</body>

</html>
