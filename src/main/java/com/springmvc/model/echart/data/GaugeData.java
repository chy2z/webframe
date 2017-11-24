package com.springmvc.model.echart.data;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.springmvc.model.echart.Label;
import com.springmvc.model.echart.Tooltip;
import com.springmvc.model.echart.style.ItemStyle;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@JsonAutoDetect(fieldVisibility=JsonAutoDetect.Visibility.ANY, getterVisibility=JsonAutoDetect.Visibility.NONE)
@JsonInclude(JsonInclude.Include.NON_EMPTY)
public class GaugeData {
    private String name;
    private Object value;
    private Object symbol;
    private Object symbolSize;
    private ItemStyle itemStyle;
    private Label label;
    private Tooltip tooltip;

    /**
     * 构造函数
     */
    public GaugeData() {

    }

    /**
     * 构造函数,参数:name,value
     *
     * @param name
     * @param value
     */
    public GaugeData(String name, Object value) {
        this.name = name;
        this.value = value;
    }
}
