package com.service;


import com.common.utils.DateUtils;
import com.dao.beans.MtOrderLog;
import com.dao.beans.MtOrderLogExample;
import com.dao.mapper.MtOrderLogMapper;
import com.dao.mapper.MtOrderLogMapper_Manual;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class LogService {

    @Autowired
    private MtOrderLogMapper_Manual mtOrderLogMapper_Manual;

    @Autowired
    private MtOrderLogMapper mtOrderLogMapper;

    public Map<String, Object> listQuery(MtOrderLog mtOrderLog, int limit, int offset) {
        Map<String, Object> map = new HashMap<>();
        try {
            MtOrderLogExample mtOrderLogExample = new MtOrderLogExample();
            MtOrderLogExample.Criteria criteria = mtOrderLogExample.createCriteria();
            criteria.andCreateTimeBetween(mtOrderLog.getCreateTime(), DateUtils.getDateBeforeOrAfter(mtOrderLog.getCreateTime(), 1));
            if (!(null == mtOrderLog.getType() || "".equals(mtOrderLog.getType()))) {
                criteria.andTypeEqualTo(mtOrderLog.getType());
            }
            map.put("total", mtOrderLogMapper.countByExample(mtOrderLogExample));
            PageHelper.startPage((offset / limit) + 1, limit);//startPage, PageSize
            List<Map<String, Object>> rows = mtOrderLogMapper_Manual.selectListMap(mtOrderLogExample);
            map.put("rows", rows);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("total", 0);
            map.put("rows", new ArrayList<>());
        }
        return map;
    }
}
