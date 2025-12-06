package dao;

import model.Impact;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ImpactDAO {
    private Connection conn;
    public ImpactDAO() throws SQLException {
        this.conn = DBConnection.getConnection();
    }
    public ImpactDAO(Connection conn) {
        this.conn = conn;
    }
    // Ajouter un impact
    public void addImpact(int userId, String impactType, int impactValue) throws SQLException {
        String sql = "INSERT INTO impacts (user_id, impact_type, impact_value) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setString(2, impactType);
            stmt.setInt(3, impactValue);
            stmt.executeUpdate();
        }}

    public void addImpact(Impact impact) throws SQLException {
        String sql = "INSERT INTO impacts (userId, impactType, impactValue, impactDate) VALUES (?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, impact.getUserId());
        stmt.setString(2, impact.getImpactType());
        stmt.setInt(3, impact.getImpactValue());
        stmt.setTimestamp(4, impact.getImpactDate());
        stmt.executeUpdate();
    }

    public void updateImpact(Impact impact) throws SQLException {
        String sql = "UPDATE impacts SET userId=?, impactType=?, impactValue=?, impactDate=? WHERE id=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, impact.getUserId());
        stmt.setString(2, impact.getImpactType());
        stmt.setInt(3, impact.getImpactValue());
        stmt.setTimestamp(4, impact.getImpactDate());
        stmt.setInt(5, impact.getId());
        stmt.executeUpdate();
    }

    public void deleteImpact(int id) throws SQLException {
        String sql = "DELETE FROM impacts WHERE id=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        stmt.executeUpdate();
    }

    public List<Impact> getAllImpacts() throws SQLException {
        List<Impact> impacts = new ArrayList<>();
        String sql = "SELECT * FROM impacts";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);

        while (rs.next()) {
            Impact impact = new Impact(
                    rs.getInt("id"),
                    rs.getInt("userId"),
                    rs.getString("impactType"),
                    rs.getInt("impactValue"),
                    rs.getTimestamp("impactDate")
            );
            impacts.add(impact);
        }
        return impacts;
    }

    public Impact getImpactById(int id) throws SQLException {
        String sql = "SELECT * FROM impacts WHERE id=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            return new Impact(
                    rs.getInt("id"),
                    rs.getInt("userId"),
                    rs.getString("impactType"),
                    rs.getInt("impactValue"),
                    rs.getTimestamp("impactDate")
            );
        }
        return null;
    }
    // Récupérer les impacts d'un utilisateur
    public List<Impact> getUserImpacts(int userId) throws SQLException {
        List<Impact> impacts = new ArrayList<>();
        String sql = "SELECT * FROM impacts WHERE user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                impacts.add(new Impact(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getString("impact_type"),
                    rs.getInt("impact_value"),
                    rs.getTimestamp("impact_date")
                ));
            }
        }
        return impacts;
    }
    
  

    // Calculer le total des impacts pour un utilisateur
    public int getUserTotalImpact(int userId) throws SQLException {
        String sql = "SELECT SUM(impact_value) FROM impacts WHERE user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);  // Retourne la somme des valeurs des impacts
            }
        }
        return 0;  // Si aucun impact n'est trouvé, retourne 0
    }
}
