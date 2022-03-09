package com.soutipai.util;

import com.alibaba.druid.pool.DruidDataSourceFactory;
import org.apache.commons.dbcp2.BasicDataSourceFactory;

import javax.sql.DataSource;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import java.util.UUID;

/**
 * 操作数据库的工具类
 *
 * @author wutong
 */
public class JDBCUtils {

    private static DataSource source;

    static{
        try {
            Properties pros = new Properties();
            InputStream is = ClassLoader.getSystemClassLoader().getResourceAsStream("druid.properties");
            pros.load(is);
            source = DruidDataSourceFactory.createDataSource(pros);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 获取数据库的链接
     *
     * @return Connection
     * @author wutong
     */
    public static Connection getConnection() throws SQLException {
        return source.getConnection();
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
     * 获取UUID
     *
     * @return String 生成的UUID
     * @author wutong
     */
    public static String getUUID() {
        return UUID.randomUUID().toString().replace("-", "");
    }
}
