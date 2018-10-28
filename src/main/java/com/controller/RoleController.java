package com.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.common.exception.manage.ErrorCode;
import com.common.exception.manage.Message;
import com.dao.beans.Roles;
import com.service.RoleService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 角色操作的控制器
 * 
 * @author zhangge
 */
@Controller
@RequestMapping("/roles/")
public class RoleController extends BaseController {

	/**
	 * 日志打印
	 */
	private static final Logger LOG = LoggerFactory.getLogger(RoleController.class);

	@Autowired
	private RoleService roleService;

	@RequestMapping("roleQueryPage")
	public String userQueryPage() {
		return "sysManage/roleManage/roleQuery";
	}
	@RequestMapping("roleEmpowerPage")
	public String roleEmpowerPage() {
		return "sysManage/roleManage/roleEmpower";
	}

	@RequestMapping(value = "roleQuery" + REQUEST_FORMAT, produces = JSON + CHARSET)
	@ResponseBody
	public Map<String, Object> roleQuery(Roles roles, int limit, int offset) {
		Map<String, Object> map = new HashMap<>();
		try {
			map = roleService.roleQuery(roles, limit, offset);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	@RequestMapping(value = "insert" + REQUEST_FORMAT, produces = JSON + CHARSET)
	@ResponseBody
	public Message insert(Roles roles) {
		Message ms = new Message();
		try {
			roleService.insert(roles);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ms;
	}

	/**
	 * WH
	 * 查询当前角色的权限给权限树赋值
	 * @param roleId
	 * @return
	 */
	//@RequiresPermissions("role:update")
	@RequestMapping(value = "selectCheckedTreeByRoleId" + REQUEST_FORMAT, produces = JSON + CHARSET)
	@ResponseBody
	public List<Map<String, Object>> selectCheckedTreeByRoleId(Integer roleId) {
		List<Map<String, Object>> list = new ArrayList<>();
		try {
			list = roleService.selectCheckedTreeByRoleId(roleId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 *  更新当前角色的权限
	 * @return
	 */
	@RequestMapping(value = "updateRolePermissions" + REQUEST_FORMAT, produces = JSON + CHARSET)
	@ResponseBody
	public Message updateRolePermissions(long roleId, String permissionsIds) {
		Message msg = new Message();
		try {
			roleService.updateRolePermissions(roleId, permissionsIds);
			msg.setCode(ErrorCode.OP_SUCCESS);
		} catch (Exception e) {
			LOG.error("角色权限赋值异常：" + e);
			//LogPrinter.logDebug(ShiroUtils.getUserId(), ShiroUtils.getUserName(), LogPrinter.errInfo, new Object[]{"角色权限赋值异常：" + e});
			msg.setCode(ErrorCode.OP_FAILURE);
		}
		return msg;
	}
	/**
	 *WH
	 * 获得角色下拉框动态数据
	 * @return
	 */
	@RequestMapping(value = "getRolesSelect" + REQUEST_FORMAT, produces = JSON + CHARSET)
	@ResponseBody
	public List<Map<String, Object>> getRolesSelect() {
		List<Map<String, Object>> list = new ArrayList<>();
		try {
			list = roleService.getRolesSelect();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}


