package com.springmvc.controller;

import com.springmvc.model.AuditKind;
import com.springmvc.model.RequestResult;
import com.springmvc.service.AuditKindService;
import com.springmvc.util.LanguageUtil;
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
public class AuditKindControl {

    @Autowired
    AuditKindService auditKindService;

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
            result.setFail(LanguageUtil.DATA_LOSS);
        }
        else{
            if(auditKindService.insert(c)){
                result.setSucceed(LanguageUtil.INSERT_SUCESS,null);
            }
            else{
                result.setFail(LanguageUtil.INSERT_FAIL);
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
            result.setFail(LanguageUtil.DATA_LOSS);
        }
        else{
            if(auditKindService.update(c)){
                result.setSucceed(LanguageUtil.UPDATE_SUCESS,null);
            }
            else{
                result.setFail(LanguageUtil.UPDATE_FAIL);
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
            result.setFail(LanguageUtil.DATA_LOSS);
        }
        else{
            if(auditKindService.delete(Integer.parseInt(id))){
                result.setSucceed(LanguageUtil.DELETE_SUCESS,null);
            }
            else{
                result.setFail(LanguageUtil.DELETE_FAIL);
            }
        }
        return result;
    }

}
