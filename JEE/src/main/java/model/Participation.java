package model;
import java.sql.Timestamp;

public class Participation {
    private int id;
    private int userId;
    private int eventId;
    private Timestamp participationDate;

    public Participation(int userId, int eventId) {
        this.userId = userId;
        this.eventId = eventId;
        this.participationDate = new Timestamp(System.currentTimeMillis());
    }

    public Participation(int id, int userId, int eventId, Timestamp participationDate) {
        this.id = id;
        this.userId = userId;
        this.eventId = eventId;
        this.participationDate = participationDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public Timestamp getParticipationDate() {
        return participationDate;
    }

    public void setParticipationDate(Timestamp participationDate) {
        this.participationDate = participationDate;
    }
}
