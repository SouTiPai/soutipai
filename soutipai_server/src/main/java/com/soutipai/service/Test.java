package com.soutipai.service;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/test")
public class Test {
    @RequestMapping("/")
    public String test() {
        return "HelloWorld!";
    }
}
