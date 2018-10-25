package com.controller;

import com.dao.beans.Account;
import com.dao.beans.Roles;
import com.mq.FirstSender;
import com.utils.ShiroUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("/mq/")
public class MqController {

    @Autowired
    private FirstSender firstSender;

    @RequestMapping("mqPage")
    public String page(Model model) {
        Account user = ShiroUtils.getLoginUser();
        model.addAttribute("userName", user.getUsername());
        return "mq/mq";
    }

    @RequestMapping("send")
    @ResponseBody
    public Map<String, Object> roleQuery(String msg) {
        Map<String, Object> map = new HashMap<>();
        try {
            String uuid = UUID.randomUUID().toString();
            firstSender.send(uuid, msg);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }
}
