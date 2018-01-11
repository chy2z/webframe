package com.springmvc.model.flowchart;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

/**
* @Title: FlowChart
* @Description: 流程图
* @author chy
* @date 2018/1/11 14:10
*/
@Getter
@Setter
@JsonIgnoreProperties(ignoreUnknown = true)
public class FlowChart<T> {
    /**
     {
     "total": 5,
     "level": "4",
     "list": [
         {
         "prcs_id": 1,
         "flow_prcs": "1",
         "prcs_title": "<b>申请人申请</b><br><br><img src=\"../js/jquery-jsplumb/images/flow_next.gif\" align=\"absmiddle\"> <span style=\"text-decoration:underline;font-weight:bold;color:red\">程鸿雁 主办</span>[<font color=green>已办结,用时：4分钟39秒</font>]<br> 开始于：2018-01-08 10:04:30<br> 结束于：2018-01-08 10:09:09<br><br>",
         "prcs_content": "第1步申请人申请(程鸿雁)",
         "prcs_type": "",
         "prcs_class": "window4",
         "prcs_parent": "0",
         "gather_node": "0"
         }
     ]
     }
     */

    private int total;
    private String level;
    private List<T> list;

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public List<T> getList() {
        return list;
    }

    public void setList(List<T> list) {
        this.list = list;
    }
}