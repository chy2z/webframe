package com.springmvc.controller;

import com.springmvc.base.BaseControl;
import com.springmvc.config.LanguageFactory;
import com.springmvc.model.RequestResult;
import com.springmvc.model.iview.VTree;
import com.springmvc.service.MenuItemService;
import com.springmvc.service.RoleMenuItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
* @Title: RightsControl
* @Description:  权限分配
* @author chy
* @date 2017/11/6 11:03 
*/
@Controller
@RequestMapping("/right")
public class RightsControl  extends BaseControl {

    @Autowired
    MenuItemService miService;

    @Autowired
    RoleMenuItemService  rmiService;

    /**
     * 获取全部菜单
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/all",method = {RequestMethod.POST})
    public String all(HttpServletRequest request, HttpServletResponse response) {
        String roleId=request.getParameter("roleId");
        return  miService.toIviewTreeForJson(miService.getRigthsAll(roleId),false);
    }

    /**
     * 获取拥有菜单
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/own",method = {RequestMethod.POST})
    public String own(HttpServletRequest request, HttpServletResponse response) {
        String roleId=request.getParameter("roleId");
        return  miService.toIviewTreeForJson(miService.getRigthsOwn(roleId),true);
    }

    /**
     * 保存权限
     * @param trees
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/save",method = {RequestMethod.POST})
    public RequestResult save(@RequestBody List<VTree> trees, HttpServletRequest request) {
        String roleId = request.getParameter("roleId");
        RequestResult result = new RequestResult();
        if (null == trees) {
            result.setFail(LanguageFactory.getLanguages().DATA_LOSS);
        } else {
            try {
                rmiService.saveRigths(roleId, trees);
                result.setSucceed(LanguageFactory.getLanguages().INSERT_SUCESS,null);
            }
            catch (Exception ex){
                result.setSucceed(LanguageFactory.getLanguages().EXCEPTER,null);
            }
        }
        return result;
    }

}