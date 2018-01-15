package com.springmvc.controller;

import com.springmvc.config.LanguageFactory;
import com.springmvc.model.RequestResult;
import com.springmvc.service.AuditWaitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
* @Title: AuditWaitControl
* @Description:  审核中
* @author chy
* @date 2018/1/13 16:32
*/
@Controller
@RequestMapping("/auditWait")
public class AuditWaitControl {

    @Autowired
    AuditWaitService auditWaitService;

    /**
     * 送审
     * @param operation
     * @param useId
     * @param departId
     * @param auditState
     * @param tName
     * @param tKey
     * @param tValue
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/sendAudit",method = {RequestMethod.POST})
    public RequestResult sendAudit(String operation,
                                    String useId,
                                    String departId,
                                    String auditState,
                                    String tName,
                                    String tKey,
                                    String tValue ){

        RequestResult result=new RequestResult();

        if(auditState==null||tName==null||tKey==null||tValue==null){
            result.setFail(LanguageFactory.getLanguages().DATA_LOSS);
        }
        else{
            // 是否允许送审
            if(auditWaitService.allowSendAudit(operation,departId,auditState,tName,tKey,tValue)){
                result.setSucceed(LanguageFactory.getLanguages().SUCCESS,null);
            }
            else{
                result.setFail(LanguageFactory.getLanguages().NOY_ALLOW_AUDIT);
            }
        }

        return result;
    }

    /**
     * 是否允许编辑和删除
     * @param request
     * @param auditState
     * @param tName
     * @param tKey
     * @param tValue
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/allowEditAndDel",method = {RequestMethod.POST})
    public RequestResult allowEditAndDel(HttpServletRequest request,
                                         String auditState,
                                         String tName,
                                         String tKey,
                                         String tValue ){
        RequestResult result=new RequestResult();
        if(auditState==null||tName==null||tKey==null||tValue==null){
            result.setFail(LanguageFactory.getLanguages().DATA_LOSS);
        }
        else{
            result.setSucceed(LanguageFactory.getLanguages().SUCCESS,auditWaitService.allowEditAndDel(auditState,tName,tKey,tValue));
        }
        return result;
    }

    /**
     * 是否可以送审
     * @param request
     * @param operation
     * @param departId
     * @param auditState
     * @param tName
     * @param tKey
     * @param tValue
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/allowSendAudit",method = {RequestMethod.POST})
    public RequestResult allowSendAudit(HttpServletRequest request,
                                         String operation,
                                         String departId,
                                         String auditState,
                                         String tName,
                                         String tKey,
                                         String tValue ){
        RequestResult result=new RequestResult();
        if(auditState==null||tName==null||tKey==null||tValue==null){
            result.setFail(LanguageFactory.getLanguages().DATA_LOSS);
        }
        else{
            result.setSucceed(LanguageFactory.getLanguages().SUCCESS,auditWaitService.allowSendAudit(operation,departId,auditState,tName,tKey,tValue));
        }
        return result;
    }



}