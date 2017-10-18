package com.springmvc.model;

import lombok.*;

/**
* @Name: RequestResult
* @Description:  请求结果
* @param
* @return
* @date 2017/10/18 14:02
*/
@Data
@ToString
@NoArgsConstructor
public class RequestResult {

    /**
     *  true: 正常操作
     *  false: 条件不符合 或者 异常
     */
    @Getter
    @Setter
    boolean success;

    /**
     *  1:  成功
     *  0:  条件不符合
     * -1： 异常
     */
    @Getter
    @Setter
    int code;

    /**
     * 信息提示
     */
    @Getter
    @Setter
    String tip;

    /**
     * 返回值 默认值 null
     */
    @Getter
    @Setter
    Object data;

    public void setSucceed(String tip,Object data){
        this.success=true;
        this.code=1;
        this.tip=tip;
        this.data=data;
    }

    /**
     * 失败回复
     * @param tip
     */
    public void setFail(String tip){
        this.success=false;
        this.code=0;
        this.tip=tip;
        this.data=null;
    }

    /**
     * 异常回复
     * @param tip
     */
    public void setException(String tip){
        this.success=false;
        this.code=-1;
        this.tip=tip;
        this.data=null;
    }

}
