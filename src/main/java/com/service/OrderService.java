package com.service;

import com.common.utils.DateUtils;
import com.dao.beans.Account;
import com.dao.beans.AppCodeExample;
import com.dao.beans.MtCompletedOrder;
import com.dao.beans.MtCompletedOrderExample;
import com.dao.mapper.AppCodeMapper_Manual;
import com.dao.mapper.MtCompletedOrderMapper;
import com.dao.mapper.MtCompletedOrderMapper_Manual;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.*;

/**
 * 角色的service层
 * @author zhangge
 */
@Service
public class OrderService {

    @Autowired
    private MtCompletedOrderMapper mtCompletedOrderMapper;

    @Autowired
    private MtCompletedOrderMapper_Manual mtCompletedOrderMapper_Manual;

    @Autowired
    private AppCodeMapper_Manual appCodeMapper_Manual;

    /**
     * wh
     * @param mtCompletedOrder
     * @param limit
     * @param offset
     * @return 完成订单查询
     */
    public Map<String, Object> completedOrderQuery(MtCompletedOrder mtCompletedOrder, int limit, int offset) {
        Map<String, Object> map = new HashMap<>();
        try {
            MtCompletedOrderExample mtCompletedOrderExample = new MtCompletedOrderExample();
            MtCompletedOrderExample.Criteria criteria = mtCompletedOrderExample.createCriteria();
            if (!(null == mtCompletedOrder.getAppPoiCode() || mtCompletedOrder.getAppPoiCode().equals(""))) {
                criteria.andAppPoiCodeEqualTo(mtCompletedOrder.getAppPoiCode());
            }
            if (!(null == mtCompletedOrder.getJjyDiffType() || mtCompletedOrder.getJjyDiffType().equals(""))) {
                criteria.andJjyDiffTypeEqualTo(mtCompletedOrder.getJjyDiffType());
            }
            if (!(null == mtCompletedOrder.getJjyOrderType() || mtCompletedOrder.getJjyOrderType().equals(""))) {
                criteria.andJjyOrderTypeEqualTo(mtCompletedOrder.getJjyOrderType());
            }
            if (!(null == mtCompletedOrder.getJjyPushType() || mtCompletedOrder.getJjyPushType().equals(""))) {
                criteria.andJjyPushTypeEqualTo(mtCompletedOrder.getJjyPushType());
            }
            criteria.andOrderCompletedTimeBetween(mtCompletedOrder.getOrderCompletedTime(), DateUtils.getDateBeforeOrAfter(mtCompletedOrder.getOrderCompletedTime(), 1));
            map.put("total", mtCompletedOrderMapper.countByExample(mtCompletedOrderExample));
            PageHelper.startPage((offset / limit) + 1, limit);//startPage, PageSize
            List<Map<String, Object>> rows = mtCompletedOrderMapper_Manual.selectListMap(mtCompletedOrderExample);
            map.put("rows", rows);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("total", 0);
            map.put("rows", new ArrayList<>());
        }
        return map;
    }

    /**
     * 订单页面导出按钮
     * @return
     */
    public List<Map<String, Object>> completedOrderExport() {
        MtCompletedOrderExample mtCompletedOrderExample = new MtCompletedOrderExample();
        List<Map<String, Object>> rows = mtCompletedOrderMapper_Manual.selectListMap(mtCompletedOrderExample);
        return rows;
    }
    /**
     * WH
     * 获得门店下拉框动态数据
     * @return
     */
    public List<Map<String, Object>> getApp(Account account) {
        List<Map<String, Object>> list = null;
        try {
            AppCodeExample appCodeExample = new AppCodeExample();
            AppCodeExample.Criteria criteria = appCodeExample.createCriteria();
            if (null != account.getAppPoiCode() && !"".equals(account.getAppPoiCode())) {
                criteria.andAppPoiCodeEqualTo(account.getAppPoiCode());
            }
            list = appCodeMapper_Manual.selectListMapForSelect(appCodeExample);
        } catch (Exception e) {
            list = new ArrayList<>();
        }
        return list;
    }


    /**
     * WH 电商部 电话查询
     * @return 完成订单查询
     */
    public Map<String, Object> selectFoodDetailsListMap(String dateFrom, String dateEnd, String foodNameOne, String foodNameTwo, String foodNameThree, int limit, int offset) {
        Map<String, Object> map = new HashMap<>();
        Map<String, String> paraMap = new HashMap<>();
        try {
            paraMap.put("dateFrom", dateFrom);
            paraMap.put("dateEnd", dateEnd);
            paraMap.put("foodNameOne", foodNameOne);
            paraMap.put("foodNameTwo", foodNameTwo);
            paraMap.put("foodNameThree", foodNameThree);
            map.put("total", mtCompletedOrderMapper_Manual.selectFoodDetailsListMap(paraMap).size());
            PageHelper.startPage((offset / limit) + 1, limit);//startPage, PageSize
            List<Map<String, Object>> rows = mtCompletedOrderMapper_Manual.selectFoodDetailsListMap(paraMap);
            map.put("rows", rows);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("total", 0);
            map.put("rows", new ArrayList<>());
        }
        return map;
    }
}
