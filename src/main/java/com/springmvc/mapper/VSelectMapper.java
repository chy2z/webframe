package com.springmvc.mapper;

import com.springmvc.model.iview.VSelect;

import java.util.List;

/**
* @Title: IviewSelectMapper
* @Description:
* @author chy
* @date 2017/10/30 9:46 
*/
public interface VSelectMapper {

    /**
     * 返回所有的字典关键字
     * @return
     */
    List<VSelect> selectDataDictionaryDkey();

    /**
     * 获取所有组织结构
     * @return
     */
    List<VSelect> selectCorporation();

}
