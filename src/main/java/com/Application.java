package com;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.dao.mapper")
public class Application implements CommandLineRunner {

    public static void main(String[] args) {
        // TODO Auto-generated method stub
        SpringApplication.run(Application.class, args);
    }

    @Override
    public void run(String... args) throws Exception {
        System.err.println("服务提供者------>>启动完毕");
    }
}
