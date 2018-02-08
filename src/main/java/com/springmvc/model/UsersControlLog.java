package com.springmvc.model;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.springmvc.util.DateJsonDeserializerUtil;
import com.springmvc.util.DateJsonSerializerUtil;

import java.util.Date;

/**
* @Title: UsersControlLog
* @Description: 用户控制日志
* @author chy
* @date 2018/2/5 15:17
*/
public class UsersControlLog {
    private Integer id;

    private Integer uid;

    private String token;

    private String type;

    private String url;

    private String name;

    @JsonSerialize(using = DateJsonSerializerUtil.class)
    @JsonDeserialize(using = DateJsonDeserializerUtil.class)
    private Date createdate;

    private String parameter;

    //===========关联属性==============

    private String uName;

    private String departName;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token == null ? null : token.trim();
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public Date getCreatedate() {
        return createdate;
    }

    public void setCreatedate(Date createdate) {
        this.createdate = createdate;
    }

    public String getParameter() {
        return parameter;
    }

    public void setParameter(String parameter) {
        this.parameter = parameter == null ? null : parameter.trim();
    }

    public String getuName() {
        return uName;
    }

    public void setuName(String uName) {
        this.uName = uName;
    }

    public String getDepartName() {
        return departName;
    }

    public void setDepartName(String departName) {
        this.departName = departName;
    }
}