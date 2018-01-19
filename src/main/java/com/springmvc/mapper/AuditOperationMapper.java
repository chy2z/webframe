package com.springmvc.mapper;

import com.springmvc.model.AuditOperation;

public interface AuditOperationMapper {

    int deleteByPrimaryKey(Integer id);

    int insertSelective(AuditOperation record);

    AuditOperation selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(AuditOperation record);
}