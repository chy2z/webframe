package com.springmvc.controller;

import com.springmvc.base.BaseControl;
import com.springmvc.config.LanguageFactory;
import com.springmvc.model.AuditKind;
import com.springmvc.model.RequestResult;
import com.springmvc.service.AuditKindService;
import com.springmvc.service.VSelectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
* @Title: AuditKindControl
* @Description: 审核类型接口
* @author chy
* @date 2017/12/28 15:44
*/
@Controller
@RequestMapping("/auditKind")
public class AuditKindControl extends BaseControl {

    @Autowired
    AuditKindService auditKindService;

    @Autowired
    VSelectService vSeService;

    /**
     * 返回所有审核类型
     * @param request
     * @param response
     * @return
     */
    @ResponseBody
    @RequestMapping("/vselect/selectAuditKind")
    public String vselect(HttpServletRequest request, HttpServletResponse response){
        String where=request.getParameter("where");
        return  vSeService.toIviewSelectForJson(vSeService.selectAuditKind(where));
    }

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

        return auditKindService.toPaginationJson(pageNo,pageSize,where,orderBy);
    }

    /**
     * 插入
     * @param c
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/insert",method = {RequestMethod.POST})
    public RequestResult insert(@RequestBody AuditKind c){
        RequestResult result=new RequestResult();
        if(null==c){
            result.setFail(LanguageFactory.getLanguages().DATA_LOSS);
        }
        else{
            if(!auditKindService.operationRepeat(c.getOperation().trim(),c.getId().toString())) {
                if (auditKindService.insert(c)) {
                    result.setSucceed(LanguageFactory.getLanguages().INSERT_SUCESS, null);
                } else {
                    result.setFail(LanguageFactory.getLanguages().INSERT_FAIL);
                }
            }
            else{
                result.setFail(LanguageFactory.getLanguages().AUDIT_OPERATION_REPEAT);
            }
        }

        return  result;
    }

    /**
     * 修改
     * @param c
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/update",method = {RequestMethod.POST})
    public RequestResult update(@RequestBody AuditKind c){
        RequestResult result=new RequestResult();
        if(null==c){
            result.setFail(LanguageFactory.getLanguages().DATA_LOSS);
        }
        else{
            if(!auditKindService.operationRepeat(c.getOperation().trim(),c.getId().toString())) {
                if (auditKindService.update(c)) {
                    result.setSucceed(LanguageFactory.getLanguages().UPDATE_SUCESS, null);
                } else {
                    result.setFail(LanguageFactory.getLanguages().UPDATE_FAIL);
                }
            }
            else{
                result.setFail(LanguageFactory.getLanguages().AUDIT_OPERATION_REPEAT);
            }
        }

        return  result;
    }

    /**
     * 删除
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/delete",method = {RequestMethod.POST})
    public RequestResult delete(String id){
        RequestResult result=new RequestResult();
        if(id==null){
            result.setFail(LanguageFactory.getLanguages().DATA_LOSS);
        }
        else{
            if(auditKindService.delete(Integer.parseInt(id))){
                result.setSucceed(LanguageFactory.getLanguages().DELETE_SUCESS,null);
            }
            else{
                result.setFail(LanguageFactory.getLanguages().DELETE_FAIL);
            }
        }
        return result;
    }

}
