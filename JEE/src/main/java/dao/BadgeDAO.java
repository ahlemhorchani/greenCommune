package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Badge;
import util.DBConnection;

public class BadgeDAO {
    private Connection connection;

    public BadgeDAO() throws SQLException {
        this.connection = DBConnection.getConnection();
    }

    // Récupérer tous les badges
    public List<Badge> getAllBadges() throws SQLException {
        List<Badge> badges = new ArrayList<>();
        String sql = "SELECT * FROM badges";
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                badges.add(new Badge(
                    rs.getInt("id"),
                    rs.getString("badge_name"),
                    rs.getString("badge_description"),
                    rs.getInt("required_impact")
                ));
            }
        }
        return badges;
    }

    // Attribuer un badge à un utilisateur
    public void awardBadge(int userId, int badgeId) throws SQLException {
        String sql = "INSERT INTO user_badges (user_id, badge_id) VALUES (?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, badgeId);
            stmt.executeUpdate();
        }
    }

    // Vérifier si un utilisateur a déjà un badge
    public boolean hasBadge(int userId, int badgeId) throws SQLException {
        String sql = "SELECT * FROM user_badges WHERE user_id = ? AND badge_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, badgeId);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        }
    }
}
