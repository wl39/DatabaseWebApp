package com.p2.model;

public class Phone {
    public String phoneNumber;
    public String phoneType;

    public Phone(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public Phone(String phoneNumber, String phoneType) {
        this.phoneNumber = phoneNumber;
        this.phoneType = phoneType;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public String getPhoneType() {
        return phoneType;
    }
}
