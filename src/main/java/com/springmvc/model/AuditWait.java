package com.springmvc.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.util.Date;

/**
* @Title: AuditWait
* @Description: 等待审核类
* @author chy
* @date 2018/1/13 15:45
*/
@JsonIgnoreProperties(ignoreUnknown=true)
public class AuditWait {
    private Integer id;

    private Integer pid;

    private Integer steps;

    private String status;

    private Date createdate;

    private Date waitdate;

    private Integer uid;

    private String url;

    private String tname;

    private String tkey;

    private String tvalue;

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

    public Integer getSteps() {
        return steps;
    }

    public void setSteps(Integer steps) {
        this.steps = steps;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public Date getCreatedate() {
        return createdate;
    }

    public void setCreatedate(Date createdate) {
        this.createdate = createdate;
    }

    public Date getWaitdate() {
        return waitdate;
    }

    public void setWaitdate(Date waitdate) {
        this.waitdate = waitdate;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }

    public String getTname() {
        return tname;
    }

    public void setTname(String tname) {
        this.tname = tname == null ? null : tname.trim();
    }

    public String getTkey() {
        return tkey;
    }

    public void setTkey(String tkey) {
        this.tkey = tkey == null ? null : tkey.trim();
    }

    public String getTvalue() {
        return tvalue;
    }

    public void setTvalue(String tvalue) {
        this.tvalue = tvalue == null ? null : tvalue.trim();
    }
}