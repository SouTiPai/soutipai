package com.soutipai.service;

import com.soutipai.common.GetAnswersFromTable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

@RestController
public class GetAnswers {
    @RequestMapping("/getAnswers")
    public String getAnswer(HttpServletRequest request){
        String question = request.getParameter("question");
        return GetAnswersFromTable.getAnswers(question);
    }
}
