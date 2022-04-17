package com.soutipai.dao;

import com.soutipai.bean.Question;
import org.apdplat.word.segmentation.Word;

import java.sql.Connection;
import java.util.Arrays;
import java.util.List;

public class QuestionDaoImpl extends BaseDao<Question> implements QuestionDao {

    @Override
    public List<Question> getQuestionByName(Connection conn, List<Word> words) {
        String sql = "select id, question_name questionName, question_answer questionAnswer, question_type questionType, question_remark questionRemark from question_table where " +
                "question_name like ? or ".repeat(Math.max(0, words.size() - 1)) +
                "question_name like ?";
        String[] params = new String[words.size()];
        for(int i =0;i<words.size();i++)
            params[i]="%"+words.get(i).getText()+"%";
        return getForList(conn, sql, Arrays.stream(params).toArray());
    }

}
