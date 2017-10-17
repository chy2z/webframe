package com.springmvc.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springmvc.base.BaseController;
import com.springmvc.util.DateUtil;
import com.springmvc.util.JwtToken;

@Controller
@RequestMapping("/login")
public class LoginControl extends BaseController {

	@RequestMapping("/index")
	public String index() {
		return "token";
	}

	/**
	 * 获取token
	 * @param request
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/token")
	public String getToken(HttpServletRequest request, HttpServletResponse response) {
		String uName = (String) request.getParameter("uname");
		String uPwd = (String) request.getParameter("upwd");
		String token = "";
		System.out.println("账户：" + uName);
		System.out.println("密码:" + uPwd);
		if(uName.trim().equals("")||uPwd.trim().equals("")||!uName.equals("adminmvc")){
			return "用户名或者密码不正确";
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("name", uName);
		map.put("role", "admin");
		map.put("loginTime", DateUtil.formatDate(new Date()));
		try {
			token = JwtToken.createToken(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return token;
	}
	
	/**
	 * 验证token
	 * @param request
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/check")
	public String checkToken(HttpServletRequest request, HttpServletResponse response){
		String utoken = (String) request.getParameter("utoken");
		if(utoken.trim().equals(""))  return "验证错误";
		try {
			if(JwtToken.verifyToken(utoken)){
				return utoken;
			}			
		} catch (Exception e) {			
			e.printStackTrace();
		}
		return "验证错误";
	}

}
