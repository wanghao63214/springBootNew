package com.controller;

import com.common.exception.manage.Message;
import com.common.utils.DateUtils;
import com.dao.beans.Account;
import com.dao.beans.StudyPlan;
import com.dao.beans.StudyPlanDetail;
import com.service.StudyService;
import com.utils.ShiroUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/study/")
public class StudyController extends BaseController {

    @Autowired
    private StudyService studyService;

    @RequestMapping("dialPage")
    public String dialPage(Model model) {
        Account user = ShiroUtils.getLoginUser();
        model.addAttribute("userName", user.getUsername());
        return "study/dial";
    }

    @RequestMapping("studyPlan")
    public String studyPlan(Model model) {
        Account user = ShiroUtils.getLoginUser();
        model.addAttribute("userName", user.getUsername());
        return "study/studyPlan";
    }

    @RequestMapping("studyPlanAdd")
    public String studyPlanAdd(Model model) {
        return "study/studyPlanAdd";
    }

    @RequestMapping(value = "studyPlanQuery" + REQUEST_FORMAT, produces = JSON + CHARSET)
    @ResponseBody
    public Map<String, Object> studyPlanQuery(StudyPlan studyPlan, int limit, int offset) {
        Map<String, Object> map = new HashMap<>();
        try {
            map = studyService.studyPlanQuery(studyPlan, limit, offset);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    @RequestMapping(value = "subStudyPlanQuery" + REQUEST_FORMAT, produces = JSON + CHARSET)
    @ResponseBody
    public Map<String, Object> subStudyPlanQuery(StudyPlanDetail studyPlanDetail, int limit, int offset) {
        Map<String, Object> map = new HashMap<>();
        try {
            map = studyService.subStudyPlanQuery(studyPlanDetail, limit, offset);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    @RequestMapping(value = "insert" + REQUEST_FORMAT, produces = JSON + CHARSET)
    @ResponseBody
    public Message insert(StudyPlan studyPlan) {
        Message ms = new Message();
        try {
            studyService.insert(studyPlan);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ms;
    }

    @RequestMapping(value = "dialResultRedisSave", produces = JSON + CHARSET)
    @ResponseBody
    public Map<String, String> dialResultRedisSave(String choosenName) {
        //Message ms = new Message();
        Map<String, String> result = new HashMap();
        try {
            choosenName = DateUtils.getDateTime() + "  " + choosenName;
            studyService.dialResultRedisSave(choosenName);
            result.put("msg", studyService.dialResultRedisQuery("choosenName"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    @RequestMapping(value = "dialResultRedisQuery", produces = JSON + CHARSET)
    @ResponseBody
    public Map<String, String> dialResultRedisQuery(String choosenName) {
        //Message ms = new Message();
        Map<String, String> result = new HashMap();
        try {
           result.put("msg", studyService.dialResultRedisQuery("choosenName"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

}
