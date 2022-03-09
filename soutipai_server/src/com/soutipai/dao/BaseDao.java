package com.soutipai.dao;

import com.soutipai.util.JDBCUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

/**
 * 操作数据库数据库的模板类
 *
 * @author wutong
 */
public abstract class BaseDao<T> {

    private final Class<T> clazz;

    {
        //获取当前BaseDao的子类继承的父类中的泛型
        Type genericSuperclass = this.getClass().getGenericSuperclass();
        ParameterizedType paramType = (ParameterizedType) genericSuperclass;

        Type[] typeArguments = paramType.getActualTypeArguments();//获取父类的泛型参数
        //noinspection unchecked
        clazz = (Class<T>) typeArguments[0];//泛型的第一个参数
    }

    /**
     * 通用的增删改操作
     *
     * @param conn 事务操作时需传入链接（可选）
     * @param sql  SQL语句，使用"?"作为占位符
     * @param args 可变形参列表，其形参个数应与sql中的占位符个数一致
     * @return int 返回影响行数，若失败则返回-1
     * @author wutong
     */
    public int update(Connection conn, String sql, Object... args) {
        try {
            QueryRunner runner = new QueryRunner();
            return runner.update(conn,sql,args);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public int update(String sql, Object... args) {
        Connection conn = null;
        try {
            conn = JDBCUtils.getConnection();
            return update(conn, sql, args);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.closeResource(conn);
        }
        return -1;
    }


    /**
     * 通用的查询操作
     *
     * @param conn 事务操作时需传入链接（可选）
     * @param sql  查询语句
     * @param args 可变形参列表，其形参个数应与sql中的占位符个数一致
     * @return List 返回列表对象
     * @author wutong
     */

    public List<T> getForList(Connection conn, String sql, Object... args) {
        QueryRunner runner = new QueryRunner();
        BeanListHandler<T> handler = new BeanListHandler<>(clazz);
        try {
            return runner.query(conn,sql,handler,args);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<T> getForList(String sql, Object... args) {
        Connection conn = null;
        try {
            conn = JDBCUtils.getConnection();
            return getForList(conn, sql, args);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.closeResource(conn);
        }
        return null;
    }

    /**
     * 通用的查询操作
     *
     * @param conn 事务操作时需传入链接（可选）
     * @param sql  查询语句
     * @param args 可变形参列表，其形参个数应与sql中的占位符个数一致
     * @return T 返回对象
     * @author wutong
     */

    public T getForClass(Connection conn, String sql, Object... args) {
        QueryRunner runner = new QueryRunner();
        BeanHandler<T> handler = new BeanHandler<>(clazz);
        try {
            return runner.query(conn,sql,handler,args);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public T getForClass(String sql, Object... args) {
        Connection conn = null;
        try {
            conn = JDBCUtils.getConnection();
            return getForClass(conn, sql, args);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.closeResource(conn);
        }
        return null;
    }

    /**
     * 特殊需求的查询操作
     *
     * @param conn 事务操作时需传入链接（可选）
     * @param sql  查询语句
     * @param args 可变形参列表，其形参个数应与sql中的占位符个数一致
     * @return T 返回对象
     * @author wutong
     */
    public <E> E getValue(Connection conn, String sql, Object... args) {
        QueryRunner runner = new QueryRunner();
        ScalarHandler<T> handler = new ScalarHandler<>();
        try {
            return (E) runner.query(conn,sql,handler,args);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}