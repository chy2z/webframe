package com.springmvc.model.echart;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.springmvc.model.echart.style.itemstyle.Emphasis;
import com.springmvc.model.echart.style.itemstyle.Normal;
import lombok.Getter;
import lombok.Setter;

/**
* @Title: Label
* @Description:Label
* @author chy
* @date 2017/11/22 15:17
*/
@Getter
@Setter
@JsonAutoDetect(fieldVisibility=JsonAutoDetect.Visibility.ANY, getterVisibility=JsonAutoDetect.Visibility.NONE)
@JsonInclude(JsonInclude.Include.NON_EMPTY)
public class Label  {
    /**
     * normal属性
     */
    private Normal normal;
    /**
     * emphasis属性
     */
    private Emphasis emphasis;
}