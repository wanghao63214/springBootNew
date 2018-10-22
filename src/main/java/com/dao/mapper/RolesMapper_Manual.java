package com.dao.mapper;
import com.dao.beans.RolesExample;
import java.util.List;
import java.util.Map;

public interface RolesMapper_Manual{
    List<Map<String,Object>> selectListMap(RolesExample rolesExample);
    Map<String,Object> selectMap(String faLogin);
    List<Map<String,Object>> selectListMap_select();
}