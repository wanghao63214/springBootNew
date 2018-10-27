package com.controller;

import com.dao.beans.Account;
import com.utils.ShiroUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
@RequestMapping("/study/")
public class StudyController extends BaseController{

    @RequestMapping("dialPage")
    public String index(Model model) {
        Account user = ShiroUtils.getLoginUser();
        model.addAttribute("userName", user.getUsername());
        return "study/dial";
    }
}
