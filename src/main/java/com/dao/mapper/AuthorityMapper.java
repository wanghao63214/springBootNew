package com.dao.mapper;

import java.util.List;
import java.util.Map;
import java.util.Set;

public interface AuthorityMapper {

    List<Map<String, Object>> selectByRoleId(long roleId);

    List<String> selectButtonsByRoleId(long roleId);

    List<Map<String, Object>> selectCheckedTreeByRoleId(int roleId);

    int deleteRolePermissions(long roleId);

    void batchInsert(Map map);
}
