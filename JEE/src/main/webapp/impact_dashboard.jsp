<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau des Impacts</title>
    <link rel="stylesheet" href="styles.css"> <!-- Si vous avez des styles CSS personnalisés -->
</head>
<body>

    <h1>Liste des Impacts</h1>

    <c:if test="${not empty impacts}">
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Type d'Impact</th>
                    <th>Valeur de l'Impact</th>
                    <th>Date de l'Impact</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="impact" items="${impacts}">
                    <tr>
                        <td>${impact.id}</td>
                        <td>${impact.impactType}</td>
                        <td>${impact.impactValue}</td>
                        <td>${impact.impactDate}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <c:if test="${empty impacts}">
        <p>Aucun impact trouvé.</p>
    </c:if>

    <a href="impact?action=addEvent">Ajouter un événement</a>

</body>
</html>
