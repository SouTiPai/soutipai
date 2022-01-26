package com.soutipai.util;

import com.soutipai.common.SQLConnector;

import java.sql.ResultSet;
import java.util.HashMap;

public class ToClass {
    public static void In(Object obj, ResultSet rs){
        HashMap<String,Object> hm;
        hm=(HashMap<String, Object>) SQLConnector.setMap(obj,rs);
        SQLConnector.setT(obj,hm);
    }
}
