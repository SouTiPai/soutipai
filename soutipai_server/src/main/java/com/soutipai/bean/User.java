package com.soutipai.bean;

import com.alibaba.fastjson.annotation.JSONField;

import java.sql.Date;

public class User {
    String id;
    String userId;
    String userName;
    String userPassword;
    int userAge;
    String userSex;
    @JSONField(format = "yyyy-MM-dd")
    Date userBirthday;
    int userClass;
    int userLevel = 1;

    public User(){}

    public User(String id, String userId, String userName, String userPassword, int userAge, String userSex, Date userBirthday, int userClass, int userLevel) {
        this.id = id;
        this.userId = userId;
        this.userName = userName;
        this.userPassword = userPassword;
        this.userAge = userAge;
        this.userSex = userSex;
        this.userBirthday = userBirthday;
        this.userClass = userClass;
        this.userLevel = userLevel;
    }

    public User(String userId, String userName, String userPassword) {
        this.userId = userId;
        this.userName = userName;
        this.userPassword = userPassword;
    }

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

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    public int getUserAge() {
        return userAge;
    }

    public void setUserAge(int userAge) {
        this.userAge = userAge;
    }

    public String getUserSex() {
        return userSex;
    }

    public void setUserSex(String userSex) {
        this.userSex = userSex;
    }

    public Date getUserBirthday() {
        return userBirthday;
    }

    public void setUserBirthday(Date userBirthday) {
        this.userBirthday = userBirthday;
    }

    public int getUserClass() {
        return userClass;
    }

    public void setUserClass(int userClass) {
        this.userClass = userClass;
    }

    public int getUserLevel() {
        return userLevel;
    }

    public void setUserLevel(int userLevel) {
        this.userLevel = userLevel;
    }

    @Override
    public String toString() {
        return "User{" +
                "id='" + id + '\'' +
                ", userId='" + userId + '\'' +
                ", userName='" + userName + '\'' +
                ", userPassword='" + userPassword + '\'' +
                ", userAge='" + userAge + '\'' +
                ", userSex='" + userSex + '\'' +
                ", userBirthday=" + userBirthday +
                ", userClass=" + userClass +
                ", userLevel=" + userLevel +
                '}';
    }
}
