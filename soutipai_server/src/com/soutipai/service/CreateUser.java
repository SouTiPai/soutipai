package com.soutipai.service;

import com.alibaba.fastjson.JSON;
import com.soutipai.po.User;
import com.soutipai.util.JDBCUtils;
import org.junit.Test;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

public class CreateUser {
    //创建用户模板
    @Test
    public void test0() {
        String sql = "INSERT INTO user_table(id,user_id,user_name,user_password,user_age,user_sex,user_birthday) VALUES(?,?,?,?,?,?,?)";
        String id = JDBCUtils.getUUID();
        String userId = "abcdef";
        String name = "haha";
        String password = "hvglagh3645";
        int age = 80;
        String sex = "男";
        @SuppressWarnings("SimpleDateFormat")
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date date = null;
        try {
            date = sdf.parse("1950-1-1");
        } catch (ParseException e) {
            e.printStackTrace();
        }
        assert date != null;
        Date birthday = new Date(date.getTime());
        System.out.println(JDBCUtils.update(sql, id, userId, name, password, age, sex, birthday));
    }

    @Test
    public void test1() {
        String sql = "SELECT id,user_id userId,user_name userName,user_password userPassword,user_age userAge,user_sex userSex ,user_birthday userBirthday,user_level userLevel FROM user_table WHERE del_flag=0";
        List<User> user = JDBCUtils.getForList(User.class, sql);
        assert user != null;
        user.forEach(System.out::println);
        System.out.println(JSON.toJSONString(user));
    }
}
