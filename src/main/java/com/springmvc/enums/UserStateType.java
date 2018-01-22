package com.springmvc.enums;


/**
* @Title: UserStateType
* @Description: 用户状态管理
* @author chy
* @date 2018/1/22 16:02
*/
public enum UserStateType {

    Job("在职", 1), Other("其他", 2),Quit("离职", 3);

    private String name;

    private int index ;

    private UserStateType(String name, int index) {
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
