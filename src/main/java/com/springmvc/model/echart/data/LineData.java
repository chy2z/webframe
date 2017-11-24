package com.springmvc.model.echart.data;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.springmvc.model.echart.Label;
import com.springmvc.model.echart.Tooltip;
import com.springmvc.model.echart.style.ItemStyle;
import lombok.Getter;
import lombok.Setter;

/**
* @Title: LineData
* @Description: 折线
* @author chy
* @date 2017/11/23 22:29
*/
@Getter
@Setter
@JsonAutoDetect(fieldVisibility=JsonAutoDetect.Visibility.ANY, getterVisibility=JsonAutoDetect.Visibility.NONE)
@JsonInclude(JsonInclude.Include.NON_EMPTY)
public class LineData  {
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
    public LineData() {
    }

    /**
     * 构造函数,参数:value
     *
     * @param value
     */
    public LineData(Object value) {
        this.value = value;
    }

    /**
     * 构造函数,参数:name,value
     *
     * @param name
     * @param value
     */
    public LineData(String name, Object value) {
        this.name = name;
        this.value = value;
    }

    /**
     * 构造函数,参数:name,symbol,symbolSize
     *
     * @param name
     * @param symbol
     * @param symbolSize
     */
    public LineData(String name, Object symbol, Object symbolSize) {
        this.name = name;
        this.symbol=symbol;
        this.symbolSize=symbolSize;
    }

    /**
     * 构造函数,参数:value,symbol
     *
     * @param value
     * @param symbol
     */
    public LineData(Object value, Object symbol) {
        this.value = value;
        this.symbol=symbol;
    }

    /**
     * 构造函数,参数:value,symbol,symbolSize
     *
     * @param value
     * @param symbol
     * @param symbolSize
     */
    public LineData(Object value, Object symbol, Object symbolSize) {
        this.value = value;
        this.symbol=symbol;
        this.symbolSize=symbolSize;
    }
}
