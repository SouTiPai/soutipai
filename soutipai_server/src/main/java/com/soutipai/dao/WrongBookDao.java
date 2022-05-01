package com.soutipai.dao;

public interface WrongBookDao {
    String getWrongBookByUserId(String userId);

    boolean addWrongBook(String userId, String questionId);

    boolean deleteWrongBookById(String id);
}
