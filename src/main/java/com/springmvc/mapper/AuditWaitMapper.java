package com.springmvc.mapper;

import com.springmvc.model.AuditWait;
import org.apache.ibatis.annotations.Param;

public interface AuditWaitMapper {
    int deleteByPrimaryKey(Integer id);

    int insertSelective(AuditWait record);

    AuditWait selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(AuditWait record);

    /**
     * 获取审核状态
     * @param auditState
     * @param tName
     * @param tKey
     * @param tValue
     * @return
     */
    String getAuditState(@Param("auditState") String auditState,
                         @Param("tName") String tName,
                         @Param("tKey") String tKey,
                         @Param("tValue") String tValue);
}