package com.soutipai.common;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

public class SQLConnector {
    static String URL = null;
    static String USERNAME = null;
    static String PASSWORD = null;
    static String DRIVERCLASS = null;

    private static Connection conn;

    static {
        try {
            InputStream is = SQLConnector.class.getClassLoader().getResourceAsStream("jdbc.properties");
            Properties pros = new Properties();
            pros.load(is);
            URL = pros.getProperty("url");
            USERNAME = pros.getProperty("user");
            PASSWORD = pros.getProperty("password");
            DRIVERCLASS = pros.getProperty("driverClass");
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            Class.forName(DRIVERCLASS);
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    //获取数据库连接
    public static Connection getConn() {
        try {
            if (conn == null || conn.isClosed()) {
                conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return conn;
    }

    //关闭资源
    public static void closeAll(ResultSet rs, PreparedStatement ps, Connection conn) {
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public static void getPS(PreparedStatement ps, Object... objects) {
        for (int i = 0; i < objects.length; i++) {
            try {
                ps.setObject(i + 1, objects[i]);
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    }

    public static Map<String, Object> setMap(Object obj, ResultSet rs) {
        HashMap<String, Object> hm = new HashMap<>();
        Field[] fields = obj.getClass().getDeclaredFields();
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

    public static void setT(Object obj, Map<String, Object> map) {

        Class<?> c = obj.getClass();
        Method[] methods = c.getMethods();
        for (Method m : methods) {
            if (m.getName().startsWith("set")) {
                String name = m.getName();
                name = name.substring(3, 4).toLowerCase() + name.substring(4);

                if (map.containsKey(name)) {
                    try {
                        m.invoke(obj, map.get(name));
                    } catch (Exception e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                }
            }
        }
    }
}
