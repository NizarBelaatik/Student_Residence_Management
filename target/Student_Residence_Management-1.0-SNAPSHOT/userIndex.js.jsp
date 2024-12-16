<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>List of Persons</title>
</head>
<body>
    <h1>List of Persons</h1>
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Age</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="person" items="${persons}">
                <tr>
                    <td>${person.id}</td>
                    <td>${person.name}</td>
                    <td>${person.age}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <br>

    <form action="/persons" method="POST">
        <label for="name">Name:</label>
        <input type="text" name="name" required>
        
        <label for="age">Age:</label>
        <input type="number" name="age" required>
        
        <button type="submit">Add Person</button>
    </form>
</body>
</html>