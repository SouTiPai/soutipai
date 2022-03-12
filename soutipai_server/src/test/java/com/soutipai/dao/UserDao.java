package com.soutipai.dao;

import com.soutipai.bean.User;

import java.sql.Connection;
import java.util.List;

public interface UserDao {
    /**
     * 将user对象添加到数据库中
     *
     * @param conn 数据库连接
     * @param user User对象
     * @author wutong
     */
    void insert(Connection conn, User user);

    /**
     * 针对指定的id，删除表中的一条记录
     *
     * @param conn 数据库连接
     * @param id   id
     * @author wutong
     */
    void deleteById(Connection conn, String id);

    /**
     * 针对内存中的User对象，去修改表中指定的记录
     *
     * @param conn 数据库连接
     * @param user User对象
     * @param id   id
     * @author wutong
     */
    void update(Connection conn, User user, String id);

    /**
     * 针对指定id查询得到对应的User对象
     *
     * @param conn 数据库连接
     * @param id   id
     * @return User User对象
     * @author wutong
     */
    User getUserById(Connection conn, String id);

    /**
     * 查询表中所有记录构成的集合
     *
     * @param conn 数据库连接
     * @return List User对象集合
     * @author wutong
     */
    List<User> getAll(Connection conn);

    /**
     * 返回数据表中记录的条目数
     *
     * @param conn 数据库链接
     * @return long 记录条数
     */
    Long getCount(Connection conn);
}
