package com.soutipai.dao.junit;

import com.alibaba.fastjson.JSON;
import com.soutipai.dao.UserDaoImpl;
import com.soutipai.bean.User;
import com.soutipai.utils.JDBCUtils;
import org.junit.Test;

import java.sql.Connection;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

public class UserDaoImplTest {

    private final UserDaoImpl dao = new UserDaoImpl();

    @Test
    public void insert() {
        Connection conn = null;
        try {
            conn = JDBCUtils.getConnection();
            User user;
            {
                String id = JDBCUtils.getUUID();
                String userId = "0";
                String name = "张三";
                String password = "luoxiangshuoxingfa";
                int age = 18;
                String sex = "男";
                @SuppressWarnings("SimpleDateFormat")
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date date = null;
                try {
                    date = sdf.parse("1980-01-01");
                } catch (ParseException e) {
                    e.printStackTrace();
                }
                assert date != null;
                Date birthday = new Date(date.getTime());
                user = new User(id, userId, name, password, age, sex, birthday, 0, 103);
            }
            dao.insert(conn, user);
            System.out.println("添加成功");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.closeResource(conn);
        }
    }

    @Test
    public void deleteById() {
        Connection conn = null;
        try {
            conn = JDBCUtils.getConnection();
            List<User> list = dao.getAll(conn);
            dao.deleteById(conn, list.get(list.size() - 1).getId());
            System.out.println("删除成功");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.closeResource(conn);
        }
    }

    @Test
    public void update() {
        Connection conn = null;
        try {
            conn = JDBCUtils.getConnection();
            List<User> list = dao.getAll(conn);
            list.get(list.size()-1).setUserName("李四");
            dao.update(conn,list.get(list.size()-1),list.get(list.size()-1).getId());
            System.out.println("修改成功");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.closeResource(conn);
        }
    }

    @Test
    public void getUserById() {
        Connection conn = null;
        try {
            conn = JDBCUtils.getConnection();
            List<User> list = dao.getAll(conn);
            System.out.println(JSON.toJSONString(list.get(list.size()-1)));
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.closeResource(conn);
        }
    }


    public String getAll() {
        Connection conn = null;
        try {
            conn = JDBCUtils.getConnection();
            List<User> list = dao.getAll(conn);
            return JSON.toJSONString(list);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.closeResource(conn);
        }
        return null;
    }

    @Test
    public void getCount() {
        Connection conn = null;
        try {
            conn = JDBCUtils.getConnection();
            System.out.println(dao.getCount(conn));
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.closeResource(conn);
        }
    }
}