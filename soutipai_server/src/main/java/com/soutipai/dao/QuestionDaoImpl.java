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
        String sql = "select id, question_name questionName, question_answer questionAnswer, question_type questionType, question_remark questionRemark from question_table where 1=1 and (" +
                "(case when question_name like ? then 1 else 0 end) + ".repeat(Math.max(0, words.size() - 1)) +
                "(case when question_name like ? then 1 else 0 end)) >= ?";
        String[] params = new String[words.size() + 1];
        for (int i = 0; i < words.size(); i++)
            params[i] = "%" + words.get(i).getText() + "%";
        params[words.size()] = Math.floor(words.size() * 0.8) + "";
        return GetJSONFromData.getJSONFromData(200, getForList(sql, Arrays.stream(params).toArray()));
    }

}
