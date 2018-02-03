package com.springmvc.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.springmvc.util.DateJsonDeserializerUtil;
import com.springmvc.util.DateJsonSerializerUtil;

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

    @JsonSerialize(using = DateJsonSerializerUtil.class)
    @JsonDeserialize(using = DateJsonDeserializerUtil.class)
    private Date createdate;

    @JsonSerialize(using = DateJsonSerializerUtil.class)
    @JsonDeserialize(using = DateJsonDeserializerUtil.class)
    private Date receivedate;

    @JsonSerialize(using = DateJsonSerializerUtil.class)
    @JsonDeserialize(using = DateJsonDeserializerUtil.class)
    private Date enddate;

    /**
     * 审核人
     */
    private Integer uid;

    private String url;

    private String tname;

    private String tkey;

    private String tvalue;

    private String content;

    //===========关联属性==================

    private Integer auid;

    private String senduser;

    private String senddepart;

    private String pname;

    private String operation;

    private String kname;

    private Integer stepnum;

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

    public Date getReceivedate() {
        return receivedate;
    }

    public void setReceivedate(Date receivedate) {
        this.receivedate = receivedate;
    }

    public Date getCreatedate() {
        return createdate;
    }

    public void setCreatedate(Date createdate) {
        this.createdate = createdate;
    }

    public Date getEnddate() {
        return enddate;
    }

    public void setEnddate(Date waitdate) {
        this.enddate = waitdate;
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

    public Integer getAuid() {
        return auid;
    }

    public void setAuid(Integer auid) {
        this.auid = auid;
    }

    public String getSenduser() {
        return senduser;
    }

    public void setSenduser(String senduser) {
        this.senduser = senduser;
    }

    public String getSenddepart() {
        return senddepart;
    }

    public void setSenddepart(String senddepart) {
        this.senddepart = senddepart;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public String getOperation() {
        return operation;
    }

    public void setOperation(String operation) {
        this.operation = operation;
    }

    public String getKname() {
        return kname;
    }

    public void setKname(String kname) {
        this.kname = kname;
    }

    public Integer getStepnum() {
        return stepnum;
    }

    public void setStepnum(Integer stepnum) {
        this.stepnum = stepnum;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}