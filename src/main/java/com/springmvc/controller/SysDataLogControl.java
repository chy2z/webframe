package com.springmvc.controller;

import com.springmvc.base.BaseControl;
import com.springmvc.service.SysDataLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
* @Title: SysDataLogControl
* @Description: 系统数据日志 （mybatis）
* @author chy
* @date 2018/2/8 9:42
*/
@Controller
@RequestMapping("/sysDataLogControl")
public class SysDataLogControl extends BaseControl {

    @Autowired
    SysDataLogService sysDataLogService;

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

        return sysDataLogService.toPaginationJson(pageNo,pageSize,where,orderBy);
    }
}
