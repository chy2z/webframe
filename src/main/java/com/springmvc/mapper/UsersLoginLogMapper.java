package com.springmvc.mapper;

import com.springmvc.model.Users;
import com.springmvc.model.UsersLoginLog;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UsersLoginLogMapper {

    int deleteByPrimaryKey(Integer id);

    int insertSelective(UsersLoginLog record);

    UsersLoginLog selectByPrimaryKey(Integer id);

    UsersLoginLog selectLast(Integer usersid);

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
    List<Users> selectPagination(@Param("where") String where,
                                 @Param("orderBy") String orderBy,
                                 @Param("start") Integer start,
                                 @Param("pageSize") Integer pageSize
    );

}