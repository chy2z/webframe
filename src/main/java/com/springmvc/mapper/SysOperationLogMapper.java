package com.springmvc.mapper;

import com.springmvc.model.SysOperationLog;

public interface SysOperationLogMapper {

    int deleteByPrimaryKey(Integer id);

    int insertSelective(SysOperationLog record);

    SysOperationLog selectByPrimaryKey(Integer id);

}