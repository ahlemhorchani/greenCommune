package model;

public class Badge {
    private int id;
    private String badgeName;
    private String badgeDescription;
    private int requiredImpact;

    public Badge(int id, String badgeName, String badgeDescription, int requiredImpact) {
        this.id = id;
        this.badgeName = badgeName;
        this.badgeDescription = badgeDescription;
        this.requiredImpact = requiredImpact;
    }

    // Getters et Setters

    public int getId() {
        return id;
    }

    public String getBadgeName() {
        return badgeName;
    }

    public String getBadgeDescription() {
        return badgeDescription;
    }

    public int getRequiredImpact() {
        return requiredImpact;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setBadgeName(String badgeName) {
        this.badgeName = badgeName;
    }

    public void setBadgeDescription(String badgeDescription) {
        this.badgeDescription = badgeDescription;
    }

    public void setRequiredImpact(int requiredImpact) {
        this.requiredImpact = requiredImpact;
    }
}
