package com.springmvc.model;

public class DataDictionary {
    private Integer id;

    private String dkey;

    private String dvalue;

    private String dmemo;

    private Integer display;

    private Integer dorder;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDkey() {
        return dkey;
    }

    public void setDkey(String dkey) {
        this.dkey = dkey == null ? null : dkey.trim();
    }

    public String getDvalue() {
        return dvalue;
    }

    public void setDvalue(String dvalue) {
        this.dvalue = dvalue == null ? null : dvalue.trim();
    }

    public String getDmemo() {
        return dmemo;
    }

    public void setDmemo(String dmemo) {
        this.dmemo = dmemo == null ? null : dmemo.trim();
    }

    public Integer getDisplay() {
        return display;
    }

    public void setDisplay(Integer display) {
        this.display = display;
    }

    public Integer getDorder() {
        return dorder;
    }

    public void setDorder(Integer dorder) {
        this.dorder = dorder;
    }
}