package com.springmvc.mapper;

import java.util.List;
import java.util.Map;

import com.springmvc.model.Users;

public interface UsersMapper {

	int deleteByPrimaryKey(Integer id);

	int insert(Users record);

	int insertSelective(Users record);

	Users selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(Users record);

	int updateByPrimaryKey(Users record);

	List<Map<String, Object>> getAllHashMap();
}