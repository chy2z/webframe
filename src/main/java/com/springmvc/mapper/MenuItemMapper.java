package com.springmvc.mapper;

import com.springmvc.model.MenuItem;

import java.util.List;

public interface MenuItemMapper {
    int deleteByPrimaryKey(String id);

    int insert(MenuItem record);

    int insertSelective(MenuItem record);

    MenuItem selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(MenuItem record);

    int updateByPrimaryKey(MenuItem record);

    List<MenuItem> selectAll();

    List<MenuItem> selectByRole(String roleName);
}