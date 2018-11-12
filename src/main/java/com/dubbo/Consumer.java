package com.dubbo;

import com.alibaba.dubbo.config.annotation.Reference;
import org.springframework.boot.CommandLineRunner;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

public class Consumer{

    @Reference
    public ProviderService service;

    @RequestMapping(value = "/dubbo", method = RequestMethod.GET)
    @ResponseBody
    public String run(String name) {
        return service.sayHello(name);
    }

}
