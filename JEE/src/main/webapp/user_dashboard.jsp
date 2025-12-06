<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="model.User" %>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("login.jsp?error=Veuillez vous connecter d'abord.");
        return;
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Tableau de Bord - GreenCommune</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.11.4/gsap.min.js"></script>
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

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #0f0c29, #302b63, #24243e);
            color: var(--light);
            min-height: 100vh;
            overflow-x: hidden;
        }

        .particles {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -2;
        }

        .nebula {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            opacity: 0.3;
        }

        header {
            background: var(--glass);
            backdrop-filter: blur(10px);
            padding: 25px;
            text-align: center;
            color: white;
            font-size: 2.5rem;
            font-weight: 700;
            border-bottom: 1px solid var(--glass-border);
            position: relative;
            overflow: hidden;
            z-index: 10;
        }

        header::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, var(--primary), var(--secondary), var(--tertiary));
            animation: rainbow 8s linear infinite;
            background-size: 400% 400%;
        }

        @keyframes rainbow {
            0% { background-position: 0% 50%; }
            100% { background-position: 100% 50%; }
        }

        .logout {
            position: fixed;
            top: 25px;
            right: 25px;
            background: rgba(255, 0, 0, 0.3);
            color: white;
            padding: 12px 25px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            backdrop-filter: blur(5px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            z-index: 1000;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .logout:hover {
            background: rgba(255, 0, 0, 0.5);
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(255, 0, 0, 0.3);
        }

        .dashboard {
            padding: 40px;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            perspective: 1000px;
            z-index: 5;
        }

        .card {
            background: var(--glass);
            backdrop-filter: blur(10px);
            padding: 30px;
            border-radius: 20px;
            border: 1px solid var(--glass-border);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            cursor: pointer;
            position: relative;
            overflow: hidden;
            transform-style: preserve-3d;
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.1));
            transform: translateX(-100%) skewX(-15deg);
            transition: transform 0.6s ease;
        }

        .card:hover {
            transform: translateY(-10px) rotateX(5deg);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
        }

        .card:hover::before {
            transform: translateX(100%) skewX(-15deg);
        }

        .card i {
            font-size: 3rem;
            margin-bottom: 20px;
            background: linear-gradient(45deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }

        .card h2 {
            font-size: 1.8rem;
            margin-bottom: 15px;
            font-weight: 600;
        }

        .card p {
            font-size: 1rem;
            line-height: 1.6;
            opacity: 0.9;
        }

        .globe-card {
            grid-column: span 2;
            height: 500px;
            position: relative;
        }

        .three-container {
            width: 100%;
            height: 100%;
            border-radius: 15px;
            overflow: hidden;
            position: relative;
        }

        .floating-icons {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            pointer-events: none;
        }

        .floating-icon {
            position: absolute;
            font-size: 1.5rem;
            opacity: 0.7;
            animation: float 10s infinite ease-in-out;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(10deg); }
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

        .stats-badge {
            position: absolute;
            top: -10px;
            right: -10px;
            background: var(--primary);
            color: var(--dark);
            width: 30px;
            height: 30px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.2);
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }

        @media (max-width: 768px) {
            .dashboard {
                grid-template-columns: 1fr;
                padding: 20px;
            }
            
            .globe-card {
                grid-column: span 1;
                height: 400px;
            }
            
            header {
                font-size: 1.8rem;
                padding: 20px 15px;
            }
        }
    </style>
</head>
<body>

<!-- Particules animées en fond -->
<canvas id="particles" class="particles"></canvas>
<canvas id="nebula" class="nebula"></canvas>

<header>
    <span class="welcome-text">Bienvenue, <span class="highlight"><%= currentUser.getFullName() %></span></span>
    
</header>

<a href="logo" class="logout">
    <i class="fas fa-sign-out-alt"></i>
    <span>Déconnexion</span>
</a>

