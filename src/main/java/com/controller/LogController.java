package com.controller;

import com.dao.beans.MtOrderLog;
import com.service.LogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/logManage/")
public class LogController extends BaseController{

    @Autowired
    private LogService logService;

    @RequestMapping(value = "listQuery" + REQUEST_FORMAT, produces = JSON + CHARSET)
    public Map<String, Object> listQuery(MtOrderLog mtOrderLog, int limit, int offset) {
        Map<String, Object> map = new HashMap<>();
        try {
            map = logService.listQuery(mtOrderLog, limit, offset);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }
}
