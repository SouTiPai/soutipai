package com.soutipai.dao;

import org.junit.Test;

import java.util.Random;

public class TestFunction {
    @Test
    public void test() {
        Random rd = new Random();
        for(int i = 0; i < 30; i++)
            System.out.print(36+rd.nextInt(10)/10.0 + " ");
    }
}
