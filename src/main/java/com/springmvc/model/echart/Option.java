package com.springmvc.model.echart;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.springmvc.model.echart.axis.Axis;
import com.springmvc.model.echart.series.Series;
import com.springmvc.util.JsonUtil;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

/**
* @Title: Option
* @Description: echart option
* @author chy
* @date 2017/11/21 23:06
*/
@ToString
@NoArgsConstructor
@Getter
@Setter
/**
 * JsonAutoDetect
 * 只检测属性不检测方法
 * 序列化对象时对象属性不自动转换大小写，保持原来的对象属性名称
 */
@JsonAutoDetect(fieldVisibility=JsonAutoDetect.Visibility.ANY, getterVisibility=JsonAutoDetect.Visibility.NONE)
/**
 * Include.Include.ALWAYS （Default / 都参与序列化）
 * Include.NON_DEFAULT（当Value 为默认值的时候不参与，如Int a; 当 a=0 的时候不参与）
 * Include.NON_EMPTY（当Value 为“” 或者null 不输出）
 * Include.NON_NULL（当Value 为null 不输出）
 */
@JsonInclude(JsonInclude.Include.NON_EMPTY)
public class Option {

    private Legend legend;

    /**
     * 直角坐标系中横轴数组（详见xAxis），数组中每一项代表一条横轴坐标轴，标准（1.0）中规定最多同时存在2条横轴
     */
    private List<Axis> xAxis;
    /**
     * 直角坐标系中纵轴数组（详见yAxis），数组中每一项代表一条纵轴坐标轴，标准（1.0）中规定最多同时存在2条纵轴
     */
    private List<Axis> yAxis;

    private List<Series> series;

    /**
     * 返回json数据
     * @return
     */
    public String toJson(){
        return JsonUtil.writeValueAsString(this);
    }
}
