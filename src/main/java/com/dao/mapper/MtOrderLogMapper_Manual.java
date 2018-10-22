package com.dao.mapper;

import com.dao.beans.MtOrderLogExample;
import java.util.List;
import java.util.Map;

public interface MtOrderLogMapper_Manual {
    List<Map<String,Object>> selectListMap(MtOrderLogExample mtOrderLogExample);
}