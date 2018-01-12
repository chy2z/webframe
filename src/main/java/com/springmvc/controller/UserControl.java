package com.springmvc.controller;

import com.springmvc.config.SysConfig;
import com.springmvc.model.RequestResult;
import com.springmvc.model.Users;
import com.springmvc.service.UsersService;
import com.springmvc.util.LanguageUtil;
import com.springmvc.util.SecurityUtil;
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
            result.setFail(LanguageUtil.DATA_LOSS);
        }
        else{
            //密码进行加密
            c.setPassword(SecurityUtil.MD5_16(c.getPassword()));

            if(uService.insert(c)){
                result.setSucceed(LanguageUtil.INSERT_SUCESS,null);
            }
            else{
                result.setFail(LanguageUtil.INSERT_FAIL);
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
            result.setFail(LanguageUtil.DATA_LOSS);
        }
        else{
            Users u= uService.getUsers(c.getId());
            if(!SysConfig.isSuperAdmin(u.getRoleid()==null?"":u.getRoleid().toString())) {

                //如果密码和原来的不一样，说明密码修改了
                if(!u.getPassword().equals(c.getPassword())){
                    c.setPassword(SecurityUtil.MD5_16(c.getPassword()));
                }

                if (uService.update(c)) {
                    result.setSucceed(LanguageUtil.UPDATE_SUCESS, null);
                } else {
                    result.setFail(LanguageUtil.UPDATE_FAIL);
                }
            }
            else{
                result.setFail(LanguageUtil.SUPER_ADMIN_FORBID_UPDAET);
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
            result.setFail(LanguageUtil.DATA_LOSS);
        }
        else{
            Users u= uService.getUsers(Integer.parseInt(id));
            if(!SysConfig.isSuperAdmin(u.getRoleid()==null?"":u.getRoleid().toString())) {
                if (uService.delete(Integer.parseInt(id))) {
                    result.setSucceed(LanguageUtil.DELETE_SUCESS, null);
                } else {
                    result.setFail(LanguageUtil.DELETE_FAIL);
                }
            }
            else{
                result.setFail(LanguageUtil.SUPER_ADMIN_FORBID_UPDAET);
            }
        }
        return result;
    }

}