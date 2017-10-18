package com.springmvc.mapper;

import com.springmvc.model.RoleMenuItem;

public interface RoleMenuItemMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(RoleMenuItem record);

    int insertSelective(RoleMenuItem record);

    RoleMenuItem selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(RoleMenuItem record);

    int updateByPrimaryKey(RoleMenuItem record);
}