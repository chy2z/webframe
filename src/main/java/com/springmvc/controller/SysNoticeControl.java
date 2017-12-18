package com.springmvc.controller;

import com.springmvc.model.RequestResult;
import com.springmvc.model.SysNotice;
import com.springmvc.model.Users;
import com.springmvc.model.UsersToken;
import com.springmvc.service.SysNoticeService;
import com.springmvc.service.UsersService;
import com.springmvc.service.UsersTokenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
* @Title: SysNoticeControl
* @Description: 通知接口
* @author chy
* @date 2017/12/13 11:08
*/
@Controller
@RequestMapping("/sysNotice")
public class SysNoticeControl {

   @Autowired
   SysNoticeService sysNoticeService;

    @Autowired
    UsersService uService;

    @Autowired
    UsersTokenService utService;

    /**
     * 路径跳转
     * @return
     */
    @RequestMapping("/path/{page}")
    public String toPage(@PathVariable("page") String page,HttpServletRequest request,Model model) {
        String jwt = (String) request.getParameter("jwt");
        UsersToken ut= utService.getUsersToken(jwt);
        if (page.equals("add")) {
            Users u= uService.getUsers(ut.getUserid());
            model.addAttribute("user", u);
            return "notice/sys_notice_add_page";
        }
        else if(page.equals("update")){
            String id = (String) request.getParameter("id");
            SysNotice sModel= sysNoticeService.getSysNotice(Integer.parseInt(id));
            model.addAttribute("sysNotice",sModel);
            return "notice/sys_notice_update_page";
        }
        else if(page.equals("look")){
            String id = (String) request.getParameter("id");
            SysNotice sModel=sysNoticeService.getSysNotice(Integer.parseInt(id));
            model.addAttribute("sysNotice",sModel);
            return "notice/sys_notice_look_page";
        }
        else {
            return "notice/sys_notice_page";
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

        return sysNoticeService.toPaginationJson(pageNo,pageSize,where,orderBy);
    }

    /**
     * 插入
     * @param c
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/insert",method = {RequestMethod.POST})
    public RequestResult insert(@RequestBody SysNotice c){
        RequestResult result=new RequestResult();
        if(null==c){
            result.setFail("没有数据");
        }
        else{
            if(sysNoticeService.insert(c)){
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
    public RequestResult update(@RequestBody SysNotice c){
        RequestResult result=new RequestResult();
        if(null==c){
            result.setFail("没有数据");
        }
        else{
            if(sysNoticeService.update(c)){
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
            if(sysNoticeService.delete(Integer.parseInt(id))){
                result.setSucceed("删除成功",null);
            }
            else{
                result.setFail("没有数据");
            }
        }
        return result;
    }

}
