package com.soutipai.utils;

import com.alibaba.druid.pool.DruidDataSourceFactory;
import org.apache.commons.dbutils.DbUtils;

import javax.sql.DataSource;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
            InputStream is = new FileInputStream("soutipai_server/src/main/resources/druid.properties");
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
     * @param args 需要关闭的链接等
     * @author wutong
     */
    public static void closeResource(Object... args){
        for (Object arg : args) {
            if(arg instanceof Connection){
                DbUtils.closeQuietly((Connection) arg);
            }else if(arg instanceof PreparedStatement){
                DbUtils.closeQuietly((PreparedStatement) arg);
            }else if(arg instanceof ResultSet){
                DbUtils.closeQuietly((ResultSet) arg);
            }
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
