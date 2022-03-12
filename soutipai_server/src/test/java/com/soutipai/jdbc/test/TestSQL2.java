package com.soutipai.jdbc.test;

import com.soutipai.bean.Customer;
import com.soutipai.dao.UserDaoImpl;
import com.soutipai.utils.JDBCUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;
import org.junit.Test;

import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import com.mysql.cj.jdbc.Driver;

public class TestSQL2 {

    @Test
    public void testUpdate() {
        Connection conn = null;
        try {
            conn = JDBCUtils.getConnection();
            conn.setAutoCommit(false);
            String sql1 = "update test.user_table set balance =balance - 100 where user = ?";
            new UserDaoImpl().update(conn, sql1, "AA");
            //System.out.println(10 / 0);
            String sql2 = "update test.user_table set balance =balance + 100 where user = ?";
            new UserDaoImpl().update(conn, sql2, "BB");
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
    }

    @Test
    public void testQuery() {
        Connection conn = null;
        try {
            QueryRunner runner = new QueryRunner();
            conn = JDBCUtils.getConnection();
            String sql = "select id, name, email, birth from test.customers where id = ?";
            ResultSetHandler<Customer> handler = resultSet -> {
                if (resultSet.next()) {
                    int id = resultSet.getInt("id");
                    String name = resultSet.getString("name");
                    String email = resultSet.getString("email");
                    Date birth = resultSet.getDate("birth");
                    return new Customer(id, name, email, birth);
                }
                return null;
            };
            Customer customer = runner.query(conn, sql, handler, 20);
            System.out.println(customer);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.closeResource(conn);
        }
    }
}