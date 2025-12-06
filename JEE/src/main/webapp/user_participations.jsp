<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Participation" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Mes Participations - GreenCommune</title>
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
            0% { transform: translateY(0) rotate(0deg) scale(1); }
            50% { transform: translateY(-100px) rotate(180deg) scale(1.5); }
            100% { transform: translateY(0) rotate(360deg) scale(1); }
        }

        .header {
            text-align: center;
            padding: 80px 20px 40px;
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

        .participation-container {
            max-width: 1000px;
            margin: 0 auto 60px;
            padding: 0 20px;
            position: relative;
            z-index: 10;
        }

        .participation-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 15px;
        }

        .participation-table thead th {
            background: var(--glass);
            backdrop-filter: blur(10px);
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: var(--primary);
            border: 1px solid var(--glass-border);
            position: sticky;
            top: 0;
            z-index: 10;
        }

        .participation-table tbody tr {
            background: var(--glass);
            backdrop-filter: blur(10px);
            border-radius: 10px;
            transition: all 0.3s ease;
            transform-style: preserve-3d;
        }

        .participation-table tbody tr:hover {
            transform: translateY(-5px) rotateX(5deg);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
        }

        .participation-table td {
            padding: 15px;
            border: 1px solid var(--glass-border);
            border-style: solid none;
            vertical-align: middle;
        }

        .participation-table td:first-child {
            border-left-style: solid;
            border-top-left-radius: 10px;
            border-bottom-left-radius: 10px;
        }

        .participation-table td:last-child {
            border-right-style: solid;
            border-top-right-radius: 10px;
            border-bottom-right-radius: 10px;
        }

        .participation-badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 50px;
            background: rgba(0, 255, 136, 0.2);
            color: var(--primary);
            font-size: 0.9rem;
            font-weight: 500;
        }

        .no-participations {
            text-align: center;
            padding: 50px;
            background: var(--glass);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            border: 1px solid var(--glass-border);
            max-width: 600px;
            margin: 0 auto;
        }

        .no-participations i {
            font-size: 3rem;
            color: var(--primary);
            margin-bottom: 20px;
        }

        .no-participations h3 {
            font-size: 1.8rem;
            margin-bottom: 15px;
            color: var(--light);
        }

        .no-participations p {
            color: rgba(255, 255, 255, 0.7);
            margin-bottom: 25px;
        }

        .explore-btn {
            background: linear-gradient(45deg, var(--primary), var(--secondary));
            color: var(--dark);
            padding: 12px 30px;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .explore-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0, 255, 136, 0.4);
        }

        .back-home {
            position: fixed;
            top: 20px;
            left: 20px;
            text-decoration: none;
            color: white;
            font-weight: 600;
            font-size: 1rem;
            display: flex;
            align-items: center;
            background: rgba(0, 0, 0, 0.3);
            padding: 10px 15px;
            border-radius: 50px;
            transition: all 0.3s ease;
            z-index: 1000;
            backdrop-filter: blur(5px);
        }

        .back-home i {
            margin-right: 8px;
        }

        .back-home:hover {
            background: rgba(0, 0, 0, 0.5);
            color: var(--primary);
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
        }

        @media (max-width: 768px) {
            .header h1 {
                font-size: 2.2rem;
            }
            
            .header {
                padding: 70px 20px 30px;
            }
            
            .participation-table {
                display: block;
                overflow-x: auto;
            }
        }
          .export-container {
        max-width: 1000px;
        margin: 0 auto 30px;
        padding: 0 20px;
        display: flex;
        justify-content: flex-end;
    }

    .pdf-export-btn {
        background: linear-gradient(45deg, #f72585, #7209b7);
        color: white;
        padding: 12px 25px;
        border: none;
        border-radius: 50px;
        font-family: 'Poppins', sans-serif;
        font-weight: 600;
        font-size: 1rem;
        cursor: pointer;
        display: inline-flex;
        align-items: center;
        gap: 10px;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(247, 37, 133, 0.3);
        position: relative;
        overflow: hidden;
        z-index: 1;
    }

    .pdf-export-btn::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: linear-gradient(45deg, #7209b7, #3a0ca3);
        z-index: -1;
        opacity: 0;
        transition: opacity 0.3s ease;
    }

    .pdf-export-btn:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 25px rgba(247, 37, 133, 0.4);
    }

    .pdf-export-btn:hover::before {
        opacity: 1;
    }

    .pdf-export-btn:active {
        transform: translateY(1px);
    }

    @media (max-width: 768px) {
        .export-container {
            justify-content: center;
            margin-bottom: 20px;
        }
        
        .pdf-export-btn {
            width: 100%;
            justify-content: center;
        }
    }
    </style>
</head>
<body>
    <a href="user_dashboard.jsp" class="back-home">
        <i class="fas fa-arrow-left"></i> Retour
    </a>
    
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
        <h1>Vos Participations</h1>
        <p>Retrouvez l'historique complet de vos engagements écologiques avec GreenCommune</p>
    </div>

    <div class="participation-container">
        <c:if test="${empty participations}">
            <div class="no-participations">
                <i class="fas fa-seedling"></i>
                <h3>Vous n'avez pas encore participé à d'événements</h3>
                <p>Rejoignez notre communauté engagée et commencez à faire la différence dès aujourd'hui !</p>
                <a href="events" class="explore-btn">
                    Explorer les événements <i class="fas fa-arrow-right"></i>
                </a>
            </div>
        </c:if>

        <c:if test="${not empty participations}">
            <table class="participation-table">
                <thead>
                    <tr>
                        <th>ID Participation</th>
                        <th>Événement</th>
                        <th>Date de participation</th>
                        <th>Statut</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${participations}">
                        <tr>
                            <td>${p.id}</td>
                            <td>
                                <i class="fas fa-leaf" style="color: var(--primary); margin-right: 8px;"></i>
                                Événement #${p.eventId}
                            </td>
                            <td>${p.participationDate}</td>
                            <td>
                                <span class="participation-badge">
                                    <i class="fas fa-check-circle"></i> Confirmée
                                </span>
                            </td>
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
        </c:if>
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

        // Animation des lignes du tableau
        document.addEventListener('DOMContentLoaded', () => {
            const rows = document.querySelectorAll('.participation-table tbody tr');
            rows.forEach((row, index) => {
                row.style.opacity = '0';
                row.style.transform = 'translateY(20px)';
                row.style.transition = `all 0.5s ease ${index * 0.1}s`;
                
                setTimeout(() => {
                    row.style.opacity = '1';
                    row.style.transform = 'translateY(0)';
                }, 100);
            });
        });
    </script>
</body>
</html>