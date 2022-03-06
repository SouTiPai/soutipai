package com.soutipai.jdbc;

import com.soutipai.po.Customer;
import com.soutipai.util.JDBCUtils;
import org.junit.Test;

import java.io.*;
import java.sql.*;

public class TestSQL {
    @Test
    public void testInsert() throws Exception {
        Connection conn = JDBCUtils.getConnection();
        String sql = "INSERT INTO test.customers(name,email,birth,photo) VALUES(?,?,?,?)";

        PreparedStatement ps=conn.prepareStatement(sql);

        ps.setObject(1,"张宇豪");
        ps.setObject(2,"zhang@qq.com");
        ps.setObject(3,"1992-09-08");
        FileInputStream is = new FileInputStream("C://Users/y/Pictures/Camera Roll/022.jpg");
        ps.setObject(4,is);

        ps.execute();

        JDBCUtils.closeResource(conn,ps);
    }

    @Test
    public void testQuery(){
        Connection conn= null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        InputStream is= null;
        FileOutputStream fos = null;
        try {
            conn = JDBCUtils.getConnection();
            String sql="select id,name,email,birth,photo from test.customers where id = ?";

            ps = conn.prepareStatement(sql);
            ps.setInt(1,20);

            rs = ps.executeQuery();
            if(rs.next()){
                int id=rs.getInt("id");
                String name=rs.getString("name");
                String email=rs.getString("email");
                Date birth=rs.getDate("birth");

                Customer cust = new Customer(id,name,email,birth);
                System.out.println(cust);

                Blob photo = rs.getBlob("photo");
                is = photo.getBinaryStream();
                fos = new FileOutputStream("qwq.jpg");
                byte[] buffer = new byte[1024];
                int len;
                while((len = is.read(buffer))!=-1) {
                    fos.write(buffer, 0, len);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (is != null) {
                    is.close();
                }
                if (fos != null) {
                    fos.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
            JDBCUtils.closeResource(conn, ps, rs);
        }
    }
}
