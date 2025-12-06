<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>🌱 GreenCommune | Ajouter un Utilisateur</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root {
            --primary: #2e8b57;
            --accent: #3CB371;
            --bg-light: #F4FDF4;
            --text-dark: #2c3e50;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: var(--bg-light);
            color: var(--text-dark);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 30px;
        }

        .form-container {
            background: white;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(46, 139, 87, 0.2);
            width: 100%;
            max-width: 600px;
            position: relative;
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
            color: var(--primary);
        }

        .remark {
            text-align: center;
            font-size: 14px;
            color: var(--primary);
            margin-bottom: 20px;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-bottom: 6px;
            font-weight: 600;
        }

        input, textarea, select {
            margin-bottom: 20px;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 16px;
        }

        button {
            background: var(--accent);
            color: white;
            padding: 14px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        button:hover {
            background: #2e8b57;
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
            background: #246b45;
        }

    </style>
</head>
<body>
<a href="users?action=list" class="back-button">
    <i class="fas fa-arrow-left"></i> Retour
</a>

<div class="form-container">
    <h1>👤 Ajouter un Utilisateur</h1>

    <form action="users" method="post">
        <input type="hidden" name="action" value="add">

        <label for="name">Nom Complet</label>
        <input type="text" id="fullName" name="fullName" required>

        <label for="email">Email</label>
        <input type="email" id="email" name="email" required>

        <label for="password">Mot de Passe</label>
        <input type="password" id="password" name="password" required>

        

        <label for="role">Rôle</label>
        <select id="role" name="role" required>
            <option value="">-- Sélectionner un rôle --</option>
            <option value="user">Utilisateur</option>
            <option value="admin">Administrateur</option>
        </select>

        <button type="submit">➕ Créer l'Utilisateur</button>
    </form>
</div>

</body>
</html>
