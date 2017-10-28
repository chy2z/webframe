package com.springmvc.controller;

import com.springmvc.service.DataDictionaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
* @Title: DataDictionaryControl
* @Description: 数据字典
* @author chy
* @date 2017/10/28 17:16
*/
@Controller
@RequestMapping("/dataDictionary")
public class DataDictionaryControl {

    @Autowired
    DataDictionaryService ddService;

    /**
     * 组织结构分页(字典关键字)
     * @return
     */
    @ResponseBody
    @RequestMapping("/pagination/parent")
    public String paginationParent(HttpServletRequest request, HttpServletResponse response) {

        int pageNo=Integer.parseInt(request.getParameter("pageNo"));

        int pageSize=Integer.parseInt(request.getParameter("pageSize"));

        String where=request.getParameter("where");

        String orderBy=request.getParameter("orderBy");

        return ddService.toParentPaginationJson(pageNo,pageSize,where,orderBy);
    }

    /**
     * 组织结构分页(字典属性)
     * @return
     */
    @ResponseBody
    @RequestMapping("/pagination/child")
    public String paginationChild(HttpServletRequest request, HttpServletResponse response) {

        int pageNo=Integer.parseInt(request.getParameter("pageNo"));

        int pageSize=Integer.parseInt(request.getParameter("pageSize"));

        String where=request.getParameter("where");

        String orderBy=request.getParameter("orderBy");

        return ddService.toChildPaginationJson(pageNo,pageSize,where,orderBy);
    }
}
