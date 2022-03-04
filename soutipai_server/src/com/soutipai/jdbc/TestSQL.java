package com.soutipai.jdbc;

import com.soutipai.util.JDBCUtils;
import org.junit.Test;

import java.util.UUID;

public class TestSQL {
    @Test
    public void testUpdate(){
        String sql = "insert into question_table (id,question_name,question_answer) values (?,?,?)";
        String id = JDBCUtils.getUUID();
        String name="有以下定义：int a; long b; double x,y;则下列正确的是( )。\nA) a%(int)(x-y)\nB) a=x!=y\nC) (a*y)%b\nD) y=x+y=x";
        String answer="A";
        System.out.println(JDBCUtils.update(sql,id,name,answer));
    }
}
