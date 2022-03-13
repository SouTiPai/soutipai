package com.soutipai.service;

import com.soutipai.dao.junit.UserDaoImplTest;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class Start {

    @RequestMapping("/hello")
    public String hello(){
        System.out.println("connected");
        return new UserDaoImplTest().getAll();
    }

}
