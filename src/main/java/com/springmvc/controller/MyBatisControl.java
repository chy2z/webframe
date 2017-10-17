package com.springmvc.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springmvc.base.BaseController;
import com.springmvc.model.Users;
import com.springmvc.service.UsersService;

@Controller
@RequestMapping("/mybatis")
public class MyBatisControl extends BaseController {

	@Autowired
	private UsersService userService;

	/*
	 * http://localhost:8080/myspringmvc/mybatis/test
	 */
	@ResponseBody
	@RequestMapping(value = "/test")
	public String test() {
		return "测试方法";
	}

	/*
	 * http://localhost:8080/myspringmvc/mybatis/addUsers
	 */
	@ResponseBody
	@RequestMapping(value = "/addUsers")
	public String addUsers() {

		if (userService.addUsers())

			return "增加成功";

		else

			return "增加失败";
	}

	/*
	 * http://localhost:8080/myspringmvc/mybatis/updateUsers
	 */
	@ResponseBody
	@RequestMapping(value = "/updateUsers")
	public String updateUsers() {

		Users u = userService.getUsers(1);

		u.setState("修改");

		if (userService.updateUsers(u))

			return "修改成功";

		else

			return "修改失败";
	}

	/**
	 * http://localhost:8080/myspringmvc/mybatis/getAllUsers
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/getAllUsers")
	public String getAllUsers() {

		List<Map<String, Object>> ls = userService.getAllUsers();

		for (Map<String, Object> map : ls) {
			for (Map.Entry<String, Object> entry : map.entrySet()) {
				logger.info("{}.{}", entry.getKey(), entry.getValue());
			}
		}

		return "数量：" + ls.size();
	}
}