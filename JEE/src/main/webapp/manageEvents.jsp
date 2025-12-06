<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>🌱 GreenCommune | Événements</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root {
            --primary: #2e8b57; /* Ton vert Sea Green */
            --accent: #3CB371;  /* Un vert plus clair pour contraste */
            --bg-light: #F4FDF4; /* Légèrement vert pâle */
            --text-dark: #2c3e50;
            --text-light: #7f8c8d;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: var(--bg-light);
            color: var(--text-dark);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 50px 20px;
        }

        .back-button {
            position: absolute;
            top: 20px;
            left: 20px;
            background: var(--primary);
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            box-shadow: 0 4px 10px rgba(0,0,0,0.15);
            transition: background 0.3s ease;
        }

        .back-button:hover {
            background: #246b45; /* Un peu plus foncé au hover */
        }

        h1 {
            font-size: 2.5rem;
            margin-bottom: 30px;
            color: var(--primary);
        }

        .container {
            width: 95%;
            max-width: 1200px;
            background: white;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            text-align: left;
            padding: 18px 14px;
            font-size: 15px;
            color: var(--text-dark);
        }

        th {
            background: var(--primary);
            color: white;
            font-weight: 600;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }

        tr {
            border-bottom: 1px solid #eee;
            transition: background-color 0.2s;
        }

        tr:hover {
            background-color: #ecf9f1;
        }

        tr:last-child {
            border-bottom: none;
        }

        .actions a {
            padding: 8px 14px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            font-size: 14px;
            transition: background 0.3s ease;
            margin-right: 8px;
            display: inline-flex;
            align-items: center;
        }

        .edit-btn {
            background: var(--accent);
            color: white;
        }

        .edit-btn:hover {
            background: #2e8b57;
        }

        .delete-btn {
            background: #E53935;
            color: white;
        }

        .delete-btn:hover {
            background: #C62828;
        }
        /* Style pour la conteneur principal */
.export-container {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 20px;
}

/* Style du formulaire */
.pdf-export-form {
    display: inline-block;
    text-align: center;
}

/* Style du bouton d'exportation */
.pdf-export-btn {
    background-color: #d32f2f; /* Rouge vif */
    color: white;
    border: none;
    padding: 10px 20px;
    font-size: 16px;
    cursor: pointer;
    border-radius: 5px;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: background-color 0.3s ease;
}

/* Style du bouton au survol */
.pdf-export-btn:hover {
    background-color: #b71c1c; /* Rouge foncé */
}

/* Style de l'icône */
.pdf-export-btn i {
    margin-right: 8px; /* Espacement entre l'icône et le texte */
    font-size: 18px;
}

/* Style pour un affichage responsive */
@media (max-width: 768px) {
    .pdf-export-btn {
        font-size: 14px;
        padding: 8px 16px;
    }
}
        

        .no-events {
            text-align: center;
            color: var(--text-light);
            font-size: 18px;
            margin-top: 20px;
        }
        .add-button {
    display: inline-block;
    margin-bottom: 20px;
    background: var(--accent);
    color: white;
    padding: 12px 24px;
    border-radius: 8px;
    text-decoration: none;
    font-weight: 600;
    font-size: 16px;
    transition: background 0.3s ease;
}
.add-button:hover {
    background: #2e8b57;
}
        
    </style>
</head>
<body>

<a href="admin_dashboard.jsp" class="back-button">
    <i class="fas fa-arrow-left"></i> Retour
</a>

<h1>📅 Liste des Événements</h1>
<a href="event_form.jsp" class="add-button">
    <i class="fas fa-plus"></i> Ajouter un événement
</a>

<div class="container">
    <c:if test="${not empty events}">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Titre</th>
                    <th>Description</th>
                    <th>Date</th>
                    <th>Lieu</th>
                    <th>Impact</th>
                    <th>Valeur</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="event" items="${events}">
                    <tr>
                        <td>${event.id}</td>
                        <td>${event.title}</td>
                        <td>${event.description}</td>
                        <td>${event.eventDate}</td>
                        <td>${event.location}</td>
                        <td>${event.impactType}</td>
                        <td>${event.impactValue}</td>
                        <td class="actions">
                            
                            <a href="events?action=edit&id=${event.id}" class="edit-btn">
    <i class="fas fa-edit"></i> Modifier
</a>
<a href="events?action=delete&id=${event.id}" class="delete-btn">
    <i class="fas fa-trash"></i> Supprimer
</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <c:if test="${empty events}">
        <div class="no-events">
            Aucun événement trouvé 😔.
        </div>
    </c:if>
      <div style="margin-top: 20px; text-align: right;">
    <a href="users?action=exportPdff" style="background-color: #28a745; color: white; padding: 10px 20px; text-decoration: none; border-radius: 8px; font-weight: bold; box-shadow: 2px 2px 8px rgba(0,0,0,0.2); transition: 0.3s;">
        📄 Exporter PDF des événements
    </a>
</div>
</div>

</body>
</html>
