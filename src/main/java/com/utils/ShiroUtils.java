package com.utils;

import com.dao.beans.Account;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;

public class ShiroUtils {

	/**
	 *  获取当前登录对象信息
	 * @return
	 */
	public static Account getLoginUser(){
		return (Account) SecurityUtils.getSubject().getSession().getAttribute("currentUser");
	}
	static Account user = ShiroUtils.getLoginUser();
	
	public static  String getUserId(){
		String userId = Long.toString(user.getId());
		return userId;
	}

    /**
     * shiro 的md5 加密
     * @param password
     * @param saltStr
     * @return
     */
    public static String md5(String password,String saltStr){
		String hashAlgorithmName = "MD5";
		Object salt = ByteSource.Util.bytes(saltStr);
		int hashIterations = 2;
		SimpleHash result = new SimpleHash(hashAlgorithmName, password, salt, hashIterations);
		return result.toString();
    }
    
    public static void main(String[] args) {
    	System.out.println(md5("123456", "admin"));
    	System.out.println(new SimpleHash("MD5", "123456", null, 2).toString());
    	
	}
}

