

<!-- Sidebar -->
<aside class="sidebar" id="sidebar">
    <a href="${pageContext.request.contextPath}/Dashboard" class="<%= request.getAttribute("currentPage").equals("dashboard") ? "active_s_btn" : "" %>" ><i class="fas fa-tachometer-alt"></i>Dashboard</a>
    <a href="${pageContext.request.contextPath}/admin/rooms" class="<%= request.getAttribute("currentPage").equals("rooms") ? "active_s_btn" : "" %>">Rooms</a>
    <a href="#" class="<%= request.getAttribute("currentPage").equals("Residents") ? "active_s_btn" : "" %>">Residents</a>
    <a href="#" class="<%= request.getAttribute("currentPage").equals("Payments") ? "active_s_btn" : "" %>">Payments</a>
    <a href="#" class="<%= request.getAttribute("currentPage").equals("Maintenance") ? "active_s_btn" : "" %>">Maintenance</a>
    <a href="#" class="<%= request.getAttribute("currentPage").equals("Statistics") ? "active_s_btn" : "" %>">Statistics</a>
    <a href="#" class="<%= request.getAttribute("currentPage").equals("Statistics") ? "active_s_btn" : "" %>">Reports</a>
</aside>