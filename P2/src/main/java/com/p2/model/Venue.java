package com.p2.model;

public class Venue extends SimpleVenue{
    String address;

    public Venue() {}

    public Venue(String name, String address) {
        super(name);
        this.address = address;
    }

    public String getAddress() {
        return address;
    }

    public String getName() {
        return name;
    }
}
