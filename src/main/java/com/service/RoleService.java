package com.service;


import com.common.utils.StringUtils;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.dao.beans.Roles;
import com.dao.beans.RolesExample;
import com.dao.mapper.AuthorityMapper;
import com.dao.mapper.RolesMapper;
import com.dao.mapper.RolesMapper_Manual;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 角色的service层
 *
 * @author zhangge
 */
@Service
public class RoleService {

    @Autowired
    private RolesMapper rolesMapper;

    @Autowired
    private RolesMapper_Manual rolesMapper_Manual;

    @Autowired
    private AuthorityMapper authorityMapper;

    /**
     * wh
     *
     * @return 角色查询
     */
    public Map<String, Object> roleQuery(Roles roles, int limit, int offset) {
        Map<String, Object> map = new HashMap<>();
        try {
            RolesExample rolesExample = new RolesExample();
            map.put("total", rolesMapper.countByExample(rolesExample));
            PageHelper.startPage((offset / limit) + 1, limit);//startPage, PageSize
            List<Map<String, Object>> rows = rolesMapper_Manual.selectListMap(rolesExample);
            map.put("rows", rows);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("total", 0);
            map.put("rows", new ArrayList<>());
        }
        return map;
    }

    public void insert(Roles roles){
        try{
            rolesMapper.insert(roles);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    /**
     * WH
     * 获得权限树中已有权限
     * @return
     */
    public List<Map<String, Object>> selectCheckedTreeByRoleId(Integer roleId) {
        List<Map<String, Object>> list = null;
        try {
            list = authorityMapper.selectCheckedTreeByRoleId(roleId);
        } catch (Exception e) {
            e.printStackTrace();
            list = new ArrayList<Map<String, Object>>();
        }
        return list;
    }

    /**
     * 给指定角色id 对应赋值权限
     * @param roleId 角色id
     */
    public void updateRolePermissions(long roleId, String permissionsIds){
        try {
            if (StringUtils.isEmptyValue(permissionsIds)) {
                return;
            } else {
                //删除这个角色以前对应的权限
                authorityMapper.deleteRolePermissions(roleId);
                //给这个角色赋值新的权限
                String[] permissionsIds_array = permissionsIds.split(",");
                Map<String, Object> map = new HashMap<>();
                map.put("roleId", roleId);
                map.put("permissionsIds", permissionsIds_array);
                authorityMapper.batchInsert(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    /**
     * WH
     * 获得角色下拉框动态数据
     * @return
     */
    public List<Map<String, Object>> getRolesSelect() {
        List<Map<String, Object>> list = null;
        try {
            list = rolesMapper_Manual.selectListMap_select();
        } catch (Exception e) {
            list = new ArrayList<Map<String, Object>>();
        }
        return list;
    }
}
