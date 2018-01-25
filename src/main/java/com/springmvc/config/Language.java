package com.springmvc.config;

import org.springframework.stereotype.Component;

/**
* @Title: Language
* @Description: 语言提示信息
* @author chy
* @date 2018/1/12 11:27
*/
@Component
public class Language {

    public final String EXCEPTER = "异常";

    public final String UN_ANTHORIZED = "未授权";
    public final String UN_PASSWORD = "无密码";
    public final String ERROR_OLD_PASSWORD = "旧密码不正确";
    public final String ERROR_PASSWORD = "密码不正确";
    public final String ERROR_NAME_PASSWORD = "用户名或密码不正确";

    public final String FAIL = "失败";
    public final String SUCCESS = "成功";
    public final String SUCCESS_UPDATE_PASSWORD = "修改密码成功";
    public final String SUCCESS_UNLOCK = "解锁成功";
    public final String SUCCESS_LOGIN = "登录成功";

    public final String GET_DATA_FAIL = "未获取到数据";
    public final String GET_DATA_SUCCESS = "成功取到数据";

    public final String DATA_LOSS = "数据缺失";
    public final String DATA_EXCEPTION = "数据异常";

    public final String AUDIT_SUCESS = "审核成功";
    public final String AUDIT_FAIL = "审核失败";

    public final String INSERT_SUCESS = "保存成功";
    public final String INSERT_FAIL = "保存失败";

    public final String UPDATE_SUCESS = "修改成功";
    public final String UPDATE_FAIL = "修改失败";

    public final String DELETE_SUCESS = "删除成功";
    public final String DELETE_FAIL = "删除失败";

    public final String UPLOAD_SUCESS = "上传成功";
    public final String UPLOAD_FAIL = "上传失败";

    public final String LAST_DATA_ONLY_UPDATE = "最后1条数据只能修改";
    public final String ROLE_USING_NOT_DELETE = "角色被用户使用禁止删除";
    public final String SUPER_ADMIN_FORBID_UPDAET = "超级管理员信息不能修改";
    public final String AUDIT_OPERATION_REPEAT = "审核业务重复";
    public final String NOY_ALLOW_AUDIT = "不允许送审";
    public final String AUDIT_KIND_USING = "审核类型使用中";
    public final String AUDIT_NEXT_STEP_DISABLE = "后续审核全部禁用";

}