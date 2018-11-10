package com.utils;

import com.alibaba.fastjson.JSON;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class LambdaUtils<T>{

    public List<Map<String, Object>> ListObjectToListMap(List<T> list) {
        return list.stream().map(this::toMap).collect(Collectors.toList());
    }
    public Map<String, Object> toMap(Object o) {
        return JSON.parseObject(JSON.toJSONString(o));
    }
}
