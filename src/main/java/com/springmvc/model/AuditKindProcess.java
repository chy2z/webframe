package com.springmvc.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
* @Title: AuditKindProcess
* @Description:审核流程
* @author chy
* @date 2018/1/12 10:24
*/
@JsonIgnoreProperties(ignoreUnknown=true)
public class AuditKindProcess {
    private Integer id;

    private Integer kid;

    private Integer stepnum;

    private Integer departid;

    private String enable;

    private String pname;

    //===========关联属性===============

    private String auditkind;

    private String departname;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getKid() {
        return kid;
    }

    public void setKid(Integer kid) {
        this.kid = kid;
    }

    public Integer getStepnum() {
        return stepnum;
    }

    public void setStepnum(Integer stepnum) {
        this.stepnum = stepnum;
    }

    public Integer getDepartid() {
        return departid;
    }

    public void setDepartid(Integer departid) {
        this.departid = departid;
    }

    public String getEnable() {
        return enable;
    }

    public void setEnable(String enable) {
        this.enable = enable == null ? null : enable.trim();
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public String getAuditkind() {
        return auditkind;
    }

    public void setAuditkind(String auditkind) {
        this.auditkind = auditkind;
    }

    public String getDepartname() {
        return departname;
    }

    public void setDepartname(String departname) {
        this.departname = departname;
    }
}