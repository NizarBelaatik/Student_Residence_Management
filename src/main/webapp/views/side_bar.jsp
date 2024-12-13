

<!-- Sidebar -->
<aside class="sidebar" id="sidebar">
    <a href="#" class="<%= request.getAttribute("currentPage").equals("dashboard") ? "active" : "" %>" >Dashboard</a>
    <a href="#" class="<%= request.getAttribute("currentPage").equals("Rooms") ? "active" : "" %>">Rooms</a>
    <a href="#" class="<%= request.getAttribute("currentPage").equals("Residents") ? "active" : "" %>">Residents</a>
    <a href="#" class="<%= request.getAttribute("currentPage").equals("Payments") ? "active" : "" %>">Payments</a>
    <a href="#" class="<%= request.getAttribute("currentPage").equals("Maintenance") ? "active" : "" %>">Maintenance</a>
    <a href="#" class="<%= request.getAttribute("currentPage").equals("Statistics") ? "active" : "" %>">Statistics</a>
</aside>