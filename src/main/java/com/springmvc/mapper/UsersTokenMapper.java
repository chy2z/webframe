package com.springmvc.mapper;

import com.springmvc.model.UsersToken;

/**
* @Title: UsersTokenMapper
* @Description: 用户Token操作接口
* @author chy
* @date 2017/10/19 15:43
*/
public interface UsersTokenMapper {

    int deleteByPrimaryKey(Integer id);

    int insert(UsersToken record);

    int insertSelective(UsersToken record);

    UsersToken selectByPrimaryKey(Integer id);

    UsersToken selectByUserId(Integer userid);

    UsersToken selectByMd5Token(String md5Token);

    int updateByPrimaryKeySelective(UsersToken record);

    int updateByPrimaryKey(UsersToken record);
}