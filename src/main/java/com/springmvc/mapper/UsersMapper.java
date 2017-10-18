package com.springmvc.mapper;

import com.springmvc.model.Users;
import org.apache.ibatis.annotations.Param;

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
}