package com.springmvc.util;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import java.io.IOException;

/**
* @Title: Base64
* @Description: 加密和解密
* @author chy
* @date 2017/12/22 16:47
*/
public class Base64 {

    /**
     * 使用jdk的base64 加密字符串
     * */
    public static String jdkBase64Encoder(String str)
    {
        BASE64Encoder encoder = new BASE64Encoder();
        String encode = encoder.encode(str.getBytes());
        return encode;
    }
    /**
     * 使用jdk的base64 解密字符串
     * 返回为null表示解密失败
     * */
    public static String jdkBase64Decoder(String str)
    {
        BASE64Decoder decoder = new BASE64Decoder();
        String decode=null;
        try {
            decode = new String( decoder.decodeBuffer(str));
        } catch (IOException e) {
            e.printStackTrace();
        }
        return decode;
    }
}
