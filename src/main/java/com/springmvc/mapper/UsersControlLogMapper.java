package com.springmvc.mapper;

import com.springmvc.model.UsersControlLog;

public interface UsersControlLogMapper {

    int deleteByPrimaryKey(Integer id);

    int insertSelective(UsersControlLog record);

    UsersControlLog selectByPrimaryKey(Integer id);

}