package com.soutipai.service;

import com.soutipai.dao.QuestionDaoImpl;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/answers")
public class Answers {
    @RequestMapping("/get")
    public String get(@RequestParam(value = "question") String question) {
        QuestionDaoImpl questionDao = new QuestionDaoImpl();
        return questionDao.getQuestionByName(question);
    }
}
