package com.springmvc.model;

public class RoleMenuItem {
    private Integer id;

    private String rolename;

    private String menuitemid;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getRolename() {
        return rolename;
    }

    public void setRolename(String rolename) {
        this.rolename = rolename == null ? null : rolename.trim();
    }

    public String getMenuitemid() {
        return menuitemid;
    }

    public void setMenuitemid(String menuitemid) {
        this.menuitemid = menuitemid == null ? null : menuitemid.trim();
    }
}