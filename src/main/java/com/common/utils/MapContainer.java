package com.common.utils;

import java.util.HashMap;

/**
 * @Description: Map容器
 * @author wh
 */
public class MapContainer extends HashMap<String, Object>{

	private static final long serialVersionUID = 1L;

	//private int code;//错误码
	//private String msg;//错误信息
	
	public MapContainer() {
		this.put("code", CodeMsg.SUCCESS.getCode());
		this.put("msg", CodeMsg.SUCCESS.getMsg());
		//this.put("rows", new ArrayList<Object>());
		//this.put("total", 0);
	}
	
	public MapContainer(CodeMsg codeMsg) {
		super();
		this.put("code", codeMsg.getCode());
		this.put("msg", codeMsg.getMsg());
		//this.put("rows", new ArrayList<Object>());
		//this.put("total", 0);
	}
	
	public MapContainer(CodeMsg codeMsg, String msg) {
		super();
		this.put("code", codeMsg.getCode());
		this.put("msg", msg);
		//this.put("rows", new ArrayList<Object>());
		//this.put("total", 0);
	}
	
}
