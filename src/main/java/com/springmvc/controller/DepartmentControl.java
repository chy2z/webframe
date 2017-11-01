package com.springmvc.controller;

import com.springmvc.model.Department;
import com.springmvc.model.RequestResult;
import com.springmvc.service.DepartmentService;
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
* @Title: DepartmentControl
* @Description:
* @author chy
* @date 2017/10/31 16:30
*/
@Controller
@RequestMapping("/department")
public class DepartmentControl {

    @Autowired
    DepartmentService deService;

    @Autowired
    VSelectService vSeService;

    /**
     * 返回所有组织结构
     * @param request
     * @param response
     * @return
     */
    @ResponseBody
    @RequestMapping("/vselect/selectDepartment")
    public String vselect(HttpServletRequest request, HttpServletResponse response){
        String where=request.getParameter("where");
        return  vSeService.toIviewSelectForJson(vSeService.selectDepartment(where));
    }

    /**
     * 部门分页
     * @return
     */
    @ResponseBody
    @RequestMapping("/pagination")
    public String pagination(HttpServletRequest request, HttpServletResponse response) {

        int pageNo=Integer.parseInt(request.getParameter("pageNo"));

        int pageSize=Integer.parseInt(request.getParameter("pageSize"));

        String where=request.getParameter("where");

        String orderBy=request.getParameter("orderBy");

        return deService.toPaginationJson(pageNo,pageSize,where,orderBy);
    }

    /**
     * 部门插入
     * @param c
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/insert",method = {RequestMethod.POST})
    public RequestResult insert(@RequestBody Department c){
        RequestResult result=new RequestResult();
        if(null==c){
            result.setFail("没有数据");
        }
        else{
            if(deService.insert(c)){
                result.setSucceed("保存成功",null);
            }
            else{
                result.setFail("没有数据");
            }
        }

        return  result;
    }

    /**
     * 部门修改
     * @param c
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/update",method = {RequestMethod.POST})
    public RequestResult update(@RequestBody Department c){
        RequestResult result=new RequestResult();
        if(null==c){
            result.setFail("没有数据");
        }
        else{
            if(deService.update(c)){
                result.setSucceed("修改成功",null);
            }
            else{
                result.setFail("没有数据");
            }
        }

        return  result;
    }

    /**
     * 部门删除
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
            if(deService.delete(Integer.parseInt(id))){
                result.setSucceed("删除成功",null);
            }
            else{
                result.setFail("没有数据");
            }
        }
        return result;
    }
}
