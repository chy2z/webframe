package com.springmvc.enums;

/**
* @Title: EncryptionType
* @Description: 加密类型
* @author chy
* @date 2018/1/30 16:05
*/
public enum EncryptionType {

    MD5("md5", 1), BASE64("base64", 2);

    private String name;

    private int index ;

    private EncryptionType(String name, int index) {
        this.name = name;
        this.index = index;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getIndex() {
        return index;
    }

    public void setIndex(int index) {
        this.index = index;
    }

}
