package com.dao.mapper;

import com.dao.beans.MtCompletedOrderExample;
import java.util.List;
import java.util.Map;

public interface MtCompletedOrderMapper_Manual {
    List<Map<String, Object>> selectListMap(MtCompletedOrderExample mtCompletedOrderExample);

    Map<String, Object> selectMap(String faLogin);

    List<Map<String, Object>> selectFoodDetailsListMap(Map paraMap);
}