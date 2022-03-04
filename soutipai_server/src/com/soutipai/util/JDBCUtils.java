package com.soutipai.util;

import java.io.InputStream;
import java.lang.reflect.Field;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.UUID;

/**
 * 操作数据库的工具类
 *
 * @author wutong
 */
public class JDBCUtils {
    /**
     * 获取数据库的链接
     *
     * @return Connection
     * @author wutong
     */
    public static Connection getConnection() throws Exception {
        InputStream is = ClassLoader.getSystemClassLoader().getResourceAsStream("jdbc.properties");
        Properties pros = new Properties();
        pros.load(is);
        String URL = pros.getProperty("url");
        String USERNAME = pros.getProperty("user");
        String PASSWORD = pros.getProperty("password");
        String DRIVERCLASS = pros.getProperty("driverClass");
        Class.forName(DRIVERCLASS);
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }

    /**
     * 关闭链接,Statement和结果集操作
     *
     * @param conn SQL数据库链接
     * @param ps   Statement(可选）
     * @param rs   结果集（可选）
     * @author wutong
     */
    public static void closeResource(Connection conn, Statement ps, ResultSet rs) {
        try {
            closeResource(conn, ps);
            if (rs != null) {
                rs.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void closeResource(Connection conn, Statement ps) {
        try {
            closeResource(conn);
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void closeResource(Connection conn) {
        try {
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 通用的增删改操作
     *
     * @param sql SQL语句，使用"?"作为占位符
     * @param args 可变形参列表，其形参个数应与sql中的占位符个数一致
     * @return int 返回影响行数，若失败则返回-1
     * @author wutong
     */
    public static int update(String sql, Object... args) {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            for (int i = 0; i < args.length; i++) {
                ps.setObject(i + 1, args[i]);
            }
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.closeResource(conn, ps);
        }
        return -1;
    }

    /**
     * 通用的查询操作
     *
     * @param clazz 查询结果所属类,请使用 (类名).class
     * @param sql 查询语句
     * @param args 可变形参列表，其形参个数应与sql中的占位符个数一致
     * @return List 返回列表对象
     * @author wutong
     */
    public static <T> List<T> getForList(Class<T> clazz, String sql, Object... args){
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtils.getConnection();
            ps = conn.prepareStatement(sql);
            for (int i = 0; i < args.length; i++) {
                ps.setObject(i + 1, args[i]);
            }
            rs = ps.executeQuery();
            ResultSetMetaData rsmd = rs.getMetaData();
            int columnCount = rsmd.getColumnCount();
            ArrayList<T> li = new ArrayList<>();
            while (rs.next()) {
                T t = clazz.getDeclaredConstructor().newInstance();
                for (int i = 0; i < columnCount; i++) {
                    Object columnValue = rs.getObject(i + 1);
                    String columnLabel = rsmd.getColumnLabel(i + 1);

                    Field field = clazz.getDeclaredField(columnLabel);
                    field.setAccessible(true);
                    field.set(t, columnValue);
                }
                li.add(t);
            }
            return li;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.closeResource(conn, ps, rs);
        }
        return null;
    }

    /**
     * 通用的查询操作
     *
     * @param clazz 查询结果所属类,请使用 (类名).class
     * @param sql 查询语句
     * @param args 可变形参列表，其形参个数应与sql中的占位符个数一致
     * @return T 返回对象
     * @author wutong
     */
    public static <T> T getForClass(Class<T> clazz, String sql, Object... args){
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtils.getConnection();
            ps = conn.prepareStatement(sql);
            for (int i = 0; i < args.length; i++) {
                ps.setObject(i + 1, args[i]);
            }
            rs = ps.executeQuery();
            ResultSetMetaData rsmd = rs.getMetaData();
            int columnCount = rsmd.getColumnCount();
            if (rs.next()) {
                T t = clazz.getDeclaredConstructor().newInstance();
                for (int i = 0; i < columnCount; i++) {
                    Object columnValue = rs.getObject(i + 1);
                    String columnLabel = rsmd.getColumnLabel(i + 1);

                    Field field = clazz.getDeclaredField(columnLabel);
                    field.setAccessible(true);
                    field.set(t, columnValue);
                }
                return t;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.closeResource(conn, ps, rs);
        }
        return null;
    }

    /**
     * 获取UUID
     * @return String 生成的UUID
     * @author wutong
     */
    public static String getUUID(){
        return UUID.randomUUID().toString().replace("-","");
    }
}
