package com.springmvc.enums;

/**
* @Title: AuditEnableType
* @Description: 审核启用状态
* @author chy
* @date 2018/1/13 16:27
*/
public enum AuditEnableType {

    YES("启用", 1), NO("禁用", 2);

    private String name;

    private int index ;

    private AuditEnableType(String name, int index) {
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
