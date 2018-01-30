package com.springmvc.enums;

/**
* @Title: RecordPermissionsType
* @Description: 记录权限类型
* @author chy
* @date 2018/1/30 15:50
*/
public enum RecordPermissionsType {

    U("操作个人记录", 1),D("操作部门记录", 2), C("操作全部记录", 4);

    private String name;

    private int index ;

    private RecordPermissionsType(String name,int index) {
        this.name = name;
        this.index = index;
    }

    public static RecordPermissionsType valueOf(int value) {
        switch (value) {
            case 1:
                return U;
            case 2:
                return D;
            case 4:
                return C;
            default:
                return null;
        }
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
