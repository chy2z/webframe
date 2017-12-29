package com.springmvc.mapper;

import com.springmvc.model.AuditKindProcess;

public interface AuditKindProcessMapper {

    int deleteByPrimaryKey(Integer id);

    int insertSelective(AuditKindProcess record);

    AuditKindProcess selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(AuditKindProcess record);
}