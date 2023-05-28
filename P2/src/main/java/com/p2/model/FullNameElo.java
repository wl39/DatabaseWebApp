package com.p2.model;

public class FullNameElo {
    String fullName;
    int elo;

    public FullNameElo(String fullName, int elo) {
        this.fullName = fullName;
        this.elo = elo;
    }

    public String getFullName() {
        return fullName;
    }

    public int getElo() {
        return elo;
    }
}
