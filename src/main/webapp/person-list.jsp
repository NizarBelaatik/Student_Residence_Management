<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Person List</title>
</head>
<body>
    <h2>Person List</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Age</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="person" items="${persons}">
            <tr>
                <td>${person.id}</td>
                <td>${person.name}</td>
                <td>${person.age}</td>
                <td>
                    <a href="person?id=${person.id}">View</a>
                    <a href="person/delete?id=${person.id}" onclick="return confirm('Are you sure?');">Delete</a>
                </td>
            </tr>
        </c:forEach>
    </table>
    <a href="create-person.jsp">Create New Person</a>
</body>
</html>
