package com.springmvc.mapper;

import com.springmvc.model.Corporation;

public interface CorporationMapper {

    int deleteByPrimaryKey(Integer id);

    int insert(Corporation record);

    int insertSelective(Corporation record);

    Corporation selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Corporation record);

    int updateByPrimaryKey(Corporation record);
}