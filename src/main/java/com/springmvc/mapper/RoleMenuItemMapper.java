package com.springmvc.mapper;

import com.springmvc.model.RoleMenuItem;

import java.util.List;

public interface RoleMenuItemMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(RoleMenuItem record);

    int insertSelective(RoleMenuItem record);

    RoleMenuItem selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(RoleMenuItem record);

    int updateByPrimaryKey(RoleMenuItem record);

    /**
     * 根据角色删除
     * @param RoidId
     * @return
     */
    int deleteByRoleId(String  RoidId);

    /**
     * 批量插入
     * @param list
     * @return
     */
    int insertBatch(List<RoleMenuItem> list);
}