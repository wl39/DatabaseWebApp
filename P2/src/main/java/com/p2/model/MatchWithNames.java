package com.p2.model;

public class MatchWithNames {
    int id;
    String email;
    String dateOfPlayed;
    int courtNumber;
    String venueName;
    String fullName;
    int elo;
    String surface;
    String winner;

    public MatchWithNames() {
    }

    public MatchWithNames(int id, String email, String dateOfPlayed, int courtNumber, String venueName, String fullName, int elo, String surface, String winner) {
        this.id = id;
        this.email = email;
        this.dateOfPlayed = dateOfPlayed;
        this.courtNumber = courtNumber;
        this.venueName = venueName;
        this.fullName = fullName;
        this.elo = elo;
        this.surface = surface;
        this.winner = winner;
    }

    public int getId() {
        return id;
    }

    public String getEmail() {
        return email;
    }

    public String getDateOfPlayed() {
        return dateOfPlayed;
    }

    public int getCourtNumber() {
        return courtNumber;
    }

    public String getVenueName() {
        return venueName;
    }

    public String getFullName() {
        return fullName;
    }

    public int getElo() {
        return elo;
    }

    public String getSurface() {
        return surface;
    }

    public String getWinner() {
        return winner;
    }
}
