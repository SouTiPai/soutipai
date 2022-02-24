package com.wutong.connection;

import org.junit.Test;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class ConnectionTest {

    @Test
    public void testConnection1() throws SQLException {

        Driver driver = new com.mysql.cj.jdbc.Driver();

        String url = "jdbc:mysql://127.0.0.1:3306/test";
        Properties info = new Properties();
        info.setProperty("user", "root");
        info.setProperty("password", "root");

        Connection conn = driver.connect(url, info);

        System.out.println(conn);
    }

    @Test
    public void testConnection2() throws Exception {
        Class<?> clazz = Class.forName("com.mysql.cj.jdbc.Driver");
        @SuppressWarnings("deprecation") Driver driver = (Driver) clazz.newInstance();
        String url = "jdbc:mysql://127.0.0.1:3306/test";
        Properties info = new Properties();
        info.setProperty("user", "root");
        info.setProperty("password", "root");

        Connection conn = driver.connect(url, info);

        System.out.println(conn);
    }

    @Test
    public void testConnection3() throws Exception {
        String URL = "jdbc:mysql://127.0.0.1:3306/soutipai";
        String USERNAME = "root";
        String PASSWORD = "root";
        Class<?> clazz = Class.forName("com.mysql.cj.jdbc.Driver");
        @SuppressWarnings("deprecation") Driver driver = (Driver) clazz.newInstance();

        DriverManager.registerDriver(driver);

        Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);

        System.out.println(conn);
    }

    @Test
    public void testConnection4() throws Exception {
        String URL = "jdbc:mysql://127.0.0.1:3306/soutipai";
        String USERNAME = "root";
        String PASSWORD = "root";

        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);

        System.out.println(conn);
    }

    @Test
    public void testConnection5() throws Exception {
        InputStream is = ConnectionTest.class.getClassLoader().getResourceAsStream("jdbc.properties");

        Properties pros = new Properties();
        pros.load(is);

        String user = pros.getProperty("user");
        String password = pros.getProperty("password");
        String url = pros.getProperty("url");
        String driverClass = pros.getProperty("driverClass");

        Class.forName(driverClass);

        Connection conn = DriverManager.getConnection(url,user,password);
        System.out.println(conn);
    }
}
