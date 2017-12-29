package com.springmvc.controller;

import com.springmvc.mapper.AuditKindProcessMapper;
import com.springmvc.model.AuditKind;
import com.springmvc.model.AuditKindProcess;
import com.springmvc.model.RequestResult;
import com.springmvc.service.AuditKindProcessService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
* @Title: AuditProcessControl
* @Description: 审核流程接口
* @author chy
* @date 2017/12/29 11:42
*/
@Controller
@RequestMapping("/auditKindProcess")
public class AuditKindProcessControl {

    @Autowired
    AuditKindProcessService auditKindProcessService;

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

        return auditKindProcessService.toPaginationJson(pageNo,pageSize,where,orderBy);
    }

    /**
     * 插入
     * @param c
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/insert",method = {RequestMethod.POST})
    public RequestResult insert(@RequestBody AuditKindProcess c){
        RequestResult result=new RequestResult();
        if(null==c){
            result.setFail("没有数据");
        }
        else{
            if(auditKindProcessService.insert(c)){
                result.setSucceed("保存成功",null);
            }
            else{
                result.setFail("没有数据");
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
    public RequestResult update(@RequestBody AuditKindProcess c){
        RequestResult result=new RequestResult();
        if(null==c){
            result.setFail("没有数据");
        }
        else{
            if(auditKindProcessService.update(c)){
                result.setSucceed("修改成功",null);
            }
            else{
                result.setFail("没有数据");
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
            result.setFail("没有数据");
        }
        else{
            if(auditKindProcessService.delete(Integer.parseInt(id))){
                result.setSucceed("删除成功",null);
            }
            else{
                result.setFail("没有数据");
            }
        }
        return result;
    }

}