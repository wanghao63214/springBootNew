package com.common.exception;

import com.common.exception.manage.Message;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartException;

@ControllerAdvice
public class MyControllerAdvice {
    /**
     * 拦截捕捉文件过大异常
     * @param ex
     * @return
     */
    @ResponseBody
    @ExceptionHandler(value = Exception.class)
    public Message fileErrorHandler(MultipartException ex) {
        Message ms = new Message();
        ms.setCode(2);
        ms.setMsg("文件大小超过6Mb");
        return ms;
    }

}

