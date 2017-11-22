package com.springmvc.mapper;

import com.springmvc.model.UsersLoginLog;

public interface UsersLoginLogMapper {

    int deleteByPrimaryKey(Integer id);

    int insertSelective(UsersLoginLog record);

    UsersLoginLog selectByPrimaryKey(Integer id);

    UsersLoginLog selectLast(Integer usersid);

}