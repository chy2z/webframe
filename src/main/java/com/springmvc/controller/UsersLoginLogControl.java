package com.springmvc.controller;

import com.springmvc.base.BaseControl;
import com.springmvc.service.UsersLoginLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
* @Title: UsersLoginLogControl
* @Description:
* @author chy
* @date 2018/2/1 10:56
*/
@Controller
@RequestMapping("/userLoginLog")
public class UsersLoginLogControl extends BaseControl {

    @Autowired
    UsersLoginLogService usersLoginLogService;

    /**
     * 分页
     * @return
     */
    @ResponseBody
    @RequestMapping("/pagination")
    public String pagination(HttpServletRequest request, HttpServletResponse response) {

        int pageNo=Integer.parseInt(request.getParameter("pageNo"));

        int pageSize=Integer.parseInt(request.getParameter("pageSize"));

        String where=request.getParameter("where");

        String orderBy=request.getParameter("orderBy");

        return usersLoginLogService.toPaginationJson(pageNo,pageSize,where,orderBy);
    }

}