package com.soutipai;

import com.soutipai.utils.AuthService;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class})
public class SoutipaiServerApplication {
    public static String token = AuthService.getAuth("xSFGnR7evCb5Ba8YZE8rMOLY", "4wwZiVflHQuwKPHmY2cpuhoZFlLzD8x4");
    public static void main(String[] args) {
        SpringApplication.run(SoutipaiServerApplication.class, args);
    }

}