package com.springmvc.mapper;

import com.springmvc.model.AuditWait;
import com.springmvc.model.Corporation;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AuditWaitMapper {
    int deleteByPrimaryKey(Integer id);

    int insertSelective(AuditWait record);

    AuditWait selectByPrimaryKey(Integer id);

    /**
     * 获取最新的待审核信息
     * @param tName
     * @param tKey
     * @param tValue
     * @return
     */
    AuditWait selectNewest(@Param("tName") String tName,
                                 @Param("tKey") String tKey,
                                 @Param("tValue") String tValue);


    int updateByPrimaryKeySelective(AuditWait record);

    /**
     * 更新送审记录的状态
     * @param tName
     * @param tKey
     * @param tValue
     * @return
     */
    int updateOperation(@Param("tName") String tName,
                        @Param("tKey") String tKey,
                        @Param("tValue") String tValue,
                        @Param("auditState") String auditState
                        );

    /**
     * 根据Pid获取审核记录数
     * @param pid
     * @return
     */
    int getCountByPid(@Param("pid")  Integer pid);

    /**
     * 获取送审记录审核状态
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

    /**
     * 获取审核流程id
     * @param tName
     * @param tKey
     * @param tValue
     * @return
     */
    Integer getAuditProcess(@Param("tName") String tName,
                         @Param("tKey") String tKey,
                         @Param("tValue") String tValue);

    /**
     * 获取审核流程数量
     * @param operation
     * @param departId
     * @param enable
     * @return
     */
    Integer getAuditProcessCount(@Param("operation") String operation,
                                 @Param("departId") String departId,
                                 @Param("enable") String enable);

    /**
     * 获取等待审核记录数
     * @param where
     * @return
     */
    int getAuditWaitCount(@Param("where") String where);

    /**
     * 根据条件获取记录数
     * @param where
     * @param orderBy
     * @return
     */
    int getCount(@Param("where") String where,
                 @Param("orderBy") String orderBy,
                 @Param("whereInner") String whereInner,
                 @Param("orderByInner") String orderByInner);

    /**
     * 分页获取记录
     * @param where
     * @param orderBy
     * @param start
     * @param pageSize
     * @return
     */
    List<Corporation> selectPagination(@Param("where") String where,
                                       @Param("orderBy") String orderBy,
                                       @Param("start") Integer start,
                                       @Param("pageSize") Integer pageSize,
                                       @Param("whereInner") String whereInner,
                                       @Param("orderByInner") String orderByInner
    );
}