<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>List of Persons</title>
</head>
<body>
    <h2>Persons List</h2>
    
    <!-- Add New Person Form -->
    <form action="/persons" method="post">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required/>
        <label for="age">Age:</label>
        <input type="number" id="age" name="age" required/>
        <button type="submit">Add Person</button>
    </form>
    
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Age</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <!-- Loop through persons and display each one -->
            <c:forEach var="person" items="${persons}">
                <tr>
                    <td>${person.id}</td>
                    <td>${person.name}</td>
                    <td>${person.age}</td>
                    <td>
                        <!-- Delete person button -->
                        <form action="/persons" method="post">
                            <input type="hidden" name="_method" value="delete" />
                            <input type="hidden" name="id" value="${person.id}" />
                            <button type="submit">Delete</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
