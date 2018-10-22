package com.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/work/")
public class WorkController extends BaseController {
    @RequestMapping("workQueryPage")
    public String index() {
        return "webSocket";
    }
}
