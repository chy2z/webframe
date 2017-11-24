package com.springmvc.model.echart;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.springmvc.model.echart.style.itemstyle.Emphasis;
import com.springmvc.model.echart.style.itemstyle.Normal;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
* @Title: LabelLine
* @Description:标签视觉引导线l
* @author chy
* @date 2017/11/22 15:17
*/
@Getter
@Setter
@JsonAutoDetect(fieldVisibility=JsonAutoDetect.Visibility.ANY, getterVisibility=JsonAutoDetect.Visibility.NONE)
@JsonInclude(JsonInclude.Include.NON_EMPTY)
public class LabelLine implements Serializable {

    private static final long serialVersionUID = 3359589478018844177L;

    /**
     * normal属性
     */
    private Normal normal;
    /**
     * emphasis属性
     */
    private Emphasis emphasis;
}
