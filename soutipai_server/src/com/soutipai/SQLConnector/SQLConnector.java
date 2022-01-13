package com.soutipai.SQLConnector;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class SQLConnector {
    final static String URL = "jdbc:mysql://127.0.0.1:3306/soutipai";
    final static String USERNAME = "root";
    final static String PASSWORD = "root";

    private static Connection conn;

    static{
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    //获取数据库连接
    public static Connection getConn(){
        try {
            if (conn==null||conn.isClosed()) {
                conn= DriverManager.getConnection(URL, USERNAME, PASSWORD);
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return conn;
    }

    //关闭资源
    public static void closeAll(ResultSet rs, PreparedStatement ps, Connection conn){
        try {
            if (rs!=null) {
                rs.close();
            }
            if (ps!=null) {
                ps.close();
            }
            if (conn!=null) {
                conn.close();
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public static PreparedStatement getPS(PreparedStatement ps, Object... objects) {
        for (int i = 0; i < objects.length; i++) {
            try {
                ps.setObject(i + 1, objects[i]);
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return ps;
    }

    public static Map<String, Object> setMap(Object obj, ResultSet rs){
        HashMap<String, Object> hm=new HashMap<>();
        Field[] fields=obj.getClass().getDeclaredFields();
        for (Field field : fields) {
            try {
                hm.put(field.getName(), rs.getObject(field.getName()));
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return hm;
    }

    public static void setT(Object obj, Map<String, Object> map1) {

        Class<?> c = obj.getClass();
        Method[] methods = c.getMethods();
        for (Method m : methods) {
            if (m.getName().startsWith("set")) {
                String name = m.getName();
                name = name.substring(3, 4).toLowerCase() + name.substring(4);

                if (map1.containsKey(name)) {
                    try {
                        m.invoke(obj, map1.get(name));
                    } catch (Exception e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                }
            }
        }
    }
}