<div class="dashboard">
    <div class="card globe-card">
        <h2><i class="fas fa-globe-americas"></i> Globe des Initiatives</h2>
        <div id="globe-container" class="three-container"></div>
        <div class="floating-icons">
            <i class="fas fa-leaf floating-icon" style="top: 20%; left: 10%; animation-delay: 0s;"></i>
            <i class="fas fa-recycle floating-icon" style="top: 70%; left: 15%; animation-delay: 1s;"></i>
            <i class="fas fa-solar-panel floating-icon" style="top: 30%; left: 80%; animation-delay: 2s;"></i>
            <i class="fas fa-tree floating-icon" style="top: 80%; left: 75%; animation-delay: 3s;"></i>
        </div>
    </div>

    <div class="card" onclick="window.location.href='userparticipations'">
        <div class="stats-badge">12</div>
        <i class="fas fa-seedling"></i>
        <h2>Votre Participations</h2>
        <p>Consultez vos participations et suivez votre engagement écologique en un coup d'œil.</p>
    </div>

    <div class="card" onclick="window.location.href='events?action=available'">
        <div class="stats-badge">8</div>
        <i class="fas fa-calendar-star"></i>
        <h2>Événements</h2>
        <p>Participez à des événements passionnants pour un avenir durable.</p>
        <canvas id="eventChart"></canvas>
    </div>

    <div class="card">
        <i class="fas fa-chart-pie-alt"></i>
        <h2>Votre Impact</h2>
        <p>Visualisez votre contribution à la protection de l'environnement.</p>
        <canvas id="impactChart"></canvas>
    </div>

    <div class="card" onclick="window.location.href='report'">
        <i class="fas fa-flag-checkered"></i>
        <h2>Signaler un Problème</h2>
        <p>Aidez-nous à maintenir un environnement propre et sain pour tous.</p>
    </div>

<div class="card" onclick="window.location.href='WeatherServlet?city=Tunis'">
    <div class="stats-badge"><i class="fas fa-sun"></i></div>
    <i class="fas fa-cloud-sun-rain"></i>
    <h2>Météo Écologique</h2>
    <p>Consultez les conditions météo locales pour planifier vos actions durables au bon moment.</p>
    <canvas id="weatherChart"></canvas>
</div>

</div>

<footer>
    <p>🌍 GreenCommune © 2025 - Ensemble pour un futur durable 🌱</p>
</footer>

