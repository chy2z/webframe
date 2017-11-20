package com.springmvc.util;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.GetMethod;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;

/**
* @Title: ClientUtil
* @Description: 客户端操作类
* @author chy
* @date 2017/11/17 9:31
*/
public class ClientUtil {

    public static final Logger logger = LoggerFactory.getLogger(ClientUtil.class);

    /**
     * 获取访问用户的客户端IP（适用于公网与局域网）.
     */
    public static final String getIpAddr(final HttpServletRequest request)
            throws Exception {
        if (request == null) {
            throw (new Exception("getIpAddr method HttpServletRequest Object is null"));
        }
        String ipString = request.getHeader("x-forwarded-for");
        if (!StringUtil.isNotBlank(ipString) || "unknown".equalsIgnoreCase(ipString)) {
            ipString = request.getHeader("Proxy-Client-IP");
        }
        if (!StringUtil.isNotBlank(ipString) || "unknown".equalsIgnoreCase(ipString)) {
            ipString = request.getHeader("WL-Proxy-Client-IP");
        }
        if (!StringUtil.isNotBlank(ipString) || "unknown".equalsIgnoreCase(ipString)) {
            ipString = request.getRemoteAddr();
        }

        // 多个路由时，取第一个非unknown的ip
        final String[] arr = ipString.split(",");
        for (final String str : arr) {
            if (!"unknown".equalsIgnoreCase(str)) {
                ipString = str;
                break;
            }
        }

        return ipString;
    }

    /**
     * 查询IP信息
     * @param ip
     */
    public static final String queryIp(String ip){
        // http://freegeoip.net/json/
        // http://pv.sohu.com/cityjson?ie=utf-8
        //String  url="http://ip.taobao.com/service/getIpInfo.php?ip=112.26.51.68";
        //String  url="http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js&ip=112.26.51.68";
        String urlString="http://ip.taobao.com/service/getIpInfo.php?ip="+ip;
        String info = null;
        try{
            HttpClient httpclient = new HttpClient();
            GetMethod get=new GetMethod(urlString);
            httpclient.executeMethod(get);
            info = new String(get.getResponseBody(),"UTF-8");
            logger.info(info);
        }catch (Exception e) {
            e.printStackTrace();
        }
        return  info;
    }
}
