package com.springmvc.controller;


import com.springmvc.base.BaseControl;
import com.springmvc.config.LanguageFactory;
import com.springmvc.config.SysConfig;
import com.springmvc.enums.UserStateType;
import com.springmvc.model.*;
import com.springmvc.service.*;
import com.springmvc.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
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
public class LoginControl extends BaseControl {

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

	@Autowired
	UsersLoginLogService usersLoginLogService;

	@Autowired
	DataDictionaryService dataDictionaryService;

	/**
	 * 测试
	 * @return
	 */
	@RequestMapping("/test/{path}")
	public String test(@PathVariable("path") String path) {
		return path;
	}

	/**
	 * 测试异常捕获
	 * @return
	 */
	@RequestMapping("/test/exception")
	public String exception() throws Exception {
		boolean flag=true;
		if(flag) {
			//throw new MyException("自定义异常");

			throw new IOException("自定义IO异常");
		}
		return "异常";
	}


	/**
	 * 首页
	 * @return
	 */
	@RequestMapping("/index/{jwt}")
	public String index(@PathVariable("jwt") String jwt, Model model) {
		UsersToken ut = utService.getUsersToken(jwt);
		if (ut == null) {
			return "redirect:../../login.jsp";
		} else {
			Users u = uService.getUsers(ut.getUserid());
			Role role = roleService.getRole(u.getRoleid());

			UsersLoginLog currentLog = usersLoginLogService.selectLast(ut.getUserid());
			UsersLoginLog preLog = usersLoginLogService.getUsersLoginLog(currentLog.getLastid());

			model.addAttribute("loginDate", DateUtil.formatDate(currentLog.getCreatedate()));
			model.addAttribute("geo", StringUtil.emptyOrString(currentLog.getProvince()) + StringUtil.emptyOrString(currentLog.getCity()));

			if (preLog != null) {
				model.addAttribute("loginDateLast", DateUtil.formatDate(preLog.getCreatedate()));
				model.addAttribute("geoLast", StringUtil.emptyOrString(preLog.getProvince()) + StringUtil.emptyOrString(preLog.getCity()));
			} else {
				model.addAttribute("loginDateLast", "--");
				model.addAttribute("geoLast", "--");
			}

			// 超级管理员没有角色
			u.setRoleName(role == null ? SysConfig.superAdminRole : role.getName());
			// 获取部门
			u.setDepartName(departmentService.getDepart(u.getDepartid()).getName());

			model.addAttribute("user", u);

			return "forward:../../index.jsp";
		}
	}

