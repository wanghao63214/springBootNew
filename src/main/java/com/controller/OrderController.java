package com.controller;

import com.dao.beans.Account;
import com.dao.beans.MtCompletedOrder;
import com.service.OrderService;
import com.utils.ShiroUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/orderManage/")
public class OrderController extends BaseController {

    /**
     * 日志打印
     */
    private static final Logger LOG = LoggerFactory.getLogger(OrderController.class);

    @Autowired
    private OrderService orderService;

    //@RequiresPermissions("role:query")
    @RequestMapping(value = "completedOrder/query" + REQUEST_FORMAT, produces = JSON + CHARSET)
    @ResponseBody
    public Map<String, Object> completedOrderQuery(MtCompletedOrder mtCompletedOrder, int limit, int offset) {
        Map<String, Object> map = new HashMap<>();
        Account account = ShiroUtils.getLoginUser();
        try {
            if (null != account.getAppPoiCode() && !"".equals(account.getAppPoiCode())) {
                mtCompletedOrder.setAppPoiCode(account.getAppPoiCode());
            }
            map = orderService.completedOrderQuery(mtCompletedOrder, limit, offset);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    /**
     * WH
     * 获得门店下拉框动态数据
     * @return
     */
    @RequestMapping(value = "completedOrder/getApp" + REQUEST_FORMAT, produces = JSON + CHARSET)
    @ResponseBody
    public List<Map<String, Object>> getApp() {
        List<Map<String, Object>> list = new ArrayList<>();
        try {
            Account account = ShiroUtils.getLoginUser();
            list = orderService.getApp(account);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @RequestMapping(value = "order/telephoneQuery" + REQUEST_FORMAT, produces = JSON + CHARSET)
    @ResponseBody
    public Map<String, Object> selectFoodDetailsListMap(String dateFrom, String dateEnd, String foodNameOne, String foodNameTwo, String foodNameThree, int limit, int offset) {
        Map<String, Object> map = new HashMap<>();
        try {
            map = orderService.selectFoodDetailsListMap(dateFrom, dateEnd, foodNameOne, foodNameTwo, foodNameThree, limit, offset);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }
    @ResponseBody
    @RequestMapping(value = "completedOrder/export" + REQUEST_FORMAT, produces = JSON + CHARSET)
    public Object completedOrderExport(String spId_export, String netType_export, String goodsType_export, String status_export ){
        // 追加排序
        try{
            String[] headr = { "订单号", "订单类型", "门店号", "账单", "订单状态", "推送DRP状态", "订单完成时间", "创建时间"};
            List<Object[]> data = new ArrayList<>();
            List<Object> temp;
            List<Map<String, Object>> result = orderService.completedOrderExport();
            for(Map<String, Object> map:result){
                temp = new ArrayList<>();
                /*temp.add(map.get("id"));*/
                temp.add(map.get("wm_order_id_view"));
                temp.add(map.get("jjy_diff_type"));
                temp.add(map.get("app_poi_code"));
                temp.add(map.get("jjy_bill_id"));
                temp.add(map.get("jjy_order_type"));
                temp.add(map.get("jjy_push_type"));
                temp.add(map.get("order_completed_time"));
                temp.add(map.get("create_time"));
                data.add(temp.toArray());
            }
            //ExcleExport.exportExcle(headr, data, "完成订单", "订单", request, response);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }
}


