package com.springmvc.enums;

/**
* @Title: AuditStateType
* @Description: 审核状态
* @author chy
* @date 2018/1/13 16:04
*/
public enum  AuditStateType {

    XSQ("新申请", 1),TG("通过", 2), SHZ("审核中", 3),DH("打回", 4);

    private String name;

    private int index ;

    private AuditStateType(String name,int index) {
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
