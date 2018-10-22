package com.common.exception;

public class UserDisableException extends PlatformException{

	public UserDisableException(String message) {
		super(message);
	}

	public UserDisableException(String message, Throwable cause) {
        super(message, cause);
    }

    public UserDisableException(Throwable cause) {
        super(cause);
    }
	
	private static final long serialVersionUID = 1L;

}
