package com.springmvc.mapper;

import com.springmvc.model.Corporation;
import com.springmvc.model.Users;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
* @Title: UsersMapper
* @Description: 用户操作接口
* @author chy
* @date 2017/10/18 16:00
*/
public interface UsersMapper {

    int deleteByPrimaryKey(Integer id);

    int insert(Users record);

    int insertSelective(Users record);

    Users selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Users record);

    int updateByPrimaryKey(Users record);

    Users selectByNameAndPwd(@Param("loginName") String loginName,@Param("password") String password);

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