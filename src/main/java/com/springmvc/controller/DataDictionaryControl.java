package com.springmvc.controller;

import com.springmvc.base.BaseControl;
import com.springmvc.config.LanguageFactory;
import com.springmvc.model.DataDictionary;
import com.springmvc.model.RequestResult;
import com.springmvc.service.DataDictionaryService;
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
* @Title: DataDictionaryControl
* @Description: 数据字典
* @author chy
* @date 2017/10/28 17:16
*/
@Controller
@RequestMapping("/dataDictionary")
public class DataDictionaryControl extends BaseControl {

    @Autowired
    DataDictionaryService ddService;

    @Autowired
    VSelectService vSeService;

    /**
     * 数据字典插入
     * @param c
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/insert",method = {RequestMethod.POST})
    public RequestResult insert(@RequestBody DataDictionary c){
        RequestResult result=new RequestResult();
        if(null==c){
            result.setFail(LanguageFactory.getLanguages().DATA_LOSS);
        }
        else{
            if(ddService.insert(c)){
                result.setSucceed(LanguageFactory.getLanguages().INSERT_SUCESS,null);
            }
            else{
                result.setFail(LanguageFactory.getLanguages().INSERT_FAIL);
            }
        }

        return  result;
    }

    /**
     * 数据字典修改
     * @param c
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/update",method = {RequestMethod.POST})
    public RequestResult update(@RequestBody DataDictionary c){
        RequestResult result=new RequestResult();
        if(null==c){
            result.setFail(LanguageFactory.getLanguages().DATA_LOSS);
        }
        else{
            if(ddService.update(c)){
                result.setSucceed(LanguageFactory.getLanguages().UPDATE_SUCESS,null);
            }
            else{
                result.setFail(LanguageFactory.getLanguages().UPDATE_FAIL);
            }
        }

        return  result;
    }

    /**
     * 数据字典删除
     * @param c
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/delete",method = {RequestMethod.POST})
    public RequestResult delete(@RequestBody DataDictionary c){
        RequestResult result=new RequestResult();
        if(c==null){
            result.setFail(LanguageFactory.getLanguages().DATA_LOSS);
        }
        else{
            if(ddService.childCount(c)>1) {
                if (ddService.delete(c.getId())) {
                    result.setSucceed(LanguageFactory.getLanguages().DELETE_SUCESS, null);
                } else {
                    result.setFail(LanguageFactory.getLanguages().DELETE_FAIL);
                }
            }
            else{
                result.setFail(LanguageFactory.getLanguages().LAST_DATA_ONLY_UPDATE);
            }
        }
        return result;
    }


    /**
     * 返回所有字典关键字
     * @param request
     * @param response
     * @return
     */
    @ResponseBody
    @RequestMapping("/vselect/selectDataDictionaryDkey")
    public String vselect(HttpServletRequest request, HttpServletResponse response){
        return  vSeService.toIviewSelectForJson(vSeService.selectDataDictionaryDkey());
    }

    /**
     * 返回字典属性
     * @param request
     * @param response
     * @return
     */
    @ResponseBody
    @RequestMapping("/vselect/selectDataDictionaryValue")
    public String vselectValue(HttpServletRequest request, HttpServletResponse response){
        String where=request.getParameter("where");
        return  vSeService.toIviewSelectForJson(vSeService.selectDataDictionaryValue(where));
    }

    /**
     * 分页(字典关键字)
     * @return
     */
    @ResponseBody
    @RequestMapping("/pagination/parent")
    public String paginationParent(HttpServletRequest request, HttpServletResponse response) {

        int pageNo=Integer.parseInt(request.getParameter("pageNo"));

        int pageSize=Integer.parseInt(request.getParameter("pageSize"));

        String where=request.getParameter("where");

        String orderBy=request.getParameter("orderBy");

        return ddService.toParentPaginationJson(pageNo,pageSize,where,orderBy);
    }

    /**
     * 分页(字典属性)
     * @return
     */
    @ResponseBody
    @RequestMapping("/pagination/child")
    public String paginationChild(HttpServletRequest request, HttpServletResponse response) {

        int pageNo=Integer.parseInt(request.getParameter("pageNo"));

        int pageSize=Integer.parseInt(request.getParameter("pageSize"));

        String where=request.getParameter("where");

        String orderBy=request.getParameter("orderBy");

        return ddService.toChildPaginationJson(pageNo,pageSize,where,orderBy);
    }
}