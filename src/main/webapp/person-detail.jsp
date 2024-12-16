<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Person Details</title>
</head>
<body>
    <h2>Person Details</h2>
    <p>ID: ${person.id}</p>
    <p>Name: ${person.name}</p>
    <p>Age: ${person.age}</p>
    <a href="person?action=list">Back to List</a>
</body>
</html>
