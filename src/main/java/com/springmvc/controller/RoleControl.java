package com.springmvc.controller;

import com.springmvc.model.RequestResult;
import com.springmvc.model.Role;
import com.springmvc.service.RoleService;
import com.springmvc.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
* @Title: RoleControl
* @Description: 角色接口
* @author chy
* @date 2017/10/30 15:47
*/
@Controller
@RequestMapping("/role")
public class RoleControl {

    @Autowired
    RoleService rService;

    @Autowired
    UsersService uService;

    /**
     * 组织结构分页
     * @return
     */
    @ResponseBody
    @RequestMapping("/pagination")
    public String pagination(HttpServletRequest request, HttpServletResponse response) {

        int pageNo=Integer.parseInt(request.getParameter("pageNo"));

        int pageSize=Integer.parseInt(request.getParameter("pageSize"));

        String where=request.getParameter("where");

        String orderBy=request.getParameter("orderBy");

        return rService.toPaginationJson(pageNo,pageSize,where,orderBy);
    }

    /**
     * 插入机构组织
     * @param c
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/insert",method = {RequestMethod.POST})
    public RequestResult insert(@RequestBody Role c){
        RequestResult result=new RequestResult();
        if(null==c){
            result.setFail("没有数据");
        }
        else{
            if(rService.insert(c)){
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
    public RequestResult update(@RequestBody Role c){
        RequestResult result=new RequestResult();
        if(null==c){
            result.setFail("没有数据");
        }
        else{
            if(rService.update(c)){
                result.setSucceed("修改成功",null);
            }
            else{
                result.setFail("没有数据");
            }
        }

        return  result;
    }

    @ResponseBody
    @RequestMapping(value = "/delete",method = {RequestMethod.POST})
    public RequestResult delete(String id){
        RequestResult result=new RequestResult();
        if(id==null){
            result.setFail("没有数据");
        }
        else{
            if(uService.getCountByRole(Integer.parseInt(id))<=0) {
                if (rService.delete(Integer.parseInt(id))) {
                    result.setSucceed("删除成功", null);
                } else {
                    result.setFail("没有数据");
                }
            }
            else{
                result.setFail("此角色有用户在使用,不能删除");
            }
        }
        return result;
    }

}
