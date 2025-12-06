package model;

import java.sql.Timestamp;

public class Impact {
    private int id;
    private int userId;
    private String impactType;
    private int impactValue;
    private Timestamp impactDate;

    public Impact(int id, int userId, String impactType, int impactValue, Timestamp impactDate) {
        this.id = id;
        this.userId = userId;
        this.impactType = impactType;
        this.impactValue = impactValue;
        this.impactDate = impactDate;
    }

    // Getters et Setters

    public int getId() {
        return id;
    }

    public int getUserId() {
        return userId;
    }

    public String getImpactType() {
        return impactType;
    }

    public int getImpactValue() {
        return impactValue;
    }

    public Timestamp getImpactDate() {
        return impactDate;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setImpactType(String impactType) {
        this.impactType = impactType;
    }

    public void setImpactValue(int impactValue) {
        this.impactValue = impactValue;
    }

    public void setImpactDate(Timestamp impactDate) {
        this.impactDate = impactDate;
    }
}
