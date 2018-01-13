package com.springmvc.controller;

import com.springmvc.base.BaseControl;
import com.springmvc.service.AuditKindProcessStepService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
* @Title: AuditKindProcessStepControl
* @Description:  审核流程步骤接口
* @author chy
* @date 2017/12/29 11:43
*/
@Controller
@RequestMapping("/auditKindProcessStep")
public class AuditKindProcessStepControl extends BaseControl {

   @Autowired
   AuditKindProcessStepService auditKindProcessStepService;

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

        return auditKindProcessStepService.toPaginationJson(pageNo,pageSize,where,orderBy);
    }

}