package com.p2.model;

public class SimplePlayer {
    String email;
    String surname;

    public SimplePlayer(String email, String surname) {
        this.email = email;
        this.surname = surname;
    }

    public String getEmail() {
        return email;
    }

    public String getSurname() {
        return surname;
    }
}
