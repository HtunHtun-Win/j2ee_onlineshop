package com.mub.models;

public class ReviewModel {
    public int id;
    public int productId;
    public int userId;
    public int rating;
    public String comment;
    public String createdAt;
    public String userName;

    public ReviewModel() {}

    public ReviewModel(int id, int productId, int userId, int rating, String comment, String createdAt, String userName) {
        this.id = id;
        this.productId = productId;
        this.userId = userId;
        this.rating = rating;
        this.comment = comment;
        this.createdAt = createdAt;
        this.userName = userName;
    }
}
