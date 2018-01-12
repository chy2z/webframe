package com.springmvc.config;

/**
* @Title: SysConfig
* @Description: 系统配置
* @author chy
* @date 2017/10/20 9:39
*/
public class SysConfig {

    /**
     * 版本号
     */
    public static final String version="1.0.0";

    /**
     * 超级管理员
     */
    private static final String superAdmin = "-9999";

    /**
     * 超级管理员角色
     */
    public static final String superAdminRole="超级管理员";

    /**
     * 是否是超级管理员
     * @param roleid
     * @return
     */
    public static boolean isSuperAdmin(String roleid) {
        return SysConfig.superAdmin.equals(roleid);
    }

}
