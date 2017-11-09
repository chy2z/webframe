package com.springmvc.util;

/**
* @Title: StringUtil
* @Description: 字符串处理
* @author chy
* @date 2017/10/22 21:27
*/
public class StringUtil {

    /**
     * 字符串为 null or 字符串
     * 不能为 ""和"null"
     * @param str
     * @return
     */
    public static String nullOrString(String str){
        if(str.equals("")||str.toUpperCase().equals("NULL")) {
            return null;
        }
        else {
            return str;
        }
    }

    /**
     * 判断是否是空白字符串
     * @param str
     * @return
     */
    public static boolean isNotBlank(String str){
        if(str==null||str.equals("")) {
            return false;
        }
        else {
            return true;
        }
    }

}
