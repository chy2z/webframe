package com.springmvc.model;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.springmvc.util.DateJsonDeserializerUtil;
import com.springmvc.util.DateJsonSerializerUtil;

import java.util.Date;

/**
* @Title: SysDataLog
* @Description: 系统操作日志
* @author chy
* @date 2018/1/31 9:46
*/
public class SysDataLog {
    private Integer id;

    private Integer uid;

    private String type;

    private String name;

    private String funid;

    private String funname;

    private String resource;

    @JsonSerialize(using = DateJsonSerializerUtil.class)
    @JsonDeserialize(using = DateJsonDeserializerUtil.class)
    private Date createtime;

    private String changed;

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

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getFunid() {
        return funid;
    }

    public void setFunid(String funid) {
        this.funid = funid == null ? null : funid.trim();
    }

    public String getFunname() {
        return funname;
    }

    public void setFunname(String funname) {
        this.funname = funname;
    }

    public String getResource() {
        return resource;
    }

    public void setResource(String resource) {
        this.resource = resource == null ? null : resource.trim();
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public String getChanged() {
        return changed;
    }

    public void setChanged(String changed) {
        this.changed = changed == null ? null : changed.trim();
    }
}