package com.soutipai.dao;

import com.soutipai.bean.Question;
import com.soutipai.common.GetJSONFromData;
import org.apdplat.word.WordSegmenter;
import org.apdplat.word.segmentation.Word;

import java.util.Arrays;
import java.util.List;

public class QuestionDaoImpl extends BaseDao<Question> implements QuestionDao {

    @Override
    public String getQuestionByName(String question) {
        List<Word> words = WordSegmenter.segWithStopWords(question);
        String sql = "SELECT id, question_name questionName, question_answer questionAnswer, question_type questionType, question_remark questionRemark FROM question_table WHERE 1=1 AND (" +
                "(CASE WHEN question_name LIKE ? THEN 1 ELSE 0 END) + ".repeat(words.size() - 1) +
                "(CASE WHEN question_name LIKE ? THEN 1 ELSE 0 END)) >= ?";
        Object[] params = new Object[words.size() + 1];
        for (int i = 0; i < words.size(); i++)
            params[i] = "%" + words.get(i).getText() + "%";
        params[words.size()] = words.size() * 0.8;
        return GetJSONFromData.getJSONFromData(200, getForList(sql, Arrays.stream(params).toArray()));
    }

    @Override
    public String getQuestionById(String questionId) {
        String sql = "SELECT id, question_name questionName, question_answer questionAnswer, question_type questionType, question_remark questionRemark FROM question_table WHERE id = ? AND del_flag = 0";
        return GetJSONFromData.getJSONFromData(200, getForList(sql, questionId));
    }
}
