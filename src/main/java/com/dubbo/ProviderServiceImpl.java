package com.dubbo;

import com.alibaba.dubbo.config.annotation.Service;

@Service
public class ProviderServiceImpl implements ProviderService {

    public String sayHello(String name) {
        return "Hello:" + name + "你好，你好~~";
    }

}
