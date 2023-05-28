package com.p2.model;

public class Set extends SimpleSet{
    int id;

    public Set(){}

    public Set(int id, int setNumber, int p1Score, int p2Score) {
        super(setNumber, p1Score, p2Score);
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public int getSetNumber() {
        return setNumber;
    }

    public int getP1Score() {
        return p1Score;
    }

    public int getP2Score() {
        return p2Score;
    }
}
