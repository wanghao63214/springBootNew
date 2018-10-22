package com.common.utils;
public enum CodeMsg {
	
	SUCCESS(1, "操作成功"),
	FAIL(2, "操作失败");
	
    private int code;
    private String Msg;

    CodeMsg(int code, String Msg) {
        this.code = code;
        this.Msg = Msg;
    }

    public String getMsg() {
        return Msg;
    }

    public int getCode() {
        return code;
    }

    public static CodeMsg getType(int code) {
        for (CodeMsg c : CodeMsg.values()) {
            if (c.getCode() == code) {
                return c;
            }
        }
        return null;
    }

    public static String getMsg(int code) {
        for (CodeMsg c : CodeMsg.values()) {
            if (c.getCode() == code) {
                return c.getMsg();
            }
        }
        return null;
    }
}