	/**
	 * 查询ip信息
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/queryIp",method = {RequestMethod.GET})
	public RequestResult queryIp(String ip,HttpServletRequest request, HttpServletResponse response) {
		RequestResult result=new RequestResult();
		try {
			String info=ClientUtil.queryIp(ip);
			if(info!=null){
				result.setSucceed(LanguageFactory.getLanguages().SUCCESS,info);
			}
			else{
				result.setFail(LanguageFactory.getLanguages().GET_DATA_FAIL);
			}
		}
		catch (Exception ex){
			result.setFail(LanguageFactory.getLanguages().EXCEPTER);
		}

		return result;
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
		String uName =  request.getParameter("uname");
		String uPwd =  request.getParameter("upwd");
		String ip= request.getParameter("ip");
		String country= request.getParameter("country");
		String region= request.getParameter("region");
		String city= request.getParameter("city");
		String token = "";
		if(uName.trim().equals("")||uPwd.trim().equals("")){
		    result.setFail(LanguageFactory.getLanguages().ERROR_NAME_PASSWORD);
		    return  result;
		}

		Users user=uService.getUsers(uName, SecurityUtil.MD5_16(uPwd));
		if(user==null){
			result.setFail(LanguageFactory.getLanguages().ERROR_NAME_PASSWORD);
			return result;
		}

		// 没有角色用户未授权
		if(user.getRoleid()==0){
			result.setFail(LanguageFactory.getLanguages().UN_ANTHORIZED);
			return result;
		}

        // 离职的用户未授权
		if(user.getState().equals(UserStateType.Quit.getName())){
			result.setFail(LanguageFactory.getLanguages().UN_ANTHORIZED);
			return result;
		}

		Map<String, String> map = new HashMap<String, String>();
		map.put("uid", user.getId().toString());
		map.put("loginName", user.getLoginname());
		map.put("name", user.getName());
		map.put("departid", user.getDepartid().toString());
		map.put("corporationid", user.getCorporationid().toString());
		map.put("roleid", user.getRoleid().toString());
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

        usersLoginLogService.saveLogin(user.getId(),ut.getMd5token(),ip,country,region,city);

		result.setSucceed(LanguageFactory.getLanguages().SUCCESS_LOGIN,ut.getMd5token());

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

			Users u = uService.getUsers(ut.getUserid());

			Role role = roleService.getRole(u.getRoleid());

			//是否是超级管理员
			if (SysConfig.isSuperAdmin(u.getRoleid().toString())) {
				model.addAttribute("menu", miService.toIviewMenuForJson(miService.getMenuAll()));
			}
			//不是超级管理员
			else {
				model.addAttribute("menu", miService.toIviewMenuForJson(miService.getMenuByRole(role.getId().toString())));
			}

			model.addAttribute("sysTitle",dataDictionaryService.getModel("系统名称").getDvalue());

			model.addAttribute("version", SysConfig.version);

			model.addAttribute("jwt", jwt);

			model.addAttribute("user", u);

			model.addAttribute("role", role == null ? SysConfig.superAdminRole : role.getName());

			model.addAttribute("loginTime", DateUtil.formatDate(ut.getLogintime()));

			model.addAttribute("depart", departmentService.getDepart(u.getDepartid()).getName());
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
        //菜单url
		String menu =  request.getParameter("menu");
		//菜单id
		String mid =  request.getParameter("mid");

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

			if(SysConfig.isSuperAdmin(u.getRoleid().toString())){
				model.addAttribute("nomanage",false);
				model.addAttribute("rightBut",miService.toIviewButForJson(miService.getButAll(mid)));
				model.addAttribute("rightRecord",miService.recordPermissions(miService.getButAll(mid)));
			}
			else{
				model.addAttribute("nomanage", true);
                model.addAttribute("rightBut",miService.toIviewButForJson(miService.getButByRole(role.getId().toString(),mid)));
				model.addAttribute("rightRecord",miService.recordPermissions(miService.getButByRole(role.getId().toString(),mid)));
			}

			model.addAttribute("version", SysConfig.version);

			model.addAttribute("jwt", jwt);

			model.addAttribute("useId", u.getId());

			model.addAttribute("departId", u.getDepartid().toString());

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
			result.setFail(LanguageFactory.getLanguages().UN_PASSWORD);
		}
		else if(jwt==null||ut==null) {
			result.setFail(LanguageFactory.getLanguages().UN_ANTHORIZED);
		}
		else{
			if(SecurityUtil.MD5_16(pwd).equals(uService.getUsers(ut.getUserid()).getPassword())){
				result.setSucceed(LanguageFactory.getLanguages().SUCCESS_UNLOCK,null);
			}
			else{
				result.setFail(LanguageFactory.getLanguages().ERROR_PASSWORD);
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
			result.setFail(LanguageFactory.getLanguages().UN_PASSWORD);
		}
		else if(jwt==null||ut==null) {
			result.setFail(LanguageFactory.getLanguages().UN_ANTHORIZED);
		}
		else{

			Users user=uService.getUsers(ut.getUserid());

			if(SecurityUtil.MD5_16(oldPwd).equals(user.getPassword())){

				user.setPassword(SecurityUtil.MD5_16(newPwd));

				uService.update(user);

				result.setSucceed(LanguageFactory.getLanguages().SUCCESS_UPDATE_PASSWORD,null);
			}
			else{
				result.setFail(LanguageFactory.getLanguages().ERROR_OLD_PASSWORD);
			}
		}
		return  result;
	}
}