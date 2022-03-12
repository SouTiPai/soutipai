package com.soutipai.dao;

import com.soutipai.bean.User;
import com.soutipai.utils.JDBCUtils;

import java.sql.Connection;
import java.util.List;

public class UserDaoImpl extends BaseDao<User> implements UserDao {

    @Override
    public void insert(Connection conn, User user) {
        String sql = "insert into user_table(id, user_id, user_name, user_password, user_age, user_sex, user_birthday, user_class, user_level) values(?,?,?,?,?,?,?,?,?)";
        update(conn, sql, JDBCUtils.getUUID(), user.getUserId(), user.getUserName(), user.getUserPassword(), user.getUserAge(), user.getUserSex(), user.getUserBirthday(), user.getUserClass(), user.getUserLevel());
    }

    @Override
    public void deleteById(Connection conn, String id) {
        String sql = "update user_table set del_flag = 1 where id = ?";
        update(conn, sql, id);
    }

    @Override
    public void update(Connection conn, User user, String id) {
        String sql = "update user_table set user_id = ?, user_name = ?, user_password = ?, user_age = ?, user_sex = ?, user_birthday = ?, user_class = ?, user_level = ? where id = ?";
        update(conn, sql, user.getUserId(), user.getUserName(), user.getUserPassword(), user.getUserAge(), user.getUserSex(), user.getUserBirthday(), user.getUserClass(), user.getUserLevel(), id);
    }

    @Override
    public User getUserById(Connection conn, String id) {
        String sql = "select id, user_id userId, user_name userName, user_password userPassword, user_age userAge, user_sex userSex, user_birthday userBirthday, user_class userClass, user_level userLevel from user_table where id = ? and del_flag = 0";
        return getForClass(conn, sql, id);
    }

    @Override
    public List<User> getAll(Connection conn) {
        String sql = "select id, user_id userId, user_name userName, user_password userPassword, user_age userAge, user_sex userSex, user_birthday userBirthday, user_class userClass, user_level userLevel from user_table where del_flag = 0";
        return getForList(conn, sql);
    }

    @Override
    public Long getCount(Connection conn) {
        String sql = "select count(*) from user_table";
        return getValue(conn, sql);
    }
}
