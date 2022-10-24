package com.soutipai.service;

import com.soutipai.dao.WrongBookDaoImpl;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/collections")
public class Collections {

    static WrongBookDaoImpl wrongBookDaoImpl = new WrongBookDaoImpl();

    @RequestMapping("/getAll")
    public String getAll(@RequestParam(value = "userId") String userId) {
        return wrongBookDaoImpl.getWrongBookByUserId(userId);
    }

    @RequestMapping("/add")
    public String add(@RequestParam(value = "userId") String userId, @RequestParam(value = "questionId") String questionId) {
        return wrongBookDaoImpl.addWrongBook(userId,questionId);
    }

    @RequestMapping("/delete")
    public String delete(@RequestParam(value = "id") String id) {
        return wrongBookDaoImpl.deleteWrongBookById(id);
    }
}
