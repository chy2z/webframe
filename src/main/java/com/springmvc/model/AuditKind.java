package com.springmvc.model;

/**
* @Title: AuditKind
* @Description:审核类型
* @author chy
* @date 2017/12/28 15:34
*/
public class AuditKind {
    private Integer id;

    private String name;

    private String memo;

    private String operation;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo == null ? null : memo.trim();
    }

    public String getOperation() {
        return operation;
    }

    public void setOperation(String operation) {
        this.operation = operation;
    }
}