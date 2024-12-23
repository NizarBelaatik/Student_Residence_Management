

<!-- Sidebar -->
<aside class="sidebar" id="sidebar">
    <a href="${pageContext.request.contextPath}/admin" class="<%= request.getAttribute("currentPage").equals("dashboard") ? "active_s_btn" : "" %>" ><i class="fas fa-tachometer-alt"></i>Dashboard</a>
    <a href="${pageContext.request.contextPath}/admin/rooms" class="<%= request.getAttribute("currentPage").equals("rooms") ? "active_s_btn" : "" %>"><i class="fas fa-bed"></i>Rooms</a>
    <a href="${pageContext.request.contextPath}/admin/residents" class="<%= request.getAttribute("currentPage").equals("residents") ? "active_s_btn" : "" %>"><i class="bi bi-people-fill"></i>Residents</a>
    <a href="#" class="<%= request.getAttribute("currentPage").equals("Payments") ? "active_s_btn" : "" %>"><i class="fas fa-wallet"></i>Payments</a>
    <a href="#" class="<%= request.getAttribute("currentPage").equals("Maintenance") ? "active_s_btn" : "" %>"><i class="bi bi-house-gear"></i>Maintenance</a>
    <a href="#" class="<%= request.getAttribute("currentPage").equals("Statistics") ? "active_s_btn" : "" %>"><i class="bi bi-graph-up"></i>Statistics</a>
    <a href="#" class="<%= request.getAttribute("currentPage").equals("Statistics") ? "active_s_btn" : "" %>"><i class="bi bi-file-earmark-text-fill"></i>Reports</a>
</aside>