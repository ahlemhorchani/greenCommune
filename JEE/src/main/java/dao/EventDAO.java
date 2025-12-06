package dao;

import model.Event;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventDAO {
    private Connection conn;

    public EventDAO(Connection conn) {
        this.conn = conn;
    }
    public EventDAO() throws SQLException {
        this.conn = DBConnection.getConnection();
    }

    // Ajouter un nouvel event
    public void addEvent(Event event) throws SQLException {
        String sql = "INSERT INTO events (title, description, eventDate, location, impactType, impactValue) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, event.getTitle());
        stmt.setString(2, event.getDescription());
        stmt.setString(3, event.getEventDate());
        stmt.setString(4, event.getLocation());
        stmt.setString(5, event.getImpactType());
        stmt.setInt(6, event.getImpactValue());
        stmt.executeUpdate();
    }

    // Modifier un event
    public void updateEvent(Event event) throws SQLException {
        String sql = "UPDATE events SET title=?, description=?, eventDate=?, location=?, impactType=?, impactValue=? WHERE id=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, event.getTitle());
        stmt.setString(2, event.getDescription());
        stmt.setString(3, event.getEventDate());
        stmt.setString(4, event.getLocation());
        stmt.setString(5, event.getImpactType());
        stmt.setInt(6, event.getImpactValue());
        stmt.setInt(7, event.getId());
        stmt.executeUpdate();
    }

    // Supprimer un event
    public void deleteEvent(int id) throws SQLException {
        String sql = "DELETE FROM events WHERE id=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        stmt.executeUpdate();
    }

    // Récupérer tous les events
    public List<Event> getAllEvents() throws SQLException {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT * FROM events";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);

        while (rs.next()) {
            Event event = new Event();
            event.setId(rs.getInt("id"));
            event.setTitle(rs.getString("title"));
            event.setDescription(rs.getString("description"));
            event.setEventDate(rs.getString("eventDate"));
            event.setLocation(rs.getString("location"));
            event.setImpactType(rs.getString("impactType"));
            event.setImpactValue(rs.getInt("impactValue"));
            events.add(event);
        }
        return events;
    }

    // Récupérer un seul event par ID
    public Event getEventById(int id) throws SQLException {
        String sql = "SELECT * FROM events WHERE id=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            Event event = new Event();
            event.setId(rs.getInt("id"));
            event.setTitle(rs.getString("title"));
            event.setDescription(rs.getString("description"));
            event.setEventDate(rs.getString("eventDate"));
            event.setLocation(rs.getString("location"));
            event.setImpactType(rs.getString("impactType"));
            event.setImpactValue(rs.getInt("impactValue"));
            return event;
        }
        return null;
    }
}
