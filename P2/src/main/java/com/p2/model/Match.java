package com.p2.model;

public class Match {
    int id;
    String p1Email;
    String p2Email;
    String datePlayed;
    CourtNumber court;
    SimpleVenue venue;

    public Match(){}

    public Match(int id, String p1Email, String p2Email, String datePlayed, CourtNumber court, SimpleVenue venue) {
        this.id = id;
        this.p1Email = p1Email;
        this.p2Email = p2Email;
        this.datePlayed = datePlayed;
        this.court = court;
        this.venue = venue;
    }

    public int getId() {
        return id;
    }

    public String getP1Email() {
        return p1Email;
    }

    public String getP2Email() {
        return p2Email;
    }

    public String getDatePlayed() {
        return datePlayed;
    }

    public CourtNumber getCourt() {
        return court;
    }

    public SimpleVenue getVenue() {
        return venue;
    }
}
