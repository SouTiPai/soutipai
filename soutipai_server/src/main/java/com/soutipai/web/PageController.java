package com.soutipai.web;

import com.soutipai.bean.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.List;

//此处为测试网站
@Controller
@RequestMapping("/html")
public class PageController {

    @GetMapping("/")
    public String index() {
        return "index";
    }

    @GetMapping("/test")
    public String test() {
        int i = 1 / 0;//服务器内部运行异常 跳转500页面
        return "index";
    }

    @GetMapping("/user")
    public String testUser(Model model) {
        List<User> userList = new ArrayList<>();
        User user = new User("admin", "管理员", "666666");
        User user1 = new User("admin1", "管理员1", "666666");
        userList.add(user);
        userList.add(user1);
        model.addAttribute("users", userList);
        model.addAttribute("user", user);
        model.addAttribute("user1", user1);
        return "userInfo";
    }

    @GetMapping("/code")
    public String Code() {
        return "code.docx";
    }
}