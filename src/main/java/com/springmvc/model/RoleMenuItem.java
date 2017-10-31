package com.springmvc.model;

/**
* @Title: RoleMenuItem
* @Description: 角色菜单
* @author chy
* @date 2017/10/18 14:22
*/
public class RoleMenuItem {

    private Integer id;

    private String roleid;

    private String menuitemid;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getRoleid() {
        return roleid;
    }

    public void setRoleid(String roleid) {
        this.roleid = roleid;
    }

    public String getMenuitemid() {
        return menuitemid;
    }

    public void setMenuitemid(String menuitemid) {
        this.menuitemid = menuitemid == null ? null : menuitemid.trim();
    }
}