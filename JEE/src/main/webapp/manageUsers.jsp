<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Gérer les Utilisateurs - GreenCommune</title>

    <!-- FontAwesome pour icônes -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
       * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f4f7f6;
            margin: 0;
            padding: 20px;
        }

        h1 {
            color: #2e8b57;
            text-align: center;
            margin-bottom: 30px;
        }

        .table-container {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0px 2px 10px rgba(0,0,0,0.1);
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th, td {
            padding: 12px 15px;
            text-align: center;
        }

        th {
            background-color: #2e8b57;
            color: white;
            font-weight: bold;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #d4edda;
            cursor: pointer;
        }

        .btn {
            padding: 8px 12px;
            border: none;
            border-radius: 8px;
            color: white;
            background-color: #2e8b57;
            text-decoration: none;
            font-size: 14px;
            margin: 0 5px;
            transition: background 0.3s;
        }

        .btn:hover {
            background-color: #256d46;
        }

        .btn-danger {
            background-color: #e74c3c;
        }
          :root {
            --primary: #2e8b57; /* Ton vert Sea Green */
            --accent: #3CB371;  /* Un vert plus clair pour contraste */
            --bg-light: #F4FDF4; /* Légèrement vert pâle */
            --text-dark: #2c3e50;
            --text-light: #7f8c8d;
        }

        .btn-danger:hover {
            background-color: #c0392b;
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
        

        .actions {
            display: flex;
            justify-content: center;
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


    </style>
</head>

<body>
<a href="admin_dashboard.jsp" class="back-button">
    <i class="fas fa-arrow-left"></i> Retour
</a>


    <h1>Liste des Utilisateurs</h1>

<a href="user_form.jsp" class="add-button">
    <i class="fas fa-plus"></i> Ajouter un utilisateur
</a>
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nom</th>
                    <th>Email</th>
                    <th>Rôle</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Object usersObj = request.getAttribute("users");
                    List<User> users = null;

                    if (usersObj instanceof List) {
                        users = (List<User>) usersObj;
                    }

                    if (users != null && !users.isEmpty()) {
                        for (User user : users) {
                %>
                <tr>
                    <td><%= user.getId() %></td>
                    <td><%= user.getFullName() %></td>
                    <td><%= user.getEmail() %></td>
                    <td><%= user.getRole() %></td>
                    <td class="actions">
                        <a href="users?action=delete&id=<%= user.getId() %>" class="btn btn-danger">
    <i class="fas fa-trash"></i> Supprimer
</a>
                        
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="5">Aucun utilisateur trouvé.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
      <div style="margin-top: 20px; text-align: right;">
    <a href="users?action=exportPdf" style="background-color: #28a745; color: white; padding: 10px 20px; text-decoration: none; border-radius: 8px; font-weight: bold; box-shadow: 2px 2px 8px rgba(0,0,0,0.2); transition: 0.3s;">
        📄 Exporter PDF des utilisateurs
    </a>
</div>

</div>
    </div>

</body>
</html>
