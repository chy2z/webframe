package com.springmvc.model.echart.axis;

import com.springmvc.model.echart.style.LineStyle;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
* @Title: SplitLine
* @Description:分隔线
* @author chy
* @date 2017/11/22 15:09
*/
@Getter
@Setter
public class SplitLine implements Serializable {

    private static final long serialVersionUID = 6968396515815364363L;

    /**
     * 默认显示，属性show控制显示与否
     */
    private Boolean show;
    /**
     * 小标记是否显示为间隔，默认等于boundaryGap
     */
    private Boolean onGap;
    /**
     * 属性lineStyle（详见lineStyle）控制线条样式
     *
     * @see com.springmvc.model.echart.style.LineStyle
     */
    private LineStyle lineStyle;

    /**
     * 获取show值
     */
    public Boolean show() {
        return this.show;
    }

    /**
     * 设置show值
     *
     * @param show
     */
    public SplitLine show(Boolean show) {
        this.show = show;
        return this;
    }

    /**
     * 获取onGap值
     */
    public Boolean onGap() {
        return this.onGap;
    }

    /**
     * 设置onGap值
     *
     * @param onGap
     */
    public SplitLine onGap(Boolean onGap) {
        this.onGap = onGap;
        return this;
    }

    /**
     * 设置lineStyle值
     *
     * @param lineStyle
     */
    public SplitLine lineStyle(LineStyle lineStyle) {
        this.lineStyle = lineStyle;
        return this;
    }

    /**
     * 属性lineStyle（详见lineStyle）控制线条样式
     *
     * @see com.springmvc.model.echart.style.LineStyle
     */
    public LineStyle lineStyle() {
        if (this.lineStyle == null) {
            this.lineStyle = new LineStyle();
        }
        return this.lineStyle;
    }

}
