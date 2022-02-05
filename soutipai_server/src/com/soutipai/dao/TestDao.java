package com.soutipai.dao;

import com.soutipai.common.Exceptions.LinkerException;
import com.soutipai.util.StringLinkerForSQL;

public class TestDao {
    private final String type="SELECT";
    private StringBuilder sql;
    public TestDao(String columnnames,String clause){
        try {
            if(!clause.isEmpty()) {
                sql = StringLinkerForSQL.Link(new String[]{"SELECT", columnnames, "FROM", "test", "WHERE", clause});
            }else{
                sql = StringLinkerForSQL.Link(new String[]{"SELECT", columnnames, "FROM", "test"});
            }
        } catch (LinkerException e) {
            e.printStackTrace();
        }
    }
    public String getType() {
        return type;
    }

    public StringBuilder getSql() {
        return sql;
    }
}
