package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
 
public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/greencommune";
    private static final String USER = "root"; // à changer si ton utilisateur MySQL est différent
    private static final String PASSWORD = ""; // ou ton mot de passe

    private static Connection connection;

    private DBConnection() {
        // Empêcher l'instanciation
    }

    public static Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver"); // Charger le driver JDBC MySQL
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
                throw new SQLException("Driver JDBC non trouvé !");
            }
        }
        return connection;
    }
}
