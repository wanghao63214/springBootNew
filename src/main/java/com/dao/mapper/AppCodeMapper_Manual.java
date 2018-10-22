package com.dao.mapper;

import com.dao.beans.AppCodeExample;
import java.util.List;
import java.util.Map;

public interface AppCodeMapper_Manual {
    List<Map<String,Object>> selectListMapForSelect(AppCodeExample appCodeExample);
    List<Map<String,Object>> selectListMap(AppCodeExample appCodeExample);
}