package com.p2.model;

public class SimpleSet {
    int setNumber;
    int p1Score;
    int p2Score;

    public SimpleSet(){}

    public SimpleSet(int setNumber, int p1Score, int p2Score) {
        this.setNumber = setNumber;
        this.p1Score = p1Score;
        this.p2Score = p2Score;
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
