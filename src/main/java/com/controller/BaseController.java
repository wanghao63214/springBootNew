package com.controller;

import com.common.utils.DateUtils;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.ModelAttribute;

/**
 * Controller控制器父类
 * @ClassName: BaseController
 * @Description: Controller控制器父类
 * @author zhangYuanHui
 */
public class BaseController {
	
	protected final static String DATE_FOMAT = "yyyy-MM-dd";
	/**
	 * 间隔天数
	 */
	protected final static int INTERVAL_DAY = 40;
	
	/**
	 * http请求拦截后缀，用法:@RequestMapping(value = "test" + REQUEST_FORMAT)
	 */
	protected final static String REQUEST_FORMAT = ".do";
	
	/**
	 * 返回数据编码格式，用法：@RequestMapping(produces = 返回数据格式 + CHARSET)
	 */
	protected final static String CHARSET = ";charset=UTF-8";
	
	/**
	 * 返回数据JSON格式，用法：@RequestMapping(produces = JSON + CHARSET) 
	 */
	protected final static String JSON = MediaType.APPLICATION_JSON_VALUE;
	
	/**
	 * 返回页面，用法：@RequestMapping(produces = TEXT_HTML + CHARSET) 
	 */
	protected final static String TEXT_HTML = MediaType.APPLICATION_XML_VALUE;
	
	/*
	 * 以下完整使用实例,返回utf-8编码的json数据且只支持get请求后缀以.do结尾
	 * 
	 * @RequestMapping(value = "test" + REQUEST_FORMAT, method = RequestMethod.GET,produces = APPLICATION_JSON_VALUE + CHARSET)
	 * @ResponseBody
	 * public String test(@RequestParam("test") String test){
	 * 		return JsonUtils.objectToJsonBean(bean);
	 * }
	 * 
	 */
	
	/**
	 * request
	 */
	protected  HttpServletRequest request;
	
	/**
	 * response
	 */
	protected HttpServletResponse response;
	
	/**
	 * session
	 */
	protected HttpSession session;
	
	/*
	 * ModelAttribute的作用
	 * 1、放置在方法的形参上：表示引用Model中的数据。
	 * 2、放置在方法上面：表示请求该类的每个Action前都会首先执行它，也可以将一些准备数据的操作放置在该方法里面。
	 */
	@ModelAttribute  
    public void setReqAndRes(HttpServletRequest request, HttpServletResponse response){  
        this.request = request;  
        this.response = response;  
        this.session = request.getSession();  
    }
	
	
	
	/**
	 * 计算日期控制在指定天数间隔之内
	 * @param startTime 开始时间
	 * @param endTime 结束日期
	 * @return Map<String, Date>
	 */
	public Map<String, Date> dateParams(String startTime, String endTime, int days){
		Map<String, Date> map = new HashMap<>();
		// 当前时间
		Date now = new Date();
		Date startDate, endDate;
		if (StringUtils.isNotEmpty(startTime)) {
			startDate = DateUtils.format("yyyy-MM-dd HH:mm:ss", startTime + " 00:00:00");
		} else {
			startDate = DateUtils.getTodayStart(now);
		}

		if (StringUtils.isNotEmpty(endTime)) {
			endDate = DateUtils.format("yyyy-MM-dd HH:mm:ss", endTime + " 23:59:59");
		} else {
			endDate = DateUtils.getTodayEnd(now);
		}
		// 最多查询多少天数据,如果大于多少天开始时间为准后推多少天
		if (DateUtils.getDateDiff(startDate, endDate) > days) {
			endDate = DateUtils.getTodayEnd(DateUtils.getIntervalDay(startDate, days));
		}
		map.put("startTime", startDate);
		map.put("endTime", endDate);
		return map;
	}
	
	
	/**
	 * 计算日期控制在指定天数间隔之内
	 * @param startTime 开始时间
	 * @param endTime 结束日期
	 * @return Map<String, Date>
	 */
	public Map<String, Date> dateParams(String startTime, String endTime){
		return dateParams(startTime, endTime, INTERVAL_DAY);
	}
	enum OperationType{
		ADD(1, "添加"),
		EDIT(2, "修改"),
		DELETE(3, "删除");
		
		private int code;
		private String codeName;
		
		private OperationType(int code, String codeName) {
			this.code = code;
			this.codeName = codeName;
		}
		public int getCode() {
			return code;
		}
		public void setCode(int code) {
			this.code = code;
		}
		public String getCodeName() {
			return codeName;
		}
		public void setCodeName(String codeName) {
			this.codeName = codeName;
		}
	}
	
	/**
	 * 
	* @Title: checkoutPrice
	* @Description: TODO(校验前端入参金额格式是否正确)
	* @param @return    设定文件
	* @return boolean    返回类型
	* @throws
	 */
	public boolean checkoutPrice(String price) {
		if(price==null||"".equals(price)){
			return false;
		}
		String[] prices = price.split("\\.");
		if(prices.length!=2){//有且只有一个小数点
			return false;
		}
		if(prices[1].length()!=3){//小数点后 三位
			return false;
		}
		return true;
	}
	/**
	 * 
	* @Title: fmtPriceToPage
	* @Description: TODO(金额转换    厘   转    元，保留三位)
	* @param @param obj
	* @param @return    设定文件
	* @return String    返回类型
	* @throws
	 */
	public String fmtPriceToPage(Object obj) {
		if(obj==null||"".equals(obj.toString())||"0".equals(obj.toString())){
			return "0.000";
		}
		BigDecimal price = new BigDecimal(obj.toString());
		BigDecimal s = new BigDecimal(1000);
		BigDecimal res = price.divide(s);
		
		DecimalFormat df = new DecimalFormat("###.000");  
        String decimalStr = df.format(res);
        if(decimalStr.indexOf(".")==0){
        	decimalStr="0"+decimalStr;
        }
		return decimalStr;
	}
}
