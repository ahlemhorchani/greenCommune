package dao;

import model.User;
import util.DBConnection;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
	  private Connection connection;

	    public UserDAO() throws SQLException {
	        this.connection = DBConnection.getConnection();
	    }
	    public UserDAO(Connection connection) {
	        this.connection = connection;
	    }
	    public void deleteOldUsers() throws SQLException {
	        String sql = "DELETE FROM users WHERE created_at < NOW() - INTERVAL 45 DAY";
	        try (PreparedStatement statement = connection.prepareStatement(sql)) {
	            statement.executeUpdate();
	        }
	    }

    public static boolean registerUser(User user) {
        String sql = "INSERT INTO users (username, email, password, role, full_name) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword()); // ATTENTION : en vrai, il faudrait hasher le password
            stmt.setString(4, user.getRole());
            stmt.setString(5, user.getFullName());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    

    public static User login(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setFullName(rs.getString("full_name"));
                // Ne jamais renvoyer le mot de passe en vrai...
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
 // Supprimer un utilisateur
    public void deleteUser(int id) throws SQLException {
        String sql = "DELETE FROM users WHERE id=?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, id);
        stmt.executeUpdate();
    }

 // Récupérer tous les utilisateurs
   
    public List<User> getAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                users.add(new User(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("role"),
                    rs.getString("full_name")
                ));
            }
        }
        System.out.println("Nombre d'utilisateurs récupérés : " + users.size()); // Ajoutez cette ligne pour le débogage
        return users;
    }
}
