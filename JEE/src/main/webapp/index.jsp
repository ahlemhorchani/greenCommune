<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Accueil - GreenCommune</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome pour les icônes -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }
        .hero {
            background: url('https://images.unsplash.com/photo-1503264116251-35a269479413?auto=format&fit=crop&w=1470&q=80') no-repeat center center/cover;
            height: 90vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.8);
        }
        .section-title {
            margin-top: 60px;
            margin-bottom: 30px;
            text-align: center;
        }
        footer {
            background-color: #343a40;
            color: white;
            padding: 20px 0;
            text-align: center;
            margin-top: 50px;
        }
        .navbar-brand {
            font-weight: bold;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
  <div class="container">
    <a class="navbar-brand" href="#">GreenCommune</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link active" href="#home">Accueil</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="login.jsp">Connexion</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="register.jsp">Inscription</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#contact">Contact</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<!-- Hero Section -->
<section class="hero" id="home">
  <div class="text-center">
    <h1 class="display-4">Bienvenue sur GreenCommune</h1>
    <p class="lead">Participez à la transition écologique de votre communauté !</p>
    <a href="register.jsp" class="btn btn-success btn-lg mt-4">Rejoignez-nous</a>
  </div>
</section>

<!-- À propos -->
<section class="container my-5">
  <div class="section-title">
    <h2>Notre Mission</h2>
    <p>Nous aidons les citoyens à organiser des initiatives écologiques locales pour un avenir meilleur.</p>
  </div>
  <div class="row text-center">
    <div class="col-md-4">
      <i class="fas fa-leaf fa-3x text-success mb-3"></i>
      <h4>Écologie</h4>
      <p>Des actions concrètes pour protéger notre planète.</p>
    </div>
    <div class="col-md-4">
      <i class="fas fa-users fa-3x text-primary mb-3"></i>
      <h4>Communauté</h4>
      <p>Unissons nos forces pour avoir plus d'impact.</p>
    </div>
    <div class="col-md-4">
      <i class="fas fa-bolt fa-3x text-warning mb-3"></i>
      <h4>Innovation</h4>
      <p>Utilisez la technologie pour accélérer le changement.</p>
    </div>
  </div>
</section>

<!-- Contact -->
<section class="container my-5" id="contact">
  <div class="section-title">
    <h2>Contactez-nous</h2>
  </div>
  <form>
    <div class="row mb-3">
      <div class="col">
        <input type="text" class="form-control" placeholder="Nom complet" required>
      </div>
      <div class="col">
        <input type="email" class="form-control" placeholder="Adresse e-mail" required>
      </div>
    </div>
    <div class="mb-3">
      <textarea class="form-control" rows="5" placeholder="Votre message..." required></textarea>
    </div>
    <button type="submit" class="btn btn-primary">Envoyer</button>
  </form>
</section>

<!-- Footer -->
<footer>
  <p>&copy; 2025 GreenCommune. Tous droits réservés.</p>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
