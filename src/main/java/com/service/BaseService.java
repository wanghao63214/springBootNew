package com.service;

import com.dao.mapper.BaseMapper;

public class BaseService<T> {

    private BaseMapper<T> mapper;

    public void insert(T t) {
        try {
            mapper.insert(t);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
