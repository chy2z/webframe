package com.springmvc.controller;

import com.springmvc.model.Corporation;
import com.springmvc.model.RequestResult;
import com.springmvc.service.CorporationService;
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
* @Title: CorporationControl
* @Description: 组织结构接口
* @author chy
* @date 2017/10/26 15:31
*/
@Controller
@RequestMapping("/corporation")
public class CorporationControl {

    @Autowired
    CorporationService cService;

    @Autowired
    VSelectService vSeService;

    /**
     * 返回所有组织结构
     * @param request
     * @param response
     * @return
     */
    @ResponseBody
    @RequestMapping("/vselect/selectCorporation")
    public String vselect(HttpServletRequest request, HttpServletResponse response){
        String where=request.getParameter("where");
        return  vSeService.toIviewSelectForJson(vSeService.selectCorporation(where));
    }

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

        return cService.toPaginationJson(pageNo,pageSize,where,orderBy);
    }

    /**
     * 插入机构组织
     * @param c
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/insert",method = {RequestMethod.POST})
    public RequestResult insert(@RequestBody Corporation c){
         RequestResult result=new RequestResult();
         if(null==c){
             result.setFail("没有数据");
         }
         else{
             if(cService.insert(c)){
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
    public RequestResult update(@RequestBody Corporation c){
        RequestResult result=new RequestResult();
        if(null==c){
            result.setFail("没有数据");
        }
        else{
            if(cService.update(c)){
                result.setSucceed("修改成功",null);
            }
            else{
                result.setFail("没有数据");
            }
        }

        return  result;
    }

    /**
     * 删除组织结构
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
            if(cService.delete(Integer.parseInt(id))){
                result.setSucceed("删除成功",null);
            }
            else{
                result.setFail("没有数据");
            }
        }
        return result;
    }
}
