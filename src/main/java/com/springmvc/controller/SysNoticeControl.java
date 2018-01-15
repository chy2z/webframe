package com.springmvc.controller;

import com.springmvc.base.BaseControl;
import com.springmvc.config.LanguageFactory;
import com.springmvc.model.RequestResult;
import com.springmvc.model.SysNotice;
import com.springmvc.model.Users;
import com.springmvc.model.UsersToken;
import com.springmvc.service.AuditWaitService;
import com.springmvc.service.SysNoticeService;
import com.springmvc.service.UsersService;
import com.springmvc.service.UsersTokenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;

/**
* @Title: SysNoticeControl
* @Description: 通知接口
* @author chy
* @date 2017/12/13 11:08
*/
@Controller
@RequestMapping("/sysNotice")
public class SysNoticeControl extends BaseControl {

   @Autowired
   SysNoticeService sysNoticeService;

   @Autowired
    AuditWaitService auditWaitService;

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
        model.addAttribute("jwt", jwt);
        if (page.equals("add")) {
            Users u= uService.getUsers(ut.getUserid());
            model.addAttribute("user", u);
            return "notice/sys_notice_add_page";
        }
        else if(page.equals("update")){
            String id = (String) request.getParameter("id");
            SysNotice sModel= sysNoticeService.getSysNotice(Integer.parseInt(id));
            model.addAttribute("sysNotice",sModel);
            Users u= uService.getUsers(ut.getUserid());
            model.addAttribute("user", u);
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
    public RequestResult insert(@RequestBody SysNotice c,HttpServletRequest request){
        RequestResult result=new RequestResult();
        if(null==c){
            result.setFail(LanguageFactory.getLanguages().DATA_LOSS);
        }
        else{

            c.setCreatetime(new Date());

            c.setAuditstate(auditWaitService.getAuditState(request));

            if(sysNoticeService.insert(c)){
                result.setSucceed(LanguageFactory.getLanguages().INSERT_SUCESS,null);
            }
            else{
                result.setFail(LanguageFactory.getLanguages().INSERT_FAIL);
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
    public RequestResult update(@RequestBody SysNotice c,HttpServletRequest request){
        RequestResult result=new RequestResult();
        if(null==c){
            result.setFail(LanguageFactory.getLanguages().DATA_LOSS);
        }
        else{

            c.setCreatetime(new Date());

            c.setAuditstate(auditWaitService.getAuditState(request));

            if(sysNoticeService.update(c)){
                result.setSucceed(LanguageFactory.getLanguages().UPDATE_SUCESS,c);
            }
            else{
                result.setFail(LanguageFactory.getLanguages().UPDATE_FAIL);
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
            if(sysNoticeService.delete(Integer.parseInt(id))){
                result.setSucceed(LanguageFactory.getLanguages().DELETE_SUCESS,null);
            }
            else{
                result.setFail(LanguageFactory.getLanguages().DELETE_FAIL);
            }
        }
        return result;
    }

}
