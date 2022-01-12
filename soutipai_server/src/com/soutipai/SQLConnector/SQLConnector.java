package com.soutipai.SQLConnector;

import java.sql.*;

public class SQLConnector{
    //声明sql语句
    String sql;
    //声明Connection对象
    Connection con;
    //驱动程序名
    String driver = "com.mysql.cj.jdbc.Driver";
    //URL指向要访问的数据库名soutipai
    String url = "jdbc:mysql://127.0.0.1:3306/soutipai";
    //MySQL配置时的用户名
    String user = "root";
    //MySQL配置时的密码
    String password = "root";
    public SQLConnector(String s){
        sql = s;
    }

    public synchronized void getData(){
        //遍历查询结果集
        try {
            //加载驱动程序
            Class.forName(driver);
            //1.getConnection()方法，连接MySQL数据库！！
            con = DriverManager.getConnection(url, user, password);
            if (!con.isClosed()) {
                System.out.println("Succeeded connecting to the Database");
            }
            //2.创建statement类对象，用来执行SQL语句！！
            Statement statement = con.createStatement();
            //3.ResultSet类，用来存放获取的结果集！！
            ResultSet rs = statement.executeQuery(sql);
            System.out.println("-----------------");
            System.out.println("执行结果如下所示：");
            System.out.println("-----------------");
            System.out.println("姓名" + "\t" + "职称");
            System.out.println("-----------------");

            String job;
            String name;
            while (rs.next()) {
                //获取job这列数据
                job = rs.getString("job");
                //获取ename这列数据
                name = rs.getString("ename");
                //输出结果
                System.out.println(name + "\t" + job);
            }
            rs.close();
            con.close();
        }catch (ClassNotFoundException e){
            //数据库驱动类异常处理
            System.out.println("Sorry, can't find the Driver");
            e.printStackTrace();
        } catch (Exception e){
            //数据库连接失败异常处理
            e.printStackTrace();
        }// TODO: handle exception
        finally {
            System.out.println("数据库程序运行结束！！");
        }
    }
}
