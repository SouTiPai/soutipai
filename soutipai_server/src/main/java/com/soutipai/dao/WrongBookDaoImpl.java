package com.soutipai.dao;

import com.soutipai.bean.WrongBook;
import com.soutipai.common.GetJSONFromData;
import com.soutipai.utils.JDBCUtils;

import java.sql.Date;

public class WrongBookDaoImpl extends BaseDao<WrongBook> implements WrongBookDao {

    @Override
    public String getWrongBookByUserId(String userId) {
        String sql = "SELECT wbt.id id, wbt.user_id userId, wbt.question_id questionId, wbt.create_time createTime, qt.question_name questionName FROM wrong_book_table wbt LEFT JOIN question_table qt ON wbt.question_id = qt.id WHERE wbt. user_id = ? AND wbt.del_flag = 0";
        return GetJSONFromData.getJSONFromData(200, getForList(sql, userId));
    }

    @Override
    public String addWrongBook(String userId, String questionId) {
        Date date = new Date(System.currentTimeMillis());
        String sql = "UPDATE wrong_book_table SET del_flag = ? , update_time = ? WHERE user_id = ? AND question_id = ? AND del_flag = ?";
        if(update(sql, 1, date, userId, questionId, 0) > 0)
            return GetJSONFromData.getJSONFromData(201, null);
        else if(update(sql, 0, date, userId, questionId, 1) > 0)
            return GetJSONFromData.getJSONFromData(200, null);
        else {
            sql = "INSERT INTO wrong_book_table (id, user_id, question_id) VALUES (?, ?, ?)";
            if (update(sql, JDBCUtils.getUUID(), userId, questionId) > 0)
                return GetJSONFromData.getJSONFromData(200, null);
            else
                return GetJSONFromData.getJSONFromData(400, null);
        }
    }

    @Override
    public String deleteWrongBookById(String id) {
        String sql = "UPDATE wrong_book_table SET del_flag = 1 WHERE id = ?";
        if(update(sql, id) > 0)
            return GetJSONFromData.getJSONFromData(200, null);
        else
            return GetJSONFromData.getJSONFromData(400, null);
    }
}
