<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Inscription - GreenCommune</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome pour les icônes -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
          .back-home {
        position: absolute;
        top: 20px;
        left: 20px;
        text-decoration: none;
        color: white;
        font-weight: bold;
        font-size: 18px;
        display: flex;
        align-items: center;
        background: rgba(0,0,0,0.3);
        padding: 8px 12px;
        border-radius: 30px;
        transition: background 0.3s;
    }
    .back-home i {
        margin-right: 8px;
    }
    .back-home:hover {
        background: rgba(0,0,0,0.6);
        color: #ffd700; /* jolie couleur dorée au survol */}
        body {
            background: linear-gradient(rgba(0, 128, 0, 0.6), rgba(0, 128, 0, 0.6)), url('https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=1470&q=80') no-repeat center center/cover;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Poppins', sans-serif;
        }
        .register-box {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.3);
            width: 100%;
            max-width: 450px;
            text-align: center;
        }
        .logo {
            width: 100px;
            margin-bottom: 20px;
        }
        .btn-primary {
            background-color: #28a745;
            border: none;
        }
        .btn-primary:hover {
            background-color: #218838;
        }
        .message {
            margin-top: 10px;
            font-weight: bold;
        }
    </style>
</head>
<body>
<!-- Flèche de retour -->
<a href="index.jsp" class="back-home">
    <i class="fas fa-arrow-left"></i> Accueil
</a>

<div class="register-box">
    <!-- Logo super choc -->
    <img src="https://cdn-icons-png.flaticon.com/512/2909/2909767.png"  class="logo">
    <h2 class="mb-4">Créer un compte 🌿</h2>

    <% if (request.getParameter("error") != null) { %>
        <div class="alert alert-danger">
            <%= request.getParameter("error") %>
        </div>
    <% } %>

    <form action="auth" method="post">
        <input type="hidden" name="action" value="register">

        <div class="mb-3">
            <input type="text" name="fullName" class="form-control" placeholder="Nom complet" required>
        </div>

        <div class="mb-3">
            <input type="text" name="username" class="form-control" placeholder="Nom d'utilisateur" required>
        </div>

        <div class="mb-3">
            <input type="email" name="email" class="form-control" placeholder="Adresse e-mail" required>
        </div>

        <div class="mb-3">
            <input type="password" name="password" class="form-control" placeholder="Mot de passe" required>
        </div>

        <div class="d-grid">
            <button type="submit" class="btn btn-primary btn-block">S'inscrire</button>
        </div>
    </form>

    <p class="mt-3">Déjà inscrit ? <a href="login.jsp">Connectez-vous ici</a></p>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
