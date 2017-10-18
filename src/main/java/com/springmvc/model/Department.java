package com.springmvc.model;

/**
* @Title: Department
* @Description: 部门
* @author chy
* @date 2017/10/18 14:10
*/
public class Department {
    private Integer id;

    private Integer corporationid;

    private String name;

    private String phone;

    private String leader;

    private String address;

    private String memo;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCorporationid() {
        return corporationid;
    }

    public void setCorporationid(Integer corporationid) {
        this.corporationid = corporationid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public String getLeader() {
        return leader;
    }

    public void setLeader(String leader) {
        this.leader = leader == null ? null : leader.trim();
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo == null ? null : memo.trim();
    }
}