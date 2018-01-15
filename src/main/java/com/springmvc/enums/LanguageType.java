package com.springmvc.enums;

/**
* @Title: LanguageType
* @Description: 语言枚举
* @author chy
* @date 2018/1/13 9:55
*/
public enum LanguageType {

    ZHCN("zh-cn", 1), ENUS("en-us", 2);

    private String name;

    private int index ;

    private LanguageType(String name,int index) {
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
