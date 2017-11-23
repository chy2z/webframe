package com.springmvc.model.echart;

import com.springmvc.model.echart.code.PointerType;
import com.springmvc.model.echart.style.CrossStyle;
import com.springmvc.model.echart.style.LineStyle;
import com.springmvc.model.echart.style.ShadowStyle;
import com.springmvc.model.echart.style.TextStyle;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
* @Title: AxisPointer
* @Description:坐标轴指示器，坐标轴触发有效
* @author chy
* @date 2017/11/23 22:36
*/
@Getter
@Setter
public class AxisPointer implements Serializable {

    private static final long serialVersionUID = 6421899185681683630L;

    /**
     * 是否显示
     */
    private Boolean show;

    /**
     * 默认为直线，可选为：'line' | 'shadow' | 'cross'
     *
     * @see com.springmvc.model.echart.code.PointerType
     */
    private PointerType type;
    /**
     * 设置直线指示器
     *
     * @see com.springmvc.model.echart.style.LineStyle
     */
    private LineStyle lineStyle;
    /**
     * 设置十字准星指示器
     */
    private CrossStyle crossStyle;
    /**
     * 设置阴影指示器
     */
    private ShadowStyle shadowStyle;
    /**
     * 文本样式
     */
    private TextStyle textStyle;

    /**
     * 获取textStyle值
     */
    public TextStyle textStyle() {
        return this.textStyle;
    }

    /**
     * 设置textStyle值
     *
     * @param textStyle
     */
    public AxisPointer textStyle(TextStyle textStyle) {
        if (this.textStyle == null) {
            this.textStyle = new TextStyle();
        }
        this.textStyle = textStyle;
        return this;
    }

    /**
     * 设置lineStyle值
     *
     * @param lineStyle
     */
    public AxisPointer lineStyle(LineStyle lineStyle) {
        this.lineStyle = lineStyle;
        return this;
    }

    /**
     * 设置crossStyle值
     *
     * @param crossStyle
     */
    public AxisPointer crossStyle(CrossStyle crossStyle) {
        this.crossStyle = crossStyle;
        return this;
    }

    /**
     * 设置shadowStyle值
     *
     * @param shadowStyle
     */
    public AxisPointer shadowStyle(ShadowStyle shadowStyle) {
        this.shadowStyle = shadowStyle;
        return this;
    }

    /**
     * 获取type值
     */
    public PointerType type() {
        return this.type;
    }

    /**
     * 设置type值
     *
     * @param type
     */
    public AxisPointer type(PointerType type) {
        this.type = type;
        return this;
    }

    /**
     * 是否显示
     */
    public Boolean show(){
        return this.show;
    }

    /**
     * 设置是否显示
     */
    public AxisPointer show(Boolean show){
        this.show = show;
        return this;
    }

    /**
     * 设置直线指示器
     *
     * @see com.springmvc.model.echart.style.LineStyle
     */
    public LineStyle lineStyle() {
        if (this.lineStyle == null) {
            this.lineStyle = new LineStyle();
        }
        return this.lineStyle;
    }

    /**
     * 设置十字准星指示器
     */
    public CrossStyle crossStyle() {
        if (this.crossStyle == null) {
            this.crossStyle = new CrossStyle();
        }
        return this.crossStyle;
    }

    /**
     * 设置阴影指示器
     */
    public ShadowStyle shadowStyle() {
        if (this.shadowStyle == null) {
            this.shadowStyle = new ShadowStyle();
        }
        return this.shadowStyle;
    }
}
