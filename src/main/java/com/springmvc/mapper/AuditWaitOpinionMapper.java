package com.springmvc.mapper;

import com.springmvc.model.AuditWaitOpinion;

import java.util.List;

public interface AuditWaitOpinionMapper {

    int deleteByPrimaryKey(Integer id);

    int insertSelective(AuditWaitOpinion record);

    AuditWaitOpinion selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(AuditWaitOpinion record);

    List<AuditWaitOpinion> selectByAwid(Integer awid);
}
