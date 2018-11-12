package com.dubbo;

import com.alibaba.dubbo.config.annotation.Reference;
import org.springframework.boot.CommandLineRunner;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

public class Consumer implements CommandLineRunner {

    @Reference
    public ProviderService service;

    @Override
    public void run(String... args) {
        String name = "system start";
        System.out.println(service.sayHello(name));
        System.out.println("调用完成");
    }

    @RequestMapping(value = "/dubbo", method = RequestMethod.GET)
    @ResponseBody
    public String run(String name) {
        name = name == null ? "system start" : name;
        return service.sayHello(name);
    }

}
