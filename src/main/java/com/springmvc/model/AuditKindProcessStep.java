package com.springmvc.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.springmvc.util.DateJsonDeserializerUtil;
import com.springmvc.util.DateJsonSerializerUtil;

import java.util.Date;

/**
* @Title: AuditKindProcessStep
* @Description: 审核步骤
* @author chy
* @date 2018/1/12 10:25
*/
@JsonIgnoreProperties(ignoreUnknown=true)
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

    private String rolename;

    private String departname;

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

    public String getRolename() {
        return rolename;
    }

    public void setRolename(String rolename) {
        this.rolename = rolename;
    }

    public String getDepartname() {
        return departname;
    }

    public void setDepartname(String departname) {
        this.departname = departname;
    }
}