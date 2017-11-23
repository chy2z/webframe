package com.springmvc.model.echart.style;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.springmvc.model.echart.style.itemstyle.Normal;

import java.io.Serializable;

/**
* @Title: AreaStyle
* @Description:区域填充样式
* @author chy
* @date 2017/11/22 15:10
*/
@JsonAutoDetect(fieldVisibility=JsonAutoDetect.Visibility.ANY, getterVisibility=JsonAutoDetect.Visibility.NONE)
@JsonInclude(JsonInclude.Include.NON_EMPTY)
public class AreaStyle implements Serializable {

    private static final long serialVersionUID = -6547716731700677234L;

    /**
     * 颜色
     */
    private Object color;

    /**
     * 默认样式
     */
    private Normal normal;

    /**
     * 填充样式，目前仅支持'default'(实填充)
     */
    private Object type;

    /**
     * 获取color值
     */
    public Object color() {
        return this.color;
    }

    /**
     * 设置color值
     *
     * @param color
     */
    public AreaStyle color(Object color) {
        this.color = color;
        return this;
    }

    /**
     * 获取type值
     */
    public Object type() {
        return this.type;
    }

    /**
     * 设置type值
     *
     * @param type
     */
    public AreaStyle type(Object type) {
        this.type = type;
        return this;
    }

    /**
     * 获取typeDefault值
     */
    public AreaStyle typeDefault() {
        this.type = "default";
        return this;
    }

    /**
     * 获取color值
     */
    public Object getColor() {
        return color;
    }

    /**
     * 设置color值
     *
     * @param color
     */
    public void setColor(Object color) {
        this.color = color;
    }

    /**
     * 获取type值
     */
    public Object getType() {
        return type;
    }

    /**
     * 设置type值
     *
     * @param type
     */
    public void setType(Object type) {
        this.type = type;
    }

    /**
     * 获取实填充样式
     * @return
     */
    public Normal getNormal() {
        return normal;
    }

    /**
     * 填充样式实填充
     * @return
     */
    public void setNormal(Normal normal) {
        this.normal = normal;
    }
}
