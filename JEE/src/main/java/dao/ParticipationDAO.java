package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import model.Participation;
import util.DBConnection;

public class ParticipationDAO {
    private Connection connection;

    public ParticipationDAO() throws SQLException {
        this.connection = DBConnection.getConnection();
    }
    
    public ParticipationDAO (Connection connection)  {
        this.connection = connection;
    }


    // Ajouter une participation
    public void addParticipation(int userId, int eventId) {
        String sql = "INSERT INTO participations (user_id, event_id) VALUES (?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, eventId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void registerParticipation(Participation participation) throws SQLException {
        String sql = "INSERT INTO participations (user_id, event_id, participation_date) VALUES (?, ?, ?)";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, participation.getUserId());
        stmt.setInt(2, participation.getEventId());
        stmt.setTimestamp(3, participation.getParticipationDate());
        stmt.executeUpdate();
    }
    

    // Obtenir les participations d'un utilisateur
    public List<Participation> getUserParticipations(int userId) {
        List<Participation> participations = new ArrayList<>();
        String sql = "SELECT * FROM participations WHERE user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                participations.add(new Participation(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getInt("event_id"),
                    rs.getTimestamp("participation_date")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return participations;
    }

    // Obtenir les participations d'un événement
    public List<Participation> getEventParticipations(int eventId) {
        List<Participation> participations = new ArrayList<>();
        String sql = "SELECT * FROM participations WHERE event_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, eventId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                participations.add(new Participation(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getInt("event_id"),
                    rs.getTimestamp("participation_date")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return participations;
    }
}
