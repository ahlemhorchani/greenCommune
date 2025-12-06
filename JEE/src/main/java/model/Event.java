package model;

public class Event {
    private int id;
    private String title;
    private String description;
    private String eventDate;
    private String location;
    private String impactType;
    private int impactValue;

    // Getters et Setters
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }

    public String getEventDate() {
        return eventDate;
    }
    public void setEventDate(String eventDate) {
        this.eventDate = eventDate;
    }

    public String getLocation() {
        return location;
    }
    public void setLocation(String location) {
        this.location = location;
    }

    public String getImpactType() {
        return impactType;
    }
    public void setImpactType(String impactType) {
        this.impactType = impactType;
    }

    public int getImpactValue() {
        return impactValue;
    }
    public void setImpactValue(int impactValue) {
        this.impactValue = impactValue;
    }
}
