
package com.springmvc.model.echart.axis;

import com.springmvc.model.echart.code.AxisType;

import java.util.List;

/**
* @Title: CategoryAxis
* @Description:类目轴
* @author chy
* @date 2017/11/22 15:26
*/
public class CategoryAxis extends Axis<CategoryAxis> {

    /**
     * 构造函数
     */
    public CategoryAxis() {
        this.type(AxisType.category);
    }

    /**
     * 构造函数
     */
    public CategoryAxis(List data) {
        this.type(AxisType.category);
        this.setData(data);
    }

}
