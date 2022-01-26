package com.soutipai.jdbc;

import com.alibaba.fastjson.JSON;
import com.soutipai.common.SQLConnector;
import com.soutipai.dao.TestDao;
import com.soutipai.po.PeoPle;
import com.soutipai.util.ToClass;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Test {
    public static void run() {
        List<PeoPle> list = new ArrayList<>();
        String json;
        try {
            Connection con;
            con = SQLConnector.getConn();
            /*String sql = "SELECT * FROM test WHERE sal = ?";//此处'?'为需要插入的参数
            PreparedStatement ps = con.prepareStatement(sql);//创建PreparedStatement对象
            SQLConnector.getPS(ps, 2500);//插入sql中的问号里,非法插入会被转义*/
            PreparedStatement ps = con.prepareStatement(String.valueOf(new TestDao("*", "").getSql()));
            ResultSet rs = ps.executeQuery();//获取查询寻结果

            while (rs.next()) {
                PeoPle people = new PeoPle();//创建对象
                ToClass.In(people,rs);
                list.add(people);
                print(people);
            }

            json= JSON.toJSONString(list);

            System.out.println(json);


            SQLConnector.closeAll(rs, ps, con);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void print(PeoPle p) {
        System.out.println(p.getEmpno() + " " + p.getEname() + " " + p.getJob() + " " + p.getHireDate() + " " + p.getSal());
    }
}
