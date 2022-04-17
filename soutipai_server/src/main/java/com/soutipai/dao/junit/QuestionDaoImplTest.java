package com.soutipai.dao.junit;

import com.alibaba.fastjson.JSON;
import com.soutipai.dao.QuestionDaoImpl;
import com.soutipai.utils.JDBCUtils;
import org.apdplat.word.WordSegmenter;
import org.apdplat.word.segmentation.Word;
import org.junit.Test;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class QuestionDaoImplTest {

    private final QuestionDaoImpl dao = new QuestionDaoImpl();

    @Test
    public void Test() {
        Connection conn = null;
        try {
            conn = JDBCUtils.getConnection();
            List<Word> lists = WordSegmenter.segWithStopWords("有定义正确");
            System.out.println(JSON.toJSONString(dao.getQuestionByName(conn, lists)));
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}