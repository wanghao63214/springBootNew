package com.controller;

import com.dao.beans.AppCode;
import com.service.AppCodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.HashMap;
import java.util.Map;

@RequestMapping("/appCode/")
@Controller
public class AppCodeController extends BaseController{

    @Autowired
    private AppCodeService appCodeService;

    @RequestMapping(value = "query" + REQUEST_FORMAT, produces = JSON + CHARSET)
    @ResponseBody
    public Map<String, Object> query(AppCode AppCode, int limit, int offset) {
        Map<String, Object> map = new HashMap<>();
        try {
            map = appCodeService.selectListMap(AppCode, limit, offset);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }
}
