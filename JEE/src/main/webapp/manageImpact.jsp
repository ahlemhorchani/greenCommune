<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Impact" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Gérer Impacts - GreenCommune Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
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
    
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: #f4f7f6;
        }

        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 220px;
            height: 100%;
            background: #2e8b57;
            padding-top: 20px;
            box-shadow: 2px 0 10px rgba(0,0,0,0.2);
        }

        .sidebar a {
            display: block;
            color: white;
            padding: 15px 20px;
            text-decoration: none;
            font-size: 16px;
            margin-bottom: 10px;
            transition: background 0.3s;
        }

        .sidebar a:hover {
            background: #256d46;
        }

        .main {
            margin-left: 240px;
            padding: 30px;
        }

        .topbar {
            background: white;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0px 2px 10px rgba(0,0,0,0.1);
        }

        .topbar h1 {
            margin: 0;
            font-size: 24px;
            color: #2e8b57;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
            background: white;
            box-shadow: 0px 2px 10px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 15px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #2e8b57;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

    </style>
</head>

<body>

    <!-- Sidebar -->
    <div class="sidebar">
        <h2 style="color:white; text-align:center; margin-bottom:30px;">Admin</h2>
        <a href="users?action=list"><i class="fas fa-users"></i> Gérer Utilisateurs</a>
        <a href="events?action=list"><i class="fas fa-calendar-alt"></i> Gérer Événements</a>
        <a href="manageReports.jsp"><i class="fas fa-flag"></i> Gérer Signalements</a>
        <a href="manageImpact.jsp"><i class="fas fa-leaf"></i> Suivi Écologique</a>
        <a href="viewStats.jsp"><i class="fas fa-chart-line"></i> Statistiques</a>
        <a href="logout.jsp" class="logout"><i class="fas fa-sign-out-alt"></i> Déconnexion</a>
    </div>

    <!-- Main Content -->
    <div class="main">
        <div class="topbar">
            <h1>Suivi de l'Impact Écologique</h1>
        </div>

        <table>
            <thead>
                <tr>
                    <th>ID Impact</th>
                    <th>ID Utilisateur</th>
                    <th>Type d'Impact</th>
                    <th>Valeur</th>
                    <th>Date</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="impact" items="${impacts}">
                    <tr>
                        <td>${impact.id}</td>
                        <td>${impact.userId}</td>
                        <td>${impact.impactType}</td>
                        <td>${impact.impactValue}</td>
                        <td>${impact.impactDate}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
       <div class="export-container">
    <form method="get" action="exportpdf" class="pdf-export-form">
        <button type="submit" class="pdf-export-btn">
            <i class="fas fa-file-pdf"></i> Exporter en PDF
        </button>
    </form>
</div>
    </div>

</body>
</html>