<script>
    // Initialisation des particules
    const particlesCanvas = document.getElementById('particles');
    const particlesCtx = particlesCanvas.getContext('2d');
    particlesCanvas.width = window.innerWidth;
    particlesCanvas.height = window.innerHeight;

    const nebulaCanvas = document.getElementById('nebula');
    const nebulaCtx = nebulaCanvas.getContext('2d');
    nebulaCanvas.width = window.innerWidth;
    nebulaCanvas.height = window.innerHeight;

    // Particules flottantes
    const particles = [];
    const particleCount = 200;

    for (let i = 0; i < particleCount; i++) {
        particles.push({
            x: Math.random() * particlesCanvas.width,
            y: Math.random() * particlesCanvas.height,
            size: Math.random() * 4 + 1,
            speedX: Math.random() * 1 - 0.5,
            speedY: Math.random() * 1 - 0.5,
            color: `rgba(${Math.floor(Math.random() * 100 + 155)}, ${Math.floor(Math.random() * 255)}, ${Math.floor(Math.random() * 100 + 155)}, ${Math.random() * 0.5 + 0.1})`
        });
    }

    function animateParticles() {
        particlesCtx.clearRect(0, 0, particlesCanvas.width, particlesCanvas.height);
        
        for (let i = 0; i < particles.length; i++) {
            const p = particles[i];
            
            particlesCtx.beginPath();
            particlesCtx.arc(p.x, p.y, p.size, 0, Math.PI * 2);
            particlesCtx.fillStyle = p.color;
            particlesCtx.fill();
            
            p.x += p.speedX;
            p.y += p.speedY;
            
            if (p.x < 0 || p.x > particlesCanvas.width) p.speedX *= -1;
            if (p.y < 0 || p.y > particlesCanvas.height) p.speedY *= -1;
        }
        
        requestAnimationFrame(animateParticles);
    }

    animateParticles();

    // Effet nébuleuse
    function drawNebula() {
        const gradient = nebulaCtx.createRadialGradient(
            nebulaCanvas.width / 2,
            nebulaCanvas.height / 2,
            0,
            nebulaCanvas.width / 2,
            nebulaCanvas.height / 2,
            Math.max(nebulaCanvas.width, nebulaCanvas.height) / 2
        );
        
        gradient.addColorStop(0, 'rgba(114, 9, 183, 0.1)');
        gradient.addColorStop(0.5, 'rgba(0, 180, 216, 0.05)');
        gradient.addColorStop(1, 'rgba(0, 255, 136, 0.1)');
        
        nebulaCtx.fillStyle = gradient;
        nebulaCtx.fillRect(0, 0, nebulaCanvas.width, nebulaCanvas.height);
        
        requestAnimationFrame(drawNebula);
    }

    drawNebula();

    // Initialisation du globe 3D
    const globeContainer = document.getElementById('globe-container');
    const globeScene = new THREE.Scene();
    const globeCamera = new THREE.PerspectiveCamera(75, globeContainer.clientWidth / globeContainer.clientHeight, 0.1, 1000);
    const globeRenderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });
    
    globeRenderer.setSize(globeContainer.clientWidth, globeContainer.clientHeight);
    globeRenderer.setPixelRatio(window.devicePixelRatio);
    globeContainer.appendChild(globeRenderer.domElement);

    // Création du globe avec plus de détails
    const globeGeometry = new THREE.SphereGeometry(2, 128, 128);
    const globeTexture = new THREE.TextureLoader().load('https://threejs.org/examples/textures/planets/earth_atmos_2048.jpg');
    const bumpMap = new THREE.TextureLoader().load('https://threejs.org/examples/textures/planets/earth_normal_2048.jpg');
    const specularMap = new THREE.TextureLoader().load('https://threejs.org/examples/textures/planets/earth_specular_2048.jpg');
    
    const globeMaterial = new THREE.MeshPhongMaterial({
        map: globeTexture,
        bumpMap: bumpMap,
        bumpScale: 0.1,
        specularMap: specularMap,
        specular: new THREE.Color('grey'),
        shininess: 10,
        transparent: true,
        opacity: 1
    });

    const globeMesh = new THREE.Mesh(globeGeometry, globeMaterial);
    globeScene.add(globeMesh);

    // Ajout d'anneaux orbitaux
    const ringGeometry = new THREE.RingGeometry(2.2, 2.5, 64);
    const ringMaterial = new THREE.MeshBasicMaterial({ 
        color: 0x00ff88, 
        side: THREE.DoubleSide,
        transparent: true,
        opacity: 0.4
    });
    const ring = new THREE.Mesh(ringGeometry, ringMaterial);
    ring.rotation.x = Math.PI / 2;
    globeScene.add(ring);

    // Ajout de satellites
    const satelliteGeometry = new THREE.SphereGeometry(0.1, 16, 16);
    const satelliteMaterial = new THREE.MeshBasicMaterial({ color: 0xffffff });
    const satellite1 = new THREE.Mesh(satelliteGeometry, satelliteMaterial);
    satellite1.position.set(3, 0, 0);
    globeScene.add(satellite1);

    const satellite2 = new THREE.Mesh(satelliteGeometry, satelliteMaterial);
    satellite2.position.set(-3, 0, 0);
    globeScene.add(satellite2);

    // Lumières pour le globe
    const ambientLight = new THREE.AmbientLight(0x404040);
    globeScene.add(ambientLight);

    const directionalLight = new THREE.DirectionalLight(0xffffff, 1.5);
    directionalLight.position.set(5, 3, 5);
    globeScene.add(directionalLight);

    const pointLight = new THREE.PointLight(0x00ff88, 1, 10);
    pointLight.position.set(3, 3, 3);
    globeScene.add(pointLight);

    globeCamera.position.z = 5;

    // Animation du globe
    function animateGlobe() {
        requestAnimationFrame(animateGlobe);
        
        globeMesh.rotation.y += 0.002;
        ring.rotation.z += 0.001;
        
        // Animation des satellites
        satellite1.position.x = 3 * Math.cos(Date.now() * 0.001);
        satellite1.position.z = 3 * Math.sin(Date.now() * 0.001);
        
        satellite2.position.x = -3 * Math.cos(Date.now() * 0.0007);
        satellite2.position.z = -3 * Math.sin(Date.now() * 0.0007);
        
        globeRenderer.render(globeScene, globeCamera);
    }

    animateGlobe();

    // Graphiques Chart.js
    new Chart(document.getElementById('impactChart'), {
        type: 'doughnut',
        data: {
            labels: ['Carbone réduit', 'Déchets recyclés', 'Eau économisée', 'Arbres plantés'],
            datasets: [{
                data: [35, 25, 20, 20],
                backgroundColor: [
                    '#00ff88',
                    '#00b4d8',
                    '#7209b7',
                    '#f72585'
                ],
                borderWidth: 0,
            }]
        },
        options: {
            cutout: '70%',
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: {
                        color: '#ffffff',
                        font: {
                            family: 'Poppins'
                        }
                    }
                }
            }
        }
    });

    new Chart(document.getElementById('eventChart'), {
        type: 'radar',
        data: {
            labels: ['Conférences', 'Ateliers', 'Nettoyages', 'Plantations', 'Sensibilisation'],
            datasets: [{
                label: 'Votre participation',
                data: [8, 6, 9, 7, 5],
                backgroundColor: 'rgba(0, 255, 136, 0.2)',
                borderColor: '#00ff88',
                borderWidth: 2,
                pointBackgroundColor: '#00ff88',
                pointRadius: 4
            }]
        },
        options: {
            scales: {
                r: {
                    angleLines: {
                        color: 'rgba(255, 255, 255, 0.1)'
                    },
                    grid: {
                        color: 'rgba(255, 255, 255, 0.1)'
                    },
                    suggestedMin: 0,
                    suggestedMax: 10,
                    pointLabels: {
                        color: '#ffffff',
                        font: {
                            family: 'Poppins'
                        }
                    },
                    ticks: {
                        display: false,
                        backdropColor: 'transparent'
                    }
                }
            },
            plugins: {
                legend: {
                    display: false
                }
            }
        }
    });

    // Animations GSAP
    gsap.from('.card', {
        duration: 1,
        y: 50,
        opacity: 0,
        stagger: 0.1,
        ease: 'power3.out'
    });

    gsap.from('header', {
        duration: 1.5,
        y: -100,
        opacity: 0,
        ease: 'elastic.out(1, 0.5)'
    });

    // Animation des badges
    gsap.to('.stats-badge', {
        duration: 1,
        y: -5,
        repeat: -1,
        yoyo: true,
        ease: 'sine.inOut'
    });

    // Redimensionnement
    window.addEventListener('resize', () => {
        particlesCanvas.width = window.innerWidth;
        particlesCanvas.height = window.innerHeight;
        nebulaCanvas.width = window.innerWidth;
        nebulaCanvas.height = window.innerHeight;
        
        // Globe
        globeCamera.aspect = globeContainer.clientWidth / globeContainer.clientHeight;
        globeCamera.updateProjectionMatrix();
        globeRenderer.setSize(globeContainer.clientWidth, globeContainer.clientHeight);
    });
</script>
</body>
</html>