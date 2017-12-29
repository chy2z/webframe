package com.springmvc.mapper;

import com.springmvc.model.AuditKindProcess;
import com.springmvc.model.Corporation;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AuditKindProcessMapper {

    int deleteByPrimaryKey(Integer id);

    int insertSelective(AuditKindProcess record);

    AuditKindProcess selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(AuditKindProcess record);

    /**
     * 根据条件获取记录数
     * @param where
     * @param orderBy
     * @return
     */
    int getCount(@Param("where") String where, @Param("orderBy") String orderBy);

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
                                       @Param("pageSize") Integer pageSize
    );
}