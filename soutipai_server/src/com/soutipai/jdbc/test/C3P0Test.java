/*package com.soutipai.jdbc.test;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import org.testng.annotations.Test;

import java.sql.Connection;
import java.sql.SQLException;

public class C3P0Test {
    @Test
    public void testGetConnection() throws SQLException {
        ComboPooledDataSource cpds = new ComboPooledDataSource("intergalactoApp");

        Connection conn = cpds.getConnection();
        System.out.println(conn);

        //DataSources.destroy(cpds);
    }
}*/
/*c3p0-config.xml文件
<?xml version="1.0" encoding="UTF-8"?>
<c3p0-config>
<named-config name="intergalactoApp">
<!--mysql数据库连接的各项参数-->
<property name="driverClass">com.mysql.cj.jdbc.Driver</property>
<property name="jdbcUrl">jdbc:mysql:///soutipai?rewriteBatchedStatement=true</property>
<property name="user">root</property>
<property name="password">root</property>
<!--配置数据库连接池的初始连接数、最小链接数、获取连接数、最大连接数、最大空闲时间-->
<property name="acquireIncrement">5</property>
<property name="initialPoolSize">10</property>
<property name="minPoolSize">10</property>
<property name="maxPoolSize">100</property>
<property name="maxStatements">30</property>
<property name="maxStatementsPerConnection">2</property>
</named-config>
</c3p0-config>*/
