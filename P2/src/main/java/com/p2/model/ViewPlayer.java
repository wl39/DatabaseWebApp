package com.p2.model;

public class ViewPlayer {
    String fullName;
    String email;
    String dateOfBirth;
    int elo;
    String phoneNumbers;

    public ViewPlayer(){}

    public ViewPlayer(String fullName, String email, String dateOfBirth, int elo, String phoneNumbers) {
        this.fullName = fullName;
        this.email = email;
        this.dateOfBirth = dateOfBirth;
        this.elo = elo;
        this.phoneNumbers = phoneNumbers;
    }

    public String getFullName() {
        return fullName;
    }

    public String getEmail() {
        return email;
    }

    public String getDateOfBirth() {
        return dateOfBirth;
    }

    public int getElo() {
        return elo;
    }

    public String getPhoneNumbers() {
        return phoneNumbers;
    }
}
