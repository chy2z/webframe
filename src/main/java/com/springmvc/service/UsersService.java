package com.springmvc.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.springmvc.mapper.UsersMapper;
import com.springmvc.model.Users;

/**
* @Title: UsersService
* @Description: 用户业务层
* @author chy
* @date 2017/10/18 16:00
*/
@Service
public class UsersService {

	@Autowired
	private UsersMapper umap;

	/**
	 * 获取用户信息
 	 * @param id
	 * @return
	 */
	public Users getUsers(int id) {
		return umap.selectByPrimaryKey(id);
	}

	/**
	 * 获取用户信息
	 * @param name
	 * @param pwd
	 * @return
	 */
	public Users getUsers(String name,String pwd){
		return umap.selectByNameAndPwd(name,pwd);
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
}
