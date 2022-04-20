package com.soutipai.dao;

import org.junit.Test;

import java.util.UUID;

public class TestFunction {
    @Test
    public void test() {
        for(int i = 0; i < 100; i++) {
            System.out.println(UUID.randomUUID().toString().replace("-", ""));
        }
    }
}
