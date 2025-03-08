

<!-- Sidebar -->
<aside class="sidebar" id="sidebar">
    <a href="${pageContext.request.contextPath}/admin" class="<%= request.getAttribute("currentPage").equals("dashboard") ? "active_s_btn" : "" %>" ><i class="fas fa-tachometer-alt"></i>Dashboard</a>
    <a href="${pageContext.request.contextPath}/admin/rooms" class="<%= request.getAttribute("currentPage").equals("rooms") ? "active_s_btn" : "" %>"><i class="fas fa-bed"></i>Rooms</a>
    <a href="${pageContext.request.contextPath}/admin/residents" class="<%= request.getAttribute("currentPage").equals("residents") ? "active_s_btn" : "" %>"><i class="bi bi-people-fill"></i>Residents</a>
    <a href="${pageContext.request.contextPath}/admin/payments" class="<%= request.getAttribute("currentPage").equals("payments") ? "active_s_btn" : "" %>"><i class="fas fa-wallet"></i>Payments</a>
    <a href="${pageContext.request.contextPath}/admin/maintenance" class="<%= request.getAttribute("currentPage").equals("maintenance") ? "active_s_btn" : "" %>"><i class="bi bi-house-gear"></i>Maintenance</a>
    <a href="${pageContext.request.contextPath}/admin/users" class="<%= request.getAttribute("currentPage").equals("users") ? "active_s_btn" : "" %>"><i class="bi bi-person-fill-gear""></i>Staff</a>
</aside>