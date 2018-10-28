package com.dao.mapper;

import com.dao.beans.StudyPlanDetailExample;
import java.util.List;
import java.util.Map;

public interface StudyPlanDetailMapper_Manual {
    List<Map<String,Object>> selectListMap(StudyPlanDetailExample studyPlanDetailExample);
}