package com.springmvc.model;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.springmvc.util.DateJsonDeserializerUtil;
import com.springmvc.util.DateJsonSerializerUtil;

import java.util.Date;

public class AuditKindProcessStep {
    private Integer id;

    private Integer pid;

    private Integer uid;

    private Integer step;

    private String enable;

    @JsonSerialize(using = DateJsonSerializerUtil.class)
    @JsonDeserialize(using = DateJsonDeserializerUtil.class)
    private Date createdate;

    //===========关联属性===============

    private String uname;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public Integer getStep() {
        return step;
    }

    public void setStep(Integer step) {
        this.step = step;
    }

    public String getEnable() {
        return enable;
    }

    public void setEnable(String enable) {
        this.enable = enable == null ? null : enable.trim();
    }

    public Date getCreatedate() {
        return createdate;
    }

    public void setCreatedate(Date createdate) {
        this.createdate = createdate;
    }

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }
}