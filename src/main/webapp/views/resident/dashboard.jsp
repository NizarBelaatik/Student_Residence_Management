<%-- 
    Document   : dashboard
    Created on : Dec 13, 2024, 9:54:43 PM
    Author     : night
--%>

<%
    String currentPage = "dashboard";  // or any dynamic value
    request.setAttribute("currentPage", currentPage);
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
        

                <!-- Google Fonts -->
        <link href="https://fonts.gstatic.com" rel="preconnect">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,700">
        
        
        <link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/fontawesome.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/bootstrap.min.css"> 
        <link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/template-style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/component/css/style.css">

        

        
        


        <!-- Boxicons CSS -->
        <link href='https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css' rel='stylesheet'>
        
    </head>
    <body>
        <!-- Header -->
    
    <%@ include file="/views/header.jsp" %>
    <%@ include file="/views/side_bar.jsp" %>

    <!-- Main content -->
    <main class="main" id="main">
        
        <h1>Welcome</h1>
        <p>This is the main content aressssa.</p>
    </main>

    
    <script src="${pageContext.request.contextPath}/component/js/script.js"></script>    
    </body>
</html>
