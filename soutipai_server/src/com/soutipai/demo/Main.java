package com.soutipai.demo;

import com.soutipai.SQLConnector.SQLConnector;

public class Main {
    public static void main(String[] args){
        SQLConnector sqlConnector = new SQLConnector("SELECT * FROM test");
        sqlConnector.getData();
    }
}

