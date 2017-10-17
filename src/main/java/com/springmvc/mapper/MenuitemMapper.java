package com.springmvc.mapper;

import com.springmvc.model.Menuitem;

public interface MenuitemMapper {
    int deleteByPrimaryKey(String id);

    int insert(Menuitem record);

    int insertSelective(Menuitem record);

    Menuitem selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Menuitem record);

    int updateByPrimaryKey(Menuitem record);
}