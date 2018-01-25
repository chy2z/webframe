package com.springmvc.controller;

import com.springmvc.base.BaseControl;
import com.springmvc.config.LanguageFactory;
import com.springmvc.model.AuditKindProcessStep;
import com.springmvc.model.RequestResult;
import com.springmvc.service.AuditKindProcessStepService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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

    /**
     * 更新状态
     * @param psid
     * @param enable
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/updateEnable",method = {RequestMethod.POST})
    public RequestResult updateEnable(String psid, String enable) {
        RequestResult result = new RequestResult();
        if (null == psid || null == enable) {
            result.setFail(LanguageFactory.getLanguages().DATA_LOSS);
        } else {
            AuditKindProcessStep p=new AuditKindProcessStep();
            p.setId(Integer.parseInt(psid));
            p.setEnable(enable);
            if(auditKindProcessStepService.update(p)){
                result.setSucceed(LanguageFactory.getLanguages().UPDATE_SUCESS, null);
            }
            else{
                result.setSucceed(LanguageFactory.getLanguages().UPDATE_FAIL, null);
            }
        }
        return result;
    }
}