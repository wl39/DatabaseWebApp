package com.p2.model;

public class Player {
    public String email;
    public String forename;
    public String[] middleNames;
    public String surname;
    public String dateOfBirth;
    public Phone[] phones;
    public int elo;

    public Player(String email, String forename, String[] middleNames, String surname, String dateOfBirth, Phone[] phones, int elo) {
        this.email = email;
        this.forename = forename;
        this.middleNames = middleNames;
        this.surname = surname;
        this.dateOfBirth = dateOfBirth;
        this.phones = phones;
        this.elo = elo;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getForename() {
        return forename;
    }

    public void setForename(String forename) {
        this.forename = forename;
    }

    public String[] getMiddleNames() {
        return middleNames;
    }

    public void setMiddleNames(String[] middleNames) {
        this.middleNames = middleNames;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(String dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public Phone[] getPhones() {
        return phones;
    }

    public int getElo() {
        return elo;
    }

    public void setElo(int elo) {
        this.elo = elo;
    }
}
