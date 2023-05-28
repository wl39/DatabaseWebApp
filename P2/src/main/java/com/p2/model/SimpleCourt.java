package com.p2.model;

public class SimpleCourt extends CourtNumber{
    String surface;

    public SimpleCourt(){}

    public SimpleCourt(int number, String surface) {
        super(number);
        this.surface = surface;
    }

    public int getNumber() {
        return number;
    }

    public String getSurface() {
        return surface;
    }
}
