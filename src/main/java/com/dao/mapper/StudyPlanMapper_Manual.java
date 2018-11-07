package com.dao.mapper;

import com.dao.beans.StudyPlan;
import com.dao.beans.StudyPlanExample;
import java.util.List;
import java.util.Map;

public interface StudyPlanMapper_Manual {

    List<Map<String, Object>> selectListMap(StudyPlanExample studyPlanExample);

    void batchInsert(List<StudyPlan> list);
}