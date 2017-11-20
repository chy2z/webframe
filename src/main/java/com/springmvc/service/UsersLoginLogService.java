package com.springmvc.service;

import com.springmvc.mapper.UsersLoginLogMapper;
import com.springmvc.model.UsersLoginLog;
import org.springframework.beans.factory.annotation.Autowired;

/**
* @Title: UsersLoginLogService
* @Description: 用户登录业务层
* @author chy
* @date 2017/11/20 9:55
*/
public class UsersLoginLogService {

  @Autowired
  UsersLoginLogMapper usersLoginLogMapper;

  public boolean insert(UsersLoginLog u){
      return  usersLoginLogMapper.insertSelective(u)>0;
  }

}
