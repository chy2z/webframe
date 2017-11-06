package com.springmvc.controller;

import com.springmvc.base.BaseController;
import com.springmvc.service.MenuItemService;
import com.springmvc.service.RoleService;
import com.springmvc.service.UsersService;
import com.springmvc.service.UsersTokenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
* @Title: RightsControl
* @Description:  权限分配
* @author chy
* @date 2017/11/6 11:03 
*/
@Controller
@RequestMapping("/right")
public class RightsControl  extends BaseController {

    @Autowired
    UsersService uService;

    @Autowired
    UsersTokenService utService;

    @Autowired
    MenuItemService miService;

    @Autowired
    RoleService roleService;

    /**
     * 获取全部菜单
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/all",method = {RequestMethod.POST,RequestMethod.GET})
    public String all(HttpServletRequest request, HttpServletResponse response) {

        String roleId=request.getParameter("roleId");

        return  miService.toIviewTreeForJson(miService.getRigthsAll(roleId));
    }

}