package com.springmvc.mapper;

import com.springmvc.model.UsersToken;

public interface UsersTokenMapper {

    int deleteByPrimaryKey(Integer id);

    int insert(UsersToken record);

    int insertSelective(UsersToken record);

    UsersToken selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(UsersToken record);

    int updateByPrimaryKey(UsersToken record);
}