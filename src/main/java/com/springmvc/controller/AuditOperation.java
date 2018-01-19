package com.springmvc.controller;

import com.springmvc.service.VSelectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/auditOperation")
public class AuditOperation {

    @Autowired
    VSelectService vSeService;

    /**
     * 返回所有审核业务
     * @param request
     * @param response
     * @return
     */
    @ResponseBody
    @RequestMapping("/vselect/selectAuditOperation")
    public String vselect(HttpServletRequest request, HttpServletResponse response){
        String where=request.getParameter("where");
        return  vSeService.toIviewSelectForJson(vSeService.selectAuditOperation(where));
    }
}
