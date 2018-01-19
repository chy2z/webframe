package com.springmvc.mapper;

import com.springmvc.model.iview.VSelect;
import org.apache.ibatis.annotations.Param;

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
     * 返回字典属性
     * @return
     */
    List<VSelect> selectDataDictionaryValue(@Param("where") String where);

    /**
     * 获取所有组织结构
     * @return
     */
    List<VSelect> selectCorporation(@Param("where") String where);

    /**
     * 获取角色
     * @param where
     * @return
     */
    List<VSelect> selectRole(@Param("where") String where);

    /**
     * 返回部门
     * @return
     */
    List<VSelect> selectDepartment(@Param("where") String where);

    /**
     * 返回审核业务
     * @param where
     * @return
     */
    List<VSelect> selectAuditOperation(@Param("where") String where);

    /**
     * 返回审核类型
     * @param where
     * @return
     */
    List<VSelect> selectAuditKind(@Param("where") String where);

}