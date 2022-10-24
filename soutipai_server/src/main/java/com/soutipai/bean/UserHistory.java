package com.soutipai.bean;

import java.sql.Blob;

public class UserHistory {
    String id;
    String userId;
    Blob questionPhoto;
    String questionText;

    String questionName;
    String questionId;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Blob getQuestionPhoto() {
        return questionPhoto;
    }

    public void setQuestionPhoto(Blob questionPhoto) {
        this.questionPhoto = questionPhoto;
    }

    public String getQuestionText() {
        return questionText;
    }

    public void setQuestionText(String questionText) {
        this.questionText = questionText;
    }

    public String getQuestionName() {
        return questionName;
    }

    public void setQuestionNAme(String questionNAme) {
        this.questionName = questionNAme;
    }

    public String getQuestionId() {
        return questionId;
    }

    public void setQuestionId(String questionId) {
        this.questionId = questionId;
    }

    @Override
    public String toString() {
        return "UserHistory{" +
                "id='" + id + '\'' +
                ", userId='" + userId + '\'' +
                ", questionPhoto=" + questionPhoto +
                ", questionText='" + questionText + '\'' +
                ", questionNAme='" + questionName + '\'' +
                ", questionId='" + questionId + '\'' +
                '}';
    }
}
