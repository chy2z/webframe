package com.springmvc.config;

/**
* @Title: SysConfig
* @Description: 系统配置
* @author chy
* @date 2017/10/20 9:39
*/
public class SysConfig {

    /**
     * 超级管理员
     */
    private static final String superAdmin = "-9999";

    /**
     * 是否是超级管理员
     * @param roleid
     * @return
     */
    public static boolean isSuperAdmin(String roleid) {
        return SysConfig.superAdmin.equals(roleid);
    }
}
