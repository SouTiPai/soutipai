package com.soutipai.demo;

import com.soutipai.SQLConnector.SQLConnector;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

public class Main {
    public static void main(String[] args){
        try {
            Connection con;
            con = SQLConnector.getConn();
            String sql = "SELECT * FROM test WHERE sal = ?";//此处'?'为需要插入的参数
            PreparedStatement ps = con.prepareStatement(sql);//创建PreparedStatement对象
            SQLConnector.getPS(ps, 2500);//插入sql中的问号里,非法插入会被转义
            ResultSet rs = ps.executeQuery();//获取查询寻结果

            while (rs.next()){
                HashMap<String,Object> hm;//创建HashMap对象
                hm = (HashMap<String, Object>) SQLConnector.setMap(new PeoPle(),rs);//获取HashMap
                PeoPle one = new PeoPle();//创建对象
                SQLConnector.setT(one,hm);//将结果包装

                print(one);
            }
            SQLConnector.closeAll(rs,ps,con);
        }catch (SQLException e){
            e.printStackTrace();
        }
    }

    public static void print(PeoPle p){
        System.out.println(p.empno+" "+p.ename+" "+p.job+" "+p.hireDate+" "+p.sal);
    }
}

