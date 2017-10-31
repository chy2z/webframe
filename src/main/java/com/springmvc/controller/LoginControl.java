package com.springmvc.controller;

import com.springmvc.base.BaseController;
import com.springmvc.config.SysConfig;
import com.springmvc.model.RequestResult;
import com.springmvc.model.Role;
import com.springmvc.model.Users;
import com.springmvc.model.UsersToken;
import com.springmvc.service.*;
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

	@Autowired
	RoleService roleService;

	@Autowired
	DepartmentService departmentService;

	/**
	 * 测试
	 * @return
	 */
	@RequestMapping("/index")
	public String index() {
		return "test";
	}

	/**
	 * 获取token
	 * @param request
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/validateLogon",method = {RequestMethod.POST})
	public RequestResult validateLogon(HttpServletRequest request, HttpServletResponse response) {
		RequestResult result=new RequestResult();
		String uName = (String) request.getParameter("uname");
		String uPwd = (String) request.getParameter("upwd");
		String token = "";
		//System.out.println("账户：" + uName);
		//System.out.println("密码:" + uPwd);
		if(uName.trim().equals("")||uPwd.trim().equals("")){
		    result.setFail("用户名或密码为空");
		    return  result;
		}
		Users user=uService.getUsers(uName, SecurityUtil.MD5_16(uPwd));
		if(user==null){
			result.setFail("用户名或密码不正确");
			return result;
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", user.getId().toString());
		map.put("loginName", user.getLoginname());
		map.put("name", user.getName());
		map.put("depart", user.getDepart().toString());
		map.put("corporationId", user.getCorporationid().toString());
		map.put("role", user.getRoleid().toString());
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
		ut.setLogintime(new Date());

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

			Role role=roleService.getRole(u.getRoleid());

			//是否是超级管理员
			if(SysConfig.superAdmin.equals(u.getRoleid().toString())){
				model.addAttribute("menu",miService.toIviewMenuForJson(miService.getMenuAll()));
			}
			//不是超级管理员
			else{
				model.addAttribute("menu",miService.toIviewMenuForJson(miService.getMenuByRole(role.getId().toString())));
			}

			model.addAttribute("jwt", jwt);

			model.addAttribute("user", u);

			model.addAttribute("role",role==null?"超级管理员":role.getName());

			model.addAttribute("loginTime",DateUtil.formatDate(ut.getLogintime()));

			model.addAttribute("depart",departmentService.getDepart(u.getDepart()).getName());
		}

		return "forward:../../main.jsp";
	}

	/**
	 * 加载菜单页面
	 * @param jwt
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/menu/{jwt}",method = {RequestMethod.POST,RequestMethod.GET})
	public String menu(@PathVariable("jwt") String jwt, HttpServletRequest request,Model model) {

		String menu = (String) request.getParameter("menu"); //菜单url

		String mid = (String) request.getParameter("mid");  //菜单id

		logger.info("{}:{}","menu",menu);

		logger.info("{}:{}","mid",mid);

		mid=mid.replace("m","");

		UsersToken ut= utService.getUsersToken(jwt);

		if(ut==null||mid==null){
			return "redirect:../../login.jsp";
		}
		else
		{
			//获取用户按钮权限
			Users u= uService.getUsers(ut.getUserid());
			Role role=roleService.getRole(u.getRoleid());

			if(SysConfig.superAdmin.equals(u.getRoleid().toString())){
				model.addAttribute("rightBut",miService.toIviewButForJson(miService.getButAll(mid)));
			}
			else{
                model.addAttribute("rightBut",miService.toIviewButForJson(miService.getBuByRole(role.getId().toString(),mid)));
			}

			model.addAttribute("jwt", jwt);

			model.addAttribute("depart", u.getDepart().toString());

			model.addAttribute("corporationId", u.getCorporationid().toString());
		}

		return menu;
	}

	/**
	 * 解锁
	 * @param jwt
	 * @param request
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/unLock/{jwt}",method = {RequestMethod.POST})
	public RequestResult unLock(@PathVariable("jwt") String jwt,HttpServletRequest request,HttpServletResponse response){

		String pwd = (String) request.getParameter("pwd");

		UsersToken ut= utService.getUsersToken(jwt);

		RequestResult result=new RequestResult();

		if(pwd==null){
			result.setFail("请输入密码！");
		}
		else if(jwt==null||ut==null) {
			result.setFail("无权限！");
		}
		else{
			if(SecurityUtil.MD5_16(pwd).equals(uService.getUsers(ut.getUserid()).getPassword())){
				result.setSucceed("解锁成功",null);
			}
			else{
				result.setFail("密码不正确！");
			}
		}

		return result;
	}

	/**
	 * 修改密码
	 * @param jwt
	 * @param request
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/editPwd/{jwt}",method = {RequestMethod.POST})
	public RequestResult editPwd(@PathVariable("jwt") String jwt,HttpServletRequest request,HttpServletResponse response){
		String oldPwd = (String) request.getParameter("oldPwd");
		String newPwd = (String) request.getParameter("newPwd");
		UsersToken ut= utService.getUsersToken(jwt);
		RequestResult result=new RequestResult();
		if(oldPwd==null||newPwd==null){
			result.setFail("请输入密码！");
		}
		else if(jwt==null||ut==null) {
			result.setFail("无权限！");
		}
		else{

			Users user=uService.getUsers(ut.getUserid());

			if(SecurityUtil.MD5_16(oldPwd).equals(user.getPassword())){

				user.setPassword(SecurityUtil.MD5_16(newPwd));

				uService.updateUsers(user);

				result.setSucceed("修改密码成功",null);
			}
			else{
				result.setFail("旧的密码不正确！");
			}
		}
		return  result;
	}
}