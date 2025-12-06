<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Connexion - GreenCommune</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Quicksand:wght@400;600&display=swap');

        body {
            margin: 0;
            padding: 0;
            font-family: 'Quicksand', sans-serif;
            background: linear-gradient(180deg, #e0ffe0, #ccffcc);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
        }

        .bubbles {
            position: absolute;
            top: 0; left: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: 0;
        }

        .bubble {
            position: absolute;
            bottom: -100px;
            width: 40px;
            height: 40px;
            background: rgba(50, 168, 82, 0.3);
            border-radius: 50%;
            animation: rise 20s infinite ease-in;
        }

        @keyframes rise {
            0% { transform: translateY(0) translateX(0);}
            100% { transform: translateY(-110vh) translateX(100px);}
        }

        .login-container {
            background: #ffffff;
            padding: 50px 40px;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            width: 350px;
            z-index: 1;
            text-align: center;
        }

        .login-container h2 {
            margin-bottom: 20px;
            color: #32a852;
            font-weight: 600;
        }

        .login-container input {
            width: 100%;
            padding: 15px;
            margin: 12px 0;
            border: 1px solid #ccc;
            border-radius: 10px;
            font-size: 15px;
            background: #f9f9f9;
        }

        .login-container button {
            width: 100%;
            padding: 14px;
            margin-top: 20px;
            background: linear-gradient(90deg, #32a852, #62d572);
            border: none;
            border-radius: 10px;
            color: white;
            font-size: 16px;
            font-weight: bold;
            letter-spacing: 1px;
            cursor: pointer;
            transition: background 0.3s, transform 0.2s;
        }

        .login-container button:hover {
            background: linear-gradient(90deg, #289b46, #4ccf64);
            transform: scale(1.05);
        }

        .alert {
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 10px;
            font-size: 14px;
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-danger {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .login-container p {
            margin-top: 20px;
            font-size: 14px;
        }

        .login-container a {
            color: #32a852;
            text-decoration: none;
            font-weight: bold;
        }

        .login-container a:hover {
            text-decoration: underline;
        }
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
    </style>
</head>
<body>

<div class="bubbles">
    <div class="bubble" style="left: 10%; animation-delay: 0s;"></div>
    <div class="bubble" style="left: 30%; animation-delay: 2s;"></div>
    <div class="bubble" style="left: 50%; animation-delay: 4s;"></div>
    <div class="bubble" style="left: 70%; animation-delay: 6s;"></div>
    <div class="bubble" style="left: 90%; animation-delay: 8s;"></div>
     <div class="bubble" style="left: 10%; animation-delay: 8s;"></div>
    <div class="bubble" style="left: 30%; animation-delay: 0s;"></div>
    <div class="bubble" style="left: 50%; animation-delay: 6s;"></div>
    <div class="bubble" style="left: 70%; animation-delay: 2s;"></div>
    <div class="bubble" style="left: 90%; animation-delay: 4s;"></div>
</div>
<a href="index.jsp" class="back-home">
    <i class="fas fa-arrow-left"></i> Accueil
</a>

<div class="login-container">
    <h2>Bienvenue 🌿</h2>

    <c:if test="${not empty param.message}">
        <div class="alert alert-success">
            ${param.message}
        </div>
    </c:if>

    <c:if test="${not empty param.error}">
        <div class="alert alert-danger">
            ${param.error}
        </div>
    </c:if>

    <form action="auth" method="post">
        <input type="hidden" name="action" value="login">
        <input type="email" name="email" placeholder="Adresse Email" required>
        <input type="password" name="password" placeholder="Mot de passe" required>
        <button type="submit">Connexion</button>
    </form>

    <p>Pas de compte ? <a href="register.jsp">Créer un compte</a></p>
</div>

</body>
</html>
