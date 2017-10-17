package com.springmvc.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springmvc.mapper.UsersMapper;
import com.springmvc.model.Users;

@Service
public class UsersService {

	@Autowired
	private UsersMapper umap;

	/*
	 * 新增用户信息
	 */
	public boolean addUsers() {

		Users u = new Users();

		u.setName("成龙");

		u.setLoginname("jack");

		u.setDepart("市场部");

		u.setPassword("123456");

		return umap.insert(u) > 0;
	}

	/*
	 * 获取用户信息
	 */
	public Users getUsers(int id) {
		return umap.selectByPrimaryKey(id);
	}

	/**
	 * 更新用户信息
	 * 
	 * @param u
	 * @return
	 */
	public boolean updateUsers(Users u) {
		return umap.updateByPrimaryKey(u) > 0;
	}

	/*
	 * 获取所有用户信息
	 */
	public List<Map<String, Object>> getAllUsers() {
		return umap.getAllHashMap();
	}
}
