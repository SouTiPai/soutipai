package com.soutipai.dao;

import com.soutipai.bean.Question;
import org.apdplat.word.segmentation.Word;

import java.sql.Connection;
import java.util.List;

public interface QuestionDao {
    //题目查询
    List<Question> getQuestionByName(Connection conn, List<Word> words);
}
