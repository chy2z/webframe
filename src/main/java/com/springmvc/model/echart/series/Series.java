package com.springmvc.model.echart.series;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.springmvc.model.echart.AbstractData;
import com.springmvc.model.echart.Chart;
import com.springmvc.model.echart.Label;
import com.springmvc.model.echart.code.SeriesType;
import com.springmvc.model.echart.style.ItemStyle;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
* @Title: Series
* @Description: echart  Series
* @author chy
* @date 2017/11/21 23:03
*/
@Getter
@Setter
@ToString
@NoArgsConstructor
@JsonInclude(JsonInclude.Include.NON_EMPTY)
@JsonAutoDetect(fieldVisibility=JsonAutoDetect.Visibility.ANY, getterVisibility=JsonAutoDetect.Visibility.NONE)
public class Series<T> extends AbstractData<T> implements Chart {

    private String name;

    private SeriesType type;

    private String stack;

    /**
     * 图形上的文本标签，课用于说明图形的一些数据信息，
     * 比如值，名称等，label选项在 ECharts 2.x 中放置于itemStyle.normal下，
     * 在 ECharts 3 中为了让整个配置项结构更扁平合理，label被拿出来跟 itemStyle 平级，
     * 并且跟 itemStyle 一样拥有 normal, emphasis 两个状态
     */
    private ItemStyle itemStyle;

    private Label label;
}
