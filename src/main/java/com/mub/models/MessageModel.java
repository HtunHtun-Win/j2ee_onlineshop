package com.mub.models;

import java.sql.Timestamp;

public class MessageModel {
    public int id;
    public String title;
    public String message;
    public Timestamp createdAt;
    public String userName;

    public MessageModel(int id, String title, String message, Timestamp createdAt, String userName) {
        this.id = id;
        this.title = title;
        this.message = message;
        this.createdAt = createdAt;
        this.userName = userName;
    }

    public MessageModel(String title, String message) {
        this.title = title;
        this.message = message;
    }
}
