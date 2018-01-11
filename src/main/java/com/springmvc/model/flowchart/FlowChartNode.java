package com.springmvc.model.flowchart;


import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
* @Title: FlowChartNode
* @Description: 流程节点
* @author chy
* @date 2018/1/11 14:11
*/
@JsonIgnoreProperties(ignoreUnknown = true)
public class FlowChartNode {

    /**
     * prcs_id : 1
     * flow_prcs : 1
     * prcs_title : <b>申请人申请</b><br><br><img src="../js/jquery-jsplumb/images/flow_next.gif" align="absmiddle"> <span style="text-decoration:underline;font-weight:bold;color:red">程鸿雁 主办</span>[<font color=green>已办结,用时：4分钟39秒</font>]<br> 开始于：2018-01-08 10:04:30<br> 结束于：2018-01-08 10:09:09<br><br>
     * prcs_content : 第1步申请人申请(程鸿雁)
     * prcs_type :
     * prcs_class : window4
     * prcs_parent : 0
     * gather_node : 0
     */

    private int prcs_id;
    private String flow_prcs;
    private String prcs_title;
    private String prcs_content;
    private String prcs_type;
    private String prcs_class;
    private String prcs_parent;
    private String gather_node;

    public int getPrcs_id() {
        return prcs_id;
    }

    public void setPrcs_id(int prcs_id) {
        this.prcs_id = prcs_id;
    }

    public String getFlow_prcs() {
        return flow_prcs;
    }

    public void setFlow_prcs(String flow_prcs) {
        this.flow_prcs = flow_prcs;
    }

    public String getPrcs_title() {
        return prcs_title;
    }

    public void setPrcs_title(String prcs_title) {
        this.prcs_title = prcs_title;
    }

    public String getPrcs_content() {
        return prcs_content;
    }

    public void setPrcs_content(String prcs_content) {
        this.prcs_content = prcs_content;
    }

    public String getPrcs_type() {
        return prcs_type;
    }

    public void setPrcs_type(String prcs_type) {
        this.prcs_type = prcs_type;
    }

    public String getPrcs_class() {
        return prcs_class;
    }

    public void setPrcs_class(String prcs_class) {
        this.prcs_class = prcs_class;
    }

    public String getPrcs_parent() {
        return prcs_parent;
    }

    public void setPrcs_parent(String prcs_parent) {
        this.prcs_parent = prcs_parent;
    }

    public String getGather_node() {
        return gather_node;
    }

    public void setGather_node(String gather_node) {
        this.gather_node = gather_node;
    }
}
