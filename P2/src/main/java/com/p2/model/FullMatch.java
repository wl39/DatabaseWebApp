package com.p2.model;

public class FullMatch {
    int id;
    String p1Email;
    String p2Email;
    String datePlayed;
    Court court;
    SimpleSet[] set;

    public FullMatch(){}

    public FullMatch(int id, String p1Email, String p2Email, String datePlayed, Court court, SimpleSet[] set) {
        this.id = id;
        this.p1Email = p1Email;
        this.p2Email = p2Email;
        this.datePlayed = datePlayed;
        this.court = court;
        this.set = set;
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

    public Court getCourt() {
        return court;
    }

    public SimpleSet[] getSet() {
        return set;
    }
}
