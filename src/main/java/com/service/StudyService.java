package com.service;


import com.common.utils.StringUtils;
import com.dao.beans.*;
import com.dao.mapper.StudyPlanDetailMapper;
import com.dao.mapper.StudyPlanDetailMapper_Manual;
import com.dao.mapper.StudyPlanMapper;
import com.dao.mapper.StudyPlanMapper_Manual;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 角色的service层
 *
 * @author zhangge
 */
@Service
public class StudyService {

    @Autowired
    private StudyPlanMapper studyPlanMapper;

    @Autowired
    private StudyPlanMapper_Manual StudyPlanMapper_Manual;

    @Autowired
    private StudyPlanDetailMapper studyPlanDetailMapper;

    @Autowired
    private StudyPlanDetailMapper_Manual studyPlanDetailMapper_Manual;

    /**
     * wh
     *
     * @return 角色查询
     */
    public Map<String, Object> studyPlanQuery(StudyPlan studyPlan, int limit, int offset) {
        Map<String, Object> map = new HashMap<>();
        try {
            StudyPlanExample studyPlanExample = new StudyPlanExample();
            map.put("total", studyPlanMapper.countByExample(studyPlanExample));
            PageHelper.startPage((offset / limit) + 1, limit);//startPage, PageSize
            List<Map<String, Object>> rows = StudyPlanMapper_Manual.selectListMap(studyPlanExample);
            map.put("rows", rows);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("total", 0);
            map.put("rows", new ArrayList<>());
        }
        return map;
    }
    /**
     * wh
     */
    public Map<String, Object> subStudyPlanQuery(StudyPlanDetail studyPlanDetail, int limit, int offset) {
        Map<String, Object> map = new HashMap<>();
        try {
            StudyPlanDetailExample studyPlanDetailExample = new StudyPlanDetailExample();
            StudyPlanDetailExample.Criteria criteria = studyPlanDetailExample.createCriteria();
            if (!(null == studyPlanDetail.getStudyPlanId() ||  studyPlanDetail.getStudyPlanId().equals(""))) {
                criteria.andStudyPlanIdEqualTo(studyPlanDetail.getStudyPlanId());
            }
            map.put("total", studyPlanDetailMapper.countByExample(studyPlanDetailExample));
            PageHelper.startPage((offset / limit) + 1, limit);//startPage, PageSize
            List<Map<String, Object>> rows = studyPlanDetailMapper_Manual.selectListMap(studyPlanDetailExample);
            map.put("rows", rows);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("total", 0);
            map.put("rows", new ArrayList<>());
        }
        return map;
    }

    public void insert(StudyPlan studyPlan){
        try{
            studyPlanMapper.insert(studyPlan);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    /*
    studyPlan
    *//**
     * WH
     * 获得权限树中已有权限
     * @return
     *//*
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

    *//**
     * 给指定角色id 对应赋值权限
     * @param roleId 角色id
     *//*
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

    *//**
     * WH
     * 获得角色下拉框动态数据
     * @return
     *//*
    public List<Map<String, Object>> getRolesSelect() {
        List<Map<String, Object>> list = null;
        try {
            list = rolesMapper_Manual.selectListMap_select();
        } catch (Exception e) {
            list = new ArrayList<Map<String, Object>>();
        }
        return list;
    }*/
}
