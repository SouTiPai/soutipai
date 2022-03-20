package com.soutipai;

import org.apdplat.word.WordSegmenter;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class})
public class SoutipaiServerApplication {

    public static void main(String[] args) {
        SpringApplication.run(SoutipaiServerApplication.class, args);
        WordSegmenter w = new WordSegmenter();
    }

}
