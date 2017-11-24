package com.springmvc.model.echart.data;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.springmvc.model.echart.Label;
import com.springmvc.model.echart.Tooltip;
import com.springmvc.model.echart.style.ItemStyle;
import lombok.Getter;
import lombok.Setter;

/**
* @Title: BarData
* @Description: 柱状图
* @author chy
* @date 2017/11/23 23:23
*/
@Getter
@Setter
@JsonAutoDetect(fieldVisibility=JsonAutoDetect.Visibility.ANY, getterVisibility=JsonAutoDetect.Visibility.NONE)
@JsonInclude(JsonInclude.Include.NON_EMPTY)
public class BarData {

    private String name;
    private Object value;
    private ItemStyle itemStyle;
    private Label label;
    private Tooltip tooltip;

    /**
     * 构造函数,参数:value
     *
     * @param value
     */
    public BarData(Object value) {
         this.value=value;
    }

    /**
     * 构造函数,参数:name,value
     *
     * @param name
     * @param value
     */
    public BarData(String name, Object value) {
        this.name = name;
        this.value = value;
    }
}
