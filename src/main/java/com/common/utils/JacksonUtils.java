package com.common.utils;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import com.common.exception.PlatformException;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * @Description: Jackson与Java转换工具类
 * @author zhenggang@mocar.cn
 * @date 2015年7月13日
 * @time 下午5:04:43
 */
public final class JacksonUtils {

	private static ObjectMapper objectMapper;

	private static final String DEFAULT_DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";

	static {
		objectMapper = new ObjectMapper();
		objectMapper.setDateFormat(new SimpleDateFormat(DEFAULT_DATE_FORMAT));
	}

	/**
	 * json字符与对像转换
	 * @param jsonStr
	 * @param valueType
	 * @return
	 */
	public static <T> T fromJson(String jsonStr, Class<T> valueType) {
		try {
			return objectMapper.readValue(jsonStr, valueType);
		} catch (Exception e) {
			throw new PlatformException(e);
		}
	}
	/**
	 * json字符与对像转换yyyy-MM-dd
	 * @param jsonStr
	 * @param valueType
	 * @return
	 */
	public static <T> T fromJson2(String jsonStr, Class<T> valueType) {
		try {
			objectMapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd"));
			return objectMapper.readValue(jsonStr, valueType);
		} catch (Exception e) {
			throw new PlatformException(e);
		}
	}

	/**
	 * json数组转List
	 * @param jsonStr
	 * @param valueTypeRef
	 * @return
	 */
	public static <T> T readValue(String jsonStr, TypeReference<T> valueTypeRef) {
		
		try {
			return objectMapper.readValue(jsonStr, valueTypeRef);
		} catch (Exception e) {
			throw new PlatformException(e);
		}
	}

	/**
	 * 把JavaBean转换为json字符串
	 * @param object
	 * @return
	 */
	public static String toJSon(Object object) {
		try {
			return objectMapper.writeValueAsString(object);
		} catch (Exception e) {
			throw new PlatformException(e);
		}
	}

	/**
	 * 根据参数名称，转换JSON为map
	 * @param paramNames
	 * @param json
	 * @return Map<String, String>
	 * @throws IOException
     */
	public static Map<String, String> convert(String[] paramNames, String json) {
		if (paramNames == null || paramNames.length == 0) {
			return null;
		}
		Map<String, String> result = new HashMap<>(paramNames.length);
		Map<String, String> map = null;
		try {
			map = objectMapper.readValue(json, new TypeReference<Map<String, String>>() {});
		} catch (Exception e) {
			throw new PlatformException(e);
		}
		for (String name : paramNames) {
			result.put(name, map.get(name));
		}

		if (result.isEmpty()) {
			return null;
		}
		return result;
	}

	/**
	 * 验证请求参数是否完整
	 *
	 * @param map         存放请求数据的map
	 * @param canNullKeys 可以为空的参数名。
	 * @return true:完整；false:不完整
	 */
	public static boolean isIntact(Map<String, String> map, String[] canNullKeys) {
		Set<String> keys = map.keySet();
		for (String name : canNullKeys) {
			keys.remove(name);
		}
		if (keys.isEmpty()) {
			return true;
		}
		Iterator<String> it = keys.iterator();
		while (it.hasNext()) {
			String key = it.next();
			String value = map.get(key);
			if (value == null || "".equals(value.trim())) {
				return false;
			}
		}
		return true;
	}
	
	
	/**
	 * 把JSON字符串转化为Map结构。
	 *
	 * @param jsonStr JSON字符串
	 * @return Map结构
	 * @throws IOException 
	 * @throws JsonMappingException 
	 * @throws JsonParseException 
	 */
	public static Map<?, ?> parseJsonToMap(String jsonStr) {
		try {
			return objectMapper.readValue(jsonStr, Map.class);
		} catch (Exception e) {
			throw new PlatformException(e);
		}
	}
	
	/**
	 * 方法说明：将有值的参数转换成JSON格式的字符串
	 */ 
	public static String toIntactJson(Object obj){
		String allJsonParams = toJSon(obj);
		Map<String, Object> allMap = (Map<String, Object>) parseJsonToMap(allJsonParams);
		
		if (allMap != null) {} {
			Set<String> keys = allMap.keySet();
			Map<String, Object> intactMap = new HashMap<String, Object>();
			for (String theKey : keys) {
				if(allMap.get(theKey) != null && !"errorCodeList".equals(theKey)
						&& !"secureKey".equals(theKey)){
					intactMap.put(theKey, allMap.get(theKey));
				}
			}
			
			return toJSon(intactMap);
		}
	}
	
}
