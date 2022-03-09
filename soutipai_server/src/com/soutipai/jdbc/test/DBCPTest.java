/*package com.soutipai.jdbc.test;

import org.apache.commons.dbcp2.BasicDataSourceFactory;
import org.junit.Test;

import javax.sql.DataSource;
import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.util.Properties;

public class DBCPTest {
    @Test
    public void testGetConnection() throws Exception{
        Properties pros = new Properties();
        FileInputStream is=new FileInputStream("src/dbcp.properties");
        pros.load(is);
        DataSource source = BasicDataSourceFactory.createDataSource(pros);

        Connection conn= source.getConnection();
        System.out.println(conn);
    }
}*/

/*
        dbcp.properties文件
        driverClassName=com.mysql.cj.jdbc.Driver
        url=jdbc:mysql://127.0.0.1:3306/soutipai?rewriteBatchedStatement=true
        username=root
        password=root

        initialSize=10
*/
