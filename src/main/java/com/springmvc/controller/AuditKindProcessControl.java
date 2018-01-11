package com.springmvc.controller;

import com.springmvc.model.*;
import com.springmvc.service.AuditKindProcessService;
import com.springmvc.service.AuditKindProcessStepService;
import com.springmvc.service.UsersService;
import com.springmvc.service.UsersTokenService;
import com.springmvc.util.JsonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;


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

    @Autowired
    AuditKindProcessStepService auditKindProcessStepService;

    @Autowired
    UsersService uService;

    @Autowired
    UsersTokenService utService;

    /**
     * 路径跳转
     * @return
     */
    @RequestMapping("/path/{page}")
    public String toPage(@PathVariable("page") String page, HttpServletRequest request, Model model) {
        String jwt = (String) request.getParameter("jwt");
        UsersToken ut= utService.getUsersToken(jwt);
        if (page.equals("add")) {
            Users u= uService.getUsers(ut.getUserid());
            model.addAttribute("user", u);
            return "auditing/audit_kind_process_add_page";
        }
        else if(page.equals("update")){
            String id = (String) request.getParameter("id");
            AuditKindProcess sModel= auditKindProcessService.getAuditKindProcess(Integer.parseInt(id));
            model.addAttribute("kindProcess",sModel);
            return "auditing/audit_kind_process_update_page";
        }
        else {
            return "error";
        }
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

        return auditKindProcessService.toPaginationJson(pageNo,pageSize,where,orderBy);
    }

    /**
     * 插入流程
     * @param process
     * @param steps
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/insert",method = {RequestMethod.POST})
    public RequestResult insert(String process , String steps){
        RequestResult result=new RequestResult();
        if(null==process||null==steps) {
            result.setFail("没有数据");
        }
        else{
            AuditKindProcess c= JsonUtil.jsonToBean(process,AuditKindProcess.class);

            List<AuditKindProcessStep> stepList=(List<AuditKindProcessStep>)JsonUtil.jsonToListBean(steps,AuditKindProcessStep.class);

            if(auditKindProcessService.insertStep(c,stepList)){
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