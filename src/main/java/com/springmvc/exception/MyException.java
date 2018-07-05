package com.springmvc.exception;

/**
* @Title: CustomException
* @Description: 自定义异常
* @author chy
* @date 2017/10/18 14:25
*/
public class MyException  extends  Exception{

    public String message;

    public MyException(String message){
        super(message);
        this.message = message;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}