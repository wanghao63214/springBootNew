package com.controller;

import com.dao.beans.Account;
import com.utils.ShiroUtils;
import com.common.exception.UserDisableException;
import com.service.LoginService;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.exception.ExceptionUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.annotation.RequiresGuest;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * 登录的控制器
 *
 * @author zhangge
 */
@Controller
public class LoginController extends BaseController {

    /**
     * 日志打印
     */
    private static final Logger LOG = LoggerFactory.getLogger(LoginController.class);

    @Autowired
    private LoginService loginService;

    @RequestMapping("login")
    public String index() {
        return "login";
    }

    /**
     * 登录
     *
     * @param userName 用户名
     * @param password 密码
     * @return
     */
    @RequestMapping(value = "index")
    public ModelAndView index(String userName, String password) {
        ModelAndView mv = new ModelAndView();
        Subject subject = SecurityUtils.getSubject();
        if (null != subject.getSession().getAttribute("currentUser")) {
            return mv;
        }
        UsernamePasswordToken token = new UsernamePasswordToken(userName, password);
        try {
            //使用shiro 进行登录认证
            subject.login(token);
            //页面跳转
            mv.setViewName("index");
        } catch (UnknownAccountException uae) {
            request.setAttribute("msg", "用户名不存在");
            subject.getSession().removeAttribute("AAA");
        } catch (IncorrectCredentialsException e) {
            System.out.println(e);
            request.setAttribute("msg", "密码错误");
            subject.getSession().removeAttribute("AAA");
//			Cache<Object, Object> cache = springCacheManagerWrapper.getCache("passwordRetryCache");
//			AtomicInteger retryCoun = (AtomicInteger) cache.get(userName);
//
//			if(retryCoun.incrementAndGet() != 5){
//				model.addAttribute("msg", "密码错误,你还有 "+( 5 - retryCoun.get() + 1) +  " 次机会" );
//			}else{
//				model.addAttribute("msg", "连续5次密码错误，请等待10分钟再登录");
//			}
        } catch (UserDisableException e) {
            request.setAttribute("msg", "账户被禁用");
            subject.getSession().removeAttribute("AAA");
        } catch (AuthenticationException e) {
            // 账户认证失败
            request.setAttribute("msg", "该账号被锁定，请联系管理员");
            subject.getSession().removeAttribute("AAA");
        } catch (Exception e) {
            LOG.error("修改登录用户时间异常{}" + ExceptionUtils.getStackTrace(e));
        }
        if (mv.getViewName() == null) {
            mv.setViewName("login");
        }
        return mv;
    }

    /**
     * 登出
     *
     * @return
     */
    @RequestMapping(value = "logout" + REQUEST_FORMAT)
    public ModelAndView logOut() {
        Subject subject = SecurityUtils.getSubject();
        subject.logout();
        ModelAndView mv = new ModelAndView();
        mv.setViewName("redirect:/view/login.jsp");
        return mv;
    }

    /**
     * 获取登录用户的菜单
     *
     * @return json
     * @Description: 获取登录用户的菜单
     */
    @RequestMapping(value = "showMeuns", produces = JSON + CHARSET)
    @ResponseBody
    public List<Map<String, Object>> showMeun() {
        List<Map<String, Object>> meun = null;
        //获取当前登录用户
        Account user = ShiroUtils.getLoginUser();
        try {
            meun = loginService.showMeun(user.getRoleid());
        } catch (Exception e) {
            LOG.error("菜单显示异常：" + e);
            return new ArrayList<Map<String, Object>>();
        }
        return meun;
    }
}
