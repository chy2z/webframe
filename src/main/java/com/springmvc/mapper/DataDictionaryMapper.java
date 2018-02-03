package com.springmvc.mapper;

import com.springmvc.model.Corporation;
import com.springmvc.model.DataDictionary;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface DataDictionaryMapper {
    int deleteByPrimaryKey(Integer id);

    int insertSelective(DataDictionary record);

    DataDictionary selectByPrimaryKey(Integer id);

    DataDictionary selectByDkey(String dkey);

    int updateByPrimaryKeySelective(DataDictionary record);

    /**
     * 根据条件获取记录数
     * @param where
     * @param orderBy
     * @return
     */
    int getParentCount(@Param("where") String where, @Param("orderBy") String orderBy);

    /**
     * 分页获取记录
     * @param where
     * @param orderBy
     * @param start
     * @param pageSize
     * @return
     */
    List<Corporation> selectParentPagination(@Param("where") String where,
                                       @Param("orderBy") String orderBy,
                                       @Param("start") Integer start,
                                       @Param("pageSize") Integer pageSize
    );


    /**
     * 根据条件获取记录数
     * @param where
     * @param orderBy
     * @return
     */
    int getChildCount(@Param("where") String where, @Param("orderBy") String orderBy);

    /**
     * 分页获取记录
     * @param where
     * @param orderBy
     * @param start
     * @param pageSize
     * @return
     */
    List<Corporation> selectChildPagination(@Param("where") String where,
                                             @Param("orderBy") String orderBy,
                                             @Param("start") Integer start,
                                             @Param("pageSize") Integer pageSize
    );
}