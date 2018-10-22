package com.controller;

import com.common.exception.manage.Message;
import com.dao.beans.Account;
import com.service.UserService;
import com.utils.ShiroUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.HashMap;
import java.util.Map;

/**
 * 用户管理的控制器
 * @author zhangge
 *
 */
@Controller
@RequestMapping("/user/")
public class UserController  extends BaseController{

	/**
	 * 日志打印
	 */
	private static final Logger LOG = LoggerFactory.getLogger(UserController.class);

	@Autowired
	private UserService userService;


	@RequestMapping("userQueryPage")
	public String userQueryPage() {
		return "sysManage/userManage/userQuery";
	}
	@RequestMapping("userAddPage")
	public String userAddPage() {
		return "sysManage/userManage/userAdd";
	}

	@RequestMapping(value = "userQuery" + REQUEST_FORMAT, produces = JSON + CHARSET)
	@ResponseBody
	public Map<String, Object> userQuery(Account user, int limit, int offset) {
		Map<String, Object> map = new HashMap<>();
		try {
			map = userService.userQuery(user, limit, offset);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	@RequestMapping(value = "insert" + REQUEST_FORMAT, produces = JSON + CHARSET)
	@ResponseBody
	public Message insert(Account account) {
		Message ms = new Message();
		try {
			account.setPwd(ShiroUtils.md5(account.getPwd(), account.getSalt()));
			userService.insert(account);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ms;
	}

	@RequestMapping(value = "updatePassword" + REQUEST_FORMAT, produces = JSON + CHARSET)
	@ResponseBody
	public Message updatePassword(String password, String oldPassword) {
		Message ms = new Message();
		try {
			Account user = ShiroUtils.getLoginUser();
			if (ShiroUtils.md5(oldPassword, user.getSalt()).equals(user.getPwd())) {
				user.setPwd(ShiroUtils.md5(password, user.getSalt()));
				userService.update(user);
			} else {
				throw new Exception();
			}
		} catch (Exception e) {
			ms = new Message(2);
			e.printStackTrace();
		}
		return ms;
	}

	@RequestMapping(value = "initPassword" + REQUEST_FORMAT, produces = JSON + CHARSET)
	@ResponseBody
	public Message initPassword(Account account) {
		Message ms = new Message();
		try {
		    account = userService.selectByPrimaryKey(account);
			account.setPwd(ShiroUtils.md5("123456", account.getSalt()));
			userService.update(account);
		} catch (Exception e) {
			ms = new Message(2);
			e.printStackTrace();
		}
		return ms;
	}

}
