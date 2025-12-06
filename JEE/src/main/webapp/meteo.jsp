<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Météo - GreenCommune</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            color: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .weather-card {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            padding: 30px 40px;
            border-radius: 20px;
            text-align: center;
            box-shadow: 0 0 30px rgba(0,255,255,0.1);
            animation: fadeIn 1s ease-in-out;
            width: 350px;
        }

        .weather-card h2 {
            font-size: 24px;
            margin-bottom: 20px;
            color: #00f7ff;
        }

        .weather-card ul {
            list-style: none;
            padding: 0;
        }

        .weather-card li {
            font-size: 18px;
            margin: 10px 0;
            color: #d0f0f0;
        }

        .weather-icon {
            font-size: 50px;
            margin-bottom: 15px;
            color: #ffdd57;
            animation: float 2s ease-in-out infinite;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes float {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
            100% { transform: translateY(0px); }
        }

        .error {
            color: #ff4c4c;
            font-size: 18px;
        }
    </style>
</head>
<body>

<%
    String meteoJson = (String) request.getAttribute("meteoJson");
    String ville = (String) request.getAttribute("ville");

    if (meteoJson != null && !meteoJson.isEmpty()) {
        JSONObject obj = new JSONObject(meteoJson);

        String description = obj.getJSONArray("weather").getJSONObject(0).getString("description");
        double temperature = obj.getJSONObject("main").getDouble("temp");
        int humidity = obj.getJSONObject("main").getInt("humidity");
        double wind = obj.getJSONObject("wind").getDouble("speed");
%>

<div class="weather-card">
    <div class="weather-icon"><i class="fas fa-cloud-sun-rain"></i></div>
    <h2>Météo à <%= ville %></h2>
    <ul>
        <li><strong>Description :</strong> <%= description %></li>
        <li><strong>Température :</strong> <%= temperature %>°C</li>
        <li><strong>Humidité :</strong> <%= humidity %>%</li>
        <li><strong>Vent :</strong> <%= wind %> m/s</li>
    </ul>
</div>

<%
    } else {
%>
    <div class="weather-card">
        <p class="error">❌ Les données météo ne sont pas disponibles.</p>
    </div>
<%
    }
%>

</body>
</html>
