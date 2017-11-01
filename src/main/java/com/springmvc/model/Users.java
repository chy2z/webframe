package com.springmvc.model;

/**
* @Title: Users
* @Description: 用户表
* @author chy
* @date 2017/10/18 14:09
*/
public class Users {

    private Integer id;

    private String loginname;

    private String name;

    private String password;

    private Integer departid;

    private String office;

    private String phone;

    private String email;

    private Integer roleid;

    private String state;

    private Integer corporationid;

    private String token;

    private String img;

    //===========关联属性==================

    private String departName;

    private String roleName;

    private String corporationName;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLoginname() {
        return loginname;
    }

    public void setLoginname(String loginname) {
        this.loginname = loginname == null ? null : loginname.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public Integer getDepartid() {
        return departid;
    }

    public void setDepartid(Integer depart) {
        this.departid = depart;
    }

    public String getOffice() {
        return office;
    }

    public void setOffice(String office) {
        this.office = office == null ? null : office.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state == null ? null : state.trim();
    }

    public Integer getCorporationid() {
        return corporationid;
    }

    public void setCorporationid(Integer corporationid) {
        this.corporationid = corporationid;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token == null ? null : token.trim();
    }

    public Integer getRoleid() {
        return roleid;
    }

    public void setRoleid(Integer roleid) {
        this.roleid = roleid;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getDepartName() {
        return departName;
    }

    public void setDepartName(String departName) {
        this.departName = departName;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getCorporationName() {
        return corporationName;
    }

    public void setCorporationName(String corporationName) {
        this.corporationName = corporationName;
    }
}
