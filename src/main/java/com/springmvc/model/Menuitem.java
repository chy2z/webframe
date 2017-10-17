package com.springmvc.model;

public class Menuitem {
    private String id;

    private String funcname;

    private String parentid;

    private String descript;

    private String funcurl;

    private String leaf;

    private String image;

    private String toolimage;

    private String navigationimage;

    private String navigationurl;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getFuncname() {
        return funcname;
    }

    public void setFuncname(String funcname) {
        this.funcname = funcname == null ? null : funcname.trim();
    }

    public String getParentid() {
        return parentid;
    }

    public void setParentid(String parentid) {
        this.parentid = parentid == null ? null : parentid.trim();
    }

    public String getDescript() {
        return descript;
    }

    public void setDescript(String descript) {
        this.descript = descript == null ? null : descript.trim();
    }

    public String getFuncurl() {
        return funcurl;
    }

    public void setFuncurl(String funcurl) {
        this.funcurl = funcurl == null ? null : funcurl.trim();
    }

    public String getLeaf() {
        return leaf;
    }

    public void setLeaf(String leaf) {
        this.leaf = leaf == null ? null : leaf.trim();
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image == null ? null : image.trim();
    }

    public String getToolimage() {
        return toolimage;
    }

    public void setToolimage(String toolimage) {
        this.toolimage = toolimage == null ? null : toolimage.trim();
    }

    public String getNavigationimage() {
        return navigationimage;
    }

    public void setNavigationimage(String navigationimage) {
        this.navigationimage = navigationimage == null ? null : navigationimage.trim();
    }

    public String getNavigationurl() {
        return navigationurl;
    }

    public void setNavigationurl(String navigationurl) {
        this.navigationurl = navigationurl == null ? null : navigationurl.trim();
    }
}