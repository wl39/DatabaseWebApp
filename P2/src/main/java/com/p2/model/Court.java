package com.p2.model;

public class Court extends SimpleCourt{
    SimpleVenue venue;

    public Court() {}

    public Court(int number, String surface, SimpleVenue venue) {
        super(number, surface);
        this.venue = venue;
    }

    public int getNumber() {
        return number;
    }

    public String getSurface() {
        return surface;
    }

    public SimpleVenue getVenue() {
        return venue;
    }
}
