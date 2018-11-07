package com.utils;

import com.dao.beans.StudyPlan;
import com.service.StudyService;

import java.util.Map;

public class DemoUtils {

    public static void main(String[] args){
        DemoUtils du = new DemoUtils();
        du.test();
    }
    public void test(){
        StudyService ss = new StudyService(){
            public Map<String, Object> studyPlanQuery(StudyPlan studyPlan, int limit, int offset) {
                System.out.println("123");
                return null;
            }
            public void run() {
                System.out.println("hello");
            }
        };
        ss.studyPlanQuery(null,123,123);
    }
}
