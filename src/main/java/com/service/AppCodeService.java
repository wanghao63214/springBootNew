package com.service;
import com.dao.beans.AppCode;
import com.dao.beans.AppCodeExample;
import com.dao.mapper.AppCodeMapper;
import com.dao.mapper.AppCodeMapper_Manual;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
@Service
public class AppCodeService {

    @Autowired
    private AppCodeMapper appCodeMapper;
    @Autowired
    private AppCodeMapper_Manual appCodeMapper_Manual;
    /**
     * wh
     * 门店查询
     */
    public Map<String, Object> selectListMap(AppCode appCode, int limit, int offset) {
        Map<String, Object> map = new HashMap<>();
        try {
            AppCodeExample mtCompletedOrderExample = new AppCodeExample();
            AppCodeExample.Criteria criteria = mtCompletedOrderExample.createCriteria();
            map.put("total", appCodeMapper.countByExample(mtCompletedOrderExample));
            PageHelper.startPage((offset / limit) + 1, limit);//startPage, PageSize
            List<Map<String, Object>> rows = appCodeMapper_Manual.selectListMap(mtCompletedOrderExample);
            map.put("rows", rows);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("total", 0);
            map.put("rows", new ArrayList<>());
        }
        return map;
    }
}
