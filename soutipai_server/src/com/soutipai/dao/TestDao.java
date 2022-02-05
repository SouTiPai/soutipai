package com.soutipai.dao;

import com.soutipai.common.Exceptions.LinkerException;
import com.soutipai.common.StringLinkerForSQL;

public class TestDao {
    private final String type="SELECT";
    private StringBuilder sql;
    public TestDao(String columnnames,String clause){
        try {
            sql= StringLinkerForSQL.Link(new String[]{"SELECT",columnnames,"FROM","test","WHERE",clause});
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
