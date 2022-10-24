package com.soutipai.dao;

public interface WrongBookDao {
    String getWrongBookByUserId(String userId);

    String addWrongBook(String userId, String questionId);

    String deleteWrongBookById(String id);
}
