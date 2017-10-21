package com.springmvc.controller;

import com.springmvc.base.BaseController;
import com.springmvc.config.SysConfig;
import com.springmvc.model.RequestResult;
import com.springmvc.model.Users;
import com.springmvc.model.UsersToken;
import com.springmvc.service.MenuItemService;
import com.springmvc.service.UsersService;
import com.springmvc.service.UsersTokenService;
import com.springmvc.util.DateUtil;
import com.springmvc.util.JwtTokenUtil;
import com.springmvc.util.SecurityUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
* @Title: LoginControl
* @Description: 登录接口
* @author chy
* @date 2017/10/18 11:53
*/
@Controller
@RequestMapping("/login")
public class LoginControl extends BaseController {

	@Autowired
	UsersService uService;

	@Autowired
	UsersTokenService utService;

	@Autowired
	MenuItemService miService;

	/**
	 * 测试
	 * @return
	 */
	@RequestMapping("/index")
	public String index() {
		return "token";
	}

	/**
	 * 获取token（测试）
	 * @param request
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/validateLogon")
	public RequestResult validateLogon(HttpServletRequest request, HttpServletResponse response) {
		RequestResult result=new RequestResult();
		String uName = (String) request.getParameter("uname");
		String uPwd = (String) request.getParameter("upwd");
		String token = "";
		//System.out.println("账户：" + uName);
		//System.out.println("密码:" + uPwd);
		if(uName.trim().equals("")||uPwd.trim().equals("")){
		    result.setFail("用户名或者密码为空");
		    return  result;
		}
		Users user=uService.getUsers(uName, SecurityUtil.MD5_16(uPwd));
		if(user==null){
			result.setFail("用户不存在");
			return result;
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", user.getId().toString());
		map.put("loginName", user.getLoginname());
		map.put("name", user.getName());
		map.put("role", user.getIsadmin());
		map.put("loginTime", DateUtil.formatDate(new Date()));
		try {
			token = JwtTokenUtil.createToken(map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		UsersToken ut=utService.getUsersToken(user.getId());

		if(ut==null){
			ut=new UsersToken();
		}

		ut.setUserid(user.getId());
		ut.setToken(token);
		ut.setMd5token(SecurityUtil.MD5_32(token));

		if(ut.getId()==null) {
			utService.insert(ut);
		}
		else{
			utService.update(ut);
		}

		result.setSucceed("登录成功",ut.getMd5token());

		return result;
	}

	/**
	 * 加载主界面
	 * @return
	 */
	@RequestMapping(value="/mainFrame/{jwt}",method = {RequestMethod.POST,RequestMethod.GET})
	public String mainFrame(@PathVariable("jwt") String jwt, Model model) {

		logger.info("{}:{}","jwt",jwt);

		UsersToken ut= utService.getUsersToken(jwt);

		if(ut==null){
			return "redirect:../../login.jsp";
		}
		else {

			Users u= uService.getUsers(ut.getUserid());

			//是否是超级管理员
			if(SysConfig.superAdmin.equals(u.getIsadmin())){
				model.addAttribute("menu",miService.toIviewMenuforJson(miService.getMenuAll()));
			}
			//不是超级管理员
			else{
				model.addAttribute("menu",miService.toIviewMenuforJson(miService.getMenuByRoleName(u.getIsadmin())));
			}

			model.addAttribute("jwt", jwt);
		}

		return "forward:../../main.jsp";
	}
}
