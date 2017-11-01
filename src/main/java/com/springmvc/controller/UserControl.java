package com.springmvc.controller;

import com.springmvc.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
* @Title: UserControl
* @Description: 用户接口
* @author chy
* @date 2017/10/30 17:10
*/
@Controller
@RequestMapping("/users")
public class UserControl {

    @Autowired
    UsersService uService;

    /**
     * 用户分页
     * @return
     */
    @ResponseBody
    @RequestMapping("/pagination")
    public String pagination(HttpServletRequest request, HttpServletResponse response) {

        int pageNo=Integer.parseInt(request.getParameter("pageNo"));

        int pageSize=Integer.parseInt(request.getParameter("pageSize"));

        String where=request.getParameter("where");

        String orderBy=request.getParameter("orderBy");

        return uService.toPaginationJson(pageNo,pageSize,where,orderBy);
    }



}
