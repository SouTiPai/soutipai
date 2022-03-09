package com.soutipai.jdbc.test;

import com.soutipai.dao.BaseDao;
import com.soutipai.util.JDBCUtils;

import java.sql.Connection;
import java.sql.SQLException;

public class TestSQL2 {

    /*@Test
    public void testUpdate() {
        Connection conn = null;
        try {
            conn = JDBCUtils.getConnection();
            conn.setAutoCommit(false);
            String sql1 = "update test.user_table set balance =balance - 100 where user = ?";
            BaseDao.update(conn, sql1, "AA");
            //System.out.println(10 / 0);
            String sql2 = "update test.user_table set balance =balance + 100 where user = ?";
            BaseDao.update(conn, sql2, "BB");
            conn.commit();
        } catch (Exception e) {
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
            e.printStackTrace();
                ex.printStackTrace();
            }
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            JDBCUtils.closeResource(conn);
        }
    }*/
}