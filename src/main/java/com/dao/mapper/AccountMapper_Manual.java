package com.dao.mapper;

import com.dao.beans.AccountExample;
import java.util.List;
import java.util.Map;

public interface AccountMapper_Manual {

    List<Map<String, Object>> selectListMap(AccountExample accountExample);
}