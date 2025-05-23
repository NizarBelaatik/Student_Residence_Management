<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%
    String csrfToken = (String) session.getAttribute("csrfToken");
    if (csrfToken == null) {
        csrfToken = ""; // You can either set an empty string or handle it as needed
    }
%>
<meta name="csrf-token" content="<%= csrfToken %>">

<link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/style_2.css">

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



<link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/style_2.css">






