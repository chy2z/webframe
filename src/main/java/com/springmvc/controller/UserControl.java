package com.springmvc.controller;

import com.springmvc.model.RequestResult;
import com.springmvc.model.Users;
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
* @Title: UserControl
* @Description: 用户接口
* @author chy
* @date 2017/10/30 17:10
*/
@Controller
@RequestMapping("/users")
public class UserControl {

    @Autowired
    UsersService uService;

    /**
     * 用户分页
     * @return
     */
    @ResponseBody
    @RequestMapping("/pagination")
    public String pagination(HttpServletRequest request, HttpServletResponse response) {

        int pageNo=Integer.parseInt(request.getParameter("pageNo"));

        int pageSize=Integer.parseInt(request.getParameter("pageSize"));

        String where=request.getParameter("where");

        String orderBy=request.getParameter("orderBy");

        return uService.toPaginationJson(pageNo,pageSize,where,orderBy);
    }

    /**
     * 用户插入
     * @param c
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/insert",method = {RequestMethod.POST})
    public RequestResult insert(@RequestBody Users c){
        RequestResult result=new RequestResult();
        if(null==c){
            result.setFail("没有数据");
        }
        else{
            if(uService.insert(c)){
                result.setSucceed("保存成功",null);
            }
            else{
                result.setFail("没有数据");
            }
        }

        return  result;
    }

    /**
     * 用户修改
     * @param c
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/update",method = {RequestMethod.POST})
    public RequestResult update(@RequestBody Users c){
        RequestResult result=new RequestResult();
        if(null==c){
            result.setFail("没有数据");
        }
        else{
            if(uService.update(c)){
                result.setSucceed("修改成功",null);
            }
            else{
                result.setFail("没有数据");
            }
        }

        return  result;
    }

    /**
     * 用户删除
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
            if(uService.delete(Integer.parseInt(id))){
                result.setSucceed("删除成功",null);
            }
            else{
                result.setFail("没有数据");
            }
        }
        return result;
    }

}