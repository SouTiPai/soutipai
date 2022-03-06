package com.soutipai.po;

import java.sql.Date;

public class WrongBook {
    String id;
    String userId;
    String questionId;
    Date createTime;

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

    public String getQuestionId() {
        return questionId;
    }

    public void setQuestionId(String questionId) {
        this.questionId = questionId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @Override
    public String toString() {
        return "WrongBook{" +
                "id='" + id + '\'' +
                ", userId='" + userId + '\'' +
                ", questionId='" + questionId + '\'' +
                ", createTime=" + createTime +
                '}';
    }
}
