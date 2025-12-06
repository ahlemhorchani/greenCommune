<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Admin Dashboard - GreenCommune</title>

    <!-- FontAwesome pour les icônes -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
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

        .cards {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-top: 30px;
        }

        .card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0px 2px 10px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card i {
            font-size: 30px;
            margin-bottom: 10px;
            color: #2e8b57;
        }

        .card h3 {
            margin: 0;
            font-size: 20px;
            color: #333;
        }

        .card p {
            margin-top: 8px;
            color: gray;
            font-size: 14px;
        }

        .logout {
            color: red;
            font-weight: bold;
            text-align: center;
            margin-top: 20px;
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
        <a href="impact?action=list"><i class="fas fa-leaf"></i> Suivi Écologique</a>
        <a href="viewStats.jsp"><i class="fas fa-chart-line"></i> Statistiques</a>
        <a href="logo"><i class="fas fa-sign-out-alt"></i> Déconnexion</a>
    </div>

    <!-- Main Content -->
    <div class="main">
        <div class="topbar">
            <h1>Bienvenue sur GreenCommune Admin</h1>
        </div>

        <div class="cards">
            <div class="card">
                <i class="fas fa-users"></i>
                <h3>Utilisateurs</h3>
                <p>Gérez les membres inscrits sur la plateforme.</p>
            </div>

            <div class="card">
                <i class="fas fa-calendar-alt"></i>
                <h3>Événements</h3>
                <p>Organisez et suivez vos événements écologiques.</p>
            </div>

            <div class="card">
                <i class="fas fa-flag"></i>
                <h3>Signalements</h3>
                <p>Gérez les rapports de problèmes ou abus.</p>
            </div>

            <div class="card">
                <i class="fas fa-leaf"></i>
                <h3>Impact Écologique</h3>
                <p>Suivez l'impact environnemental de vos actions.</p>
            </div>

            <div class="card">
                <i class="fas fa-chart-line"></i>
                <h3>Statistiques</h3>
                <p>Analysez les performances et données de la plateforme.</p>
            </div>

            <div class="card">
                <i class="fas fa-cogs"></i>
                <h3>Paramètres</h3>
                <p>Configurez les options administratives.</p>
            </div>
        
      
        
<div class="card" onclick="window.location.href='WeatherServlet?city=Tunis'">
    <div class="stats-badge"><i class="fas fa-sun"></i></div>
    <i class="fas fa-cloud-sun-rain"></i>
    <h2>Météo Écologique</h2>
    <p>Consultez les conditions météo locales pour planifier les actions durables au bon moment.</p>
    <canvas id="weatherChart"></canvas>
</div>

    </div>

</body>
</html>
