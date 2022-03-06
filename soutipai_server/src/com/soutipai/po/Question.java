package com.soutipai.po;

public class Question {
    String id;
    String questionName;
    String questionAnswer;
    String questionType;
    String questionRemark;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getQuestionName() {
        return questionName;
    }

    public void setQuestionName(String questionName) {
        this.questionName = questionName;
    }

    public String getQuestionAnswer() {
        return questionAnswer;
    }

    public void setQuestionAnswer(String questionAnswer) {
        this.questionAnswer = questionAnswer;
    }

    public String getQuestionType() {
        return questionType;
    }

    public void setQuestionType(String questionType) {
        this.questionType = questionType;
    }

    public String getQuestionRemark() {
        return questionRemark;
    }

    public void setQuestionRemark(String questionRemark) {
        this.questionRemark = questionRemark;
    }

    @Override
    public String toString() {
        return "Question{" +
                "id='" + id + '\'' +
                ", questionName='" + questionName + '\'' +
                ", questionAnswer='" + questionAnswer + '\'' +
                ", questionType='" + questionType + '\'' +
                ", questionRemark='" + questionRemark + '\'' +
                '}';
    }
}
