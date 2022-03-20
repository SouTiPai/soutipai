package com.soutipai.common;

import com.alibaba.fastjson.JSON;
import com.soutipai.dao.QuestionDaoImpl;
import com.soutipai.utils.JDBCUtils;
import org.apdplat.word.WordSegmenter;
import org.apdplat.word.segmentation.Word;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class GetAnswersFromTable {

    static private final QuestionDaoImpl dao = new QuestionDaoImpl();

    static public String getAnswers(String s) {
        Connection conn = null;
        try {
            conn = JDBCUtils.getConnection();
            List<Word> lists = WordSegmenter.segWithStopWords(s);
            return JSON.toJSONString(dao.getQuestionByName(conn, lists));
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            JDBCUtils.closeResource(conn);
        }
        return null;
    }
}
