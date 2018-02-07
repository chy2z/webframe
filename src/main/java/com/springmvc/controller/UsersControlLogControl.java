package com.springmvc.controller;

import com.springmvc.service.UsersControlLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
* @Title: UsersControlLogControl
* @Description:
* @author chy
* @date 2018/2/7 8:01 
*/
@Controller
@RequestMapping("/userControlLog")
public class UsersControlLogControl {

    @Autowired
    UsersControlLogService usersControlLogService;


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

        return usersControlLogService.toPaginationJson(pageNo,pageSize,where,orderBy);
    }

}