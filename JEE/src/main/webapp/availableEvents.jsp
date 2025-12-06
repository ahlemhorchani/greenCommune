<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Event" %>
<%
    List<Event> events = (List<Event>) request.getAttribute("events");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Événements Disponibles - GreenCommune</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/vanta@latest/dist/vanta.globe.min.js"></script>
    <style>
        :root {
            --primary: #00ff88;
            --primary-light: #00e676;
            --secondary: #00b4d8;
            --tertiary: #7209b7;
            --dark: #0a0a0a;
            --light: #f8f9fa;
            --glass: rgba(255, 255, 255, 0.15);
            --glass-border: rgba(255, 255, 255, 0.25);
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #0f0c29, #302b63, #24243e);
            color: var(--light);
            margin: 0;
            padding: 0;
            overflow-x: hidden;
            min-height: 100vh;
        }
        
        #vanta-bg {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            opacity: 0.6;
        }
        
        .floating-particles {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: -1;
        }
        
        .floating-particle {
            position: absolute;
            width: 8px;
            height: 8px;
            background: var(--primary);
            border-radius: 50%;
            filter: blur(1px);
            opacity: 0.5;
            animation: float 15s infinite linear;
        }
        
        @keyframes float {
            0% {
                transform: translateY(0) rotate(0deg) scale(1);
            }
            50% {
                transform: translateY(-100px) rotate(180deg) scale(1.5);
            }
            100% {
                transform: translateY(0) rotate(360deg) scale(1);
            }
        }
        
        .header {
            text-align: center;
            padding: 60px 20px 40px;
            position: relative;
            z-index: 10;
            margin-bottom: 40px;
        }
        
        .header h1 {
            font-size: 3.2rem;
            margin: 0;
            background: linear-gradient(45deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            display: inline-block;
            position: relative;
            font-weight: 700;
        }
        
        .header h1::after {
            content: '';
            position: absolute;
            bottom: -15px;
            left: 50%;
            transform: translateX(-50%);
            width: 120px;
            height: 4px;
            background: linear-gradient(90deg, var(--primary), var(--tertiary));
            border-radius: 2px;
            animation: rainbow 8s linear infinite;
            background-size: 400% 400%;
        }
        
        @keyframes rainbow {
            0% { background-position: 0% 50%; }
            100% { background-position: 100% 50%; }
        }
        
        .header p {
            font-size: 1.2rem;
            color: var(--light);
            max-width: 700px;
            margin: 25px auto 0;
            opacity: 0.9;
            line-height: 1.6;
        }
        
        .events-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 30px;
            padding: 0 40px 60px;
            max-width: 1400px;
            margin: 0 auto;
            position: relative;
            z-index: 10;
        }
        
        .event-card {
            background: var(--glass);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
            transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
            overflow: hidden;
            border: 1px solid var(--glass-border);
            transform-style: preserve-3d;
            transform: perspective(1000px);
        }
        
        .event-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(0, 255, 136, 0.1), rgba(0, 180, 216, 0.1));
            z-index: -1;
            opacity: 0;
            transition: opacity 0.5s ease;
        }
        
        .event-card:hover {
            transform: perspective(1000px) translateY(-10px) rotateX(5deg) rotateY(5deg);
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.4);
        }
        
        .event-card:hover::before {
            opacity: 1;
        }
        
        .event-card h3 {
            color: var(--primary);
            margin-top: 0;
            font-size: 1.8rem;
            position: relative;
            display: inline-block;
            font-weight: 600;
        }
        
        .event-card h3::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 0;
            width: 50px;
            height: 3px;
            background: var(--secondary);
            border-radius: 3px;
            transition: width 0.3s ease;
        }
        
        .event-card:hover h3::after {
            width: 100px;
        }
        
        .event-card p {
            color: rgba(255, 255, 255, 0.8);
            margin-bottom: 20px;
            line-height: 1.6;
        }
        
        .event-meta {
            display: flex;
            align-items: center;
            margin: 15px 0;
            color: var(--secondary);
            font-size: 1rem;
        }
        
        .event-meta i {
            margin-right: 12px;
            font-size: 1.2rem;
            width: 20px;
            text-align: center;
        }
        
        .btn-inscrire {
            background: linear-gradient(45deg, var(--primary), var(--secondary));
            color: var(--dark);
            padding: 12px 30px;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            font-weight: 600;
            margin-top: 20px;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 20px rgba(0, 255, 136, 0.3);
            position: relative;
            overflow: hidden;
            font-size: 1rem;
        }
        
        .btn-inscrire:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 30px rgba(0, 255, 136, 0.5);
        }
        
        .btn-inscrire:active {
            transform: translateY(1px);
        }
        
        .btn-inscrire::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(45deg, var(--secondary), var(--tertiary));
            z-index: -1;
            opacity: 0;
            transition: opacity 0.3s ease;
        }
        
        .btn-inscrire:hover::after {
            opacity: 1;
        }
        
        .btn-inscrire i {
            margin-left: 10px;
            transition: transform 0.3s ease;
        }
        
        .btn-inscrire:hover i {
            transform: translateX(5px);
        }
        
        .notification {
            position: fixed;
            top: 30px;
            right: 30px;
            background: var(--primary);
            color: var(--dark);
            padding: 15px 25px;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 255, 136, 0.4);
            display: flex;
            align-items: center;
            z-index: 1000;
            transform: translateX(150%);
            transition: transform 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            font-weight: 600;
        }
        
        .notification.show {
            transform: translateX(0);
        }
        
        .notification i {
            margin-right: 12px;
            font-size: 1.5rem;
        }
        
        footer {
            background: var(--glass);
            backdrop-filter: blur(10px);
            padding: 20px;
            text-align: center;
            font-size: 1rem;
            border-top: 1px solid var(--glass-border);
            position: relative;
            z-index: 10;
            margin-top: 60px;
        }
        
        @media (max-width: 768px) {
            .header h1 {
                font-size: 2.2rem;
            }
            
            .header p {
                font-size: 1rem;
            }
            
            .events-container {
                grid-template-columns: 1fr;
                padding: 0 20px 40px;
            }
            
            .event-card {
                padding: 25px;
            }
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

    <div id="vanta-bg"></div>
    
    <div class="floating-particles">
        <div class="floating-particle" style="top:10%; left:15%; animation-delay:0s;"></div>
        <div class="floating-particle" style="top:75%; left:85%; animation-delay:2s;"></div>
        <div class="floating-particle" style="top:35%; left:65%; animation-delay:4s;"></div>
        <div class="floating-particle" style="top:85%; left:25%; animation-delay:6s;"></div>
        <div class="floating-particle" style="top:60%; left:50%; animation-delay:1s;"></div>
        <div class="floating-particle" style="top:25%; left:75%; animation-delay:3s;"></div>
    </div>
  
    <div class="header">
        <h1>Événements Écologiques</h1>
        <p>Rejoignez notre communauté engagée et participez à des événements qui font la différence pour notre planète.</p>
    </div>
      
    
    
    <% if ("1".equals(request.getParameter("success"))) { %>
        <div class="notification" id="success-notification">
            <i class="fas fa-check-circle"></i>
            <span>Inscription confirmée ! Merci pour votre engagement 🌱</span>
        </div>
    <% } %>
     <a href="user_dashboard.jsp" class="back-home">
        <i class="fas fa-arrow-left"></i> Retour
    </a>

    <div class="events-container">
        <% for(Event event : events) { %>
            <div class="event-card">
                <h3><i class="fas fa-leaf" style="margin-right: 10px; color: var(--primary);"></i><%= event.getTitle() %></h3>
                <p><%= event.getDescription() %></p>
                
                <div class="event-meta">
                    <i class="far fa-calendar-alt"></i>
                    <span><%= event.getEventDate() %></span>
                </div>
                
                <div class="event-meta">
                    <i class="fas fa-map-marker-alt"></i>
                    <span><%= event.getLocation() %></span>
                </div>
                
                <form method="post" action="register">
                    <input type="hidden" name="eventId" value="<%= event.getId() %>"/>
                    <button class="btn-inscrire" type="submit">
                        Participer <i class="fas fa-arrow-right"></i>
                    </button>
                </form>
            </div>
        <% } %>
    </div>

    <footer>
        <p>🌍 GreenCommune © 2025 - Ensemble pour un futur durable 🌱</p>
    </footer>

    <script>
        // Initialisation de l'animation 3D en arrière-plan
        VANTA.GLOBE({
            el: "#vanta-bg",
            mouseControls: true,
            touchControls: true,
            gyroControls: false,
            minHeight: 200.00,
            minWidth: 200.00,
            scale: 1.00,
            scaleMobile: 1.00,
            color: 0x00ff88,
            backgroundColor: 0x0f0c29,
            size: 0.8
        });
        
        // Animation des cartes au chargement
        document.addEventListener('DOMContentLoaded', () => {
            const cards = document.querySelectorAll('.event-card');
            cards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'perspective(1000px) translateY(50px) rotateX(30deg)';
                card.style.transition = `all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275) ${index * 0.1}s`;
                
                setTimeout(() => {
                    card.style.opacity = '1';
                    card.style.transform = 'perspective(1000px) translateY(0) rotateX(0)';
                }, 100);
            });
            
            // Affichage de la notification si succès
            const notification = document.getElementById('success-notification');
            if (notification) {
                setTimeout(() => {
                    notification.classList.add('show');
                    
                    setTimeout(() => {
                        notification.classList.remove('show');
                    }, 5000);
                }, 1000);
            }
        });
        
        // Effet de parallaxe sur les cartes
        document.addEventListener('mousemove', (e) => {
            const cards = document.querySelectorAll('.event-card');
            const centerX = window.innerWidth / 2;
            const centerY = window.innerHeight / 2;
            
            cards.forEach(card => {
                const rect = card.getBoundingClientRect();
                const cardCenterX = rect.left + rect.width / 2;
                const cardCenterY = rect.top + rect.height / 2;
                
                const moveX = (cardCenterX - e.clientX) / 50;
                const moveY = (cardCenterY - e.clientY) / 50;
                
                card.style.transform = `perspective(1000px) rotateY(${moveX}deg) rotateX(${-moveY}deg) translateY(-10px)`;
            });
        });
    </script>
</body>
</html>