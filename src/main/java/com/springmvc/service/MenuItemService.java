package com.springmvc.service;

import com.springmvc.mapper.MenuItemMapper;
import com.springmvc.model.MenuItem;
import com.springmvc.model.iview.VMenu;
import com.springmvc.util.JsonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
* @Title: MenuItemService
* @Description: 获取菜单
* @author chy
* @date 2017/10/20 14:33
*/
@Service
public class MenuItemService {

    @Autowired
    MenuItemMapper mimap;

    /**
     * 获取全部菜单
     * @return
     */
    public List<MenuItem> getMenuAll(){
       return mimap.selectMenuAll();
    }

    /**
     * 通获取角色获取菜单
     * @param roleId
     * @return
     */
    public List<MenuItem> getMenuByRole(String roleId){
        return mimap.selectMenuByRole(roleId);
    }

    /**
     * 获取页面全部按钮
     * @param parentId
     * @return
     */
    public List<MenuItem> getButAll(String parentId){
        return mimap.selectButAll(parentId);
    }

    /**
     * 获取角色页面全部按钮
     * @param roleId
     * @param parentId
     * @return
     */
    public List<MenuItem> getBuByRole(String roleId,String parentId){
        return mimap.selectButByRole(roleId,parentId);
    }



    /**
     * 转换菜单 javascript json 数据
     * @param listMenuItem
     * @return
     */
    public String toIviewMenuForJson(List<MenuItem> listMenuItem){

        List<VMenu> menus=new ArrayList<VMenu>();

        VMenu menu1=null;

        VMenu menu2=null;

        VMenu menu3=null;

        if(listMenuItem!=null) {
            for (MenuItem mi : listMenuItem) {
                //第一级菜单
                if ("0".equals(mi.getLevel())) {
                    menu2=null;
                    menu3=null;
                    menu1 = new VMenu();
                    //有下级节点
                    menu1.setLeaf(true);
                    menu1.setName("m"+mi.getId());
                    menu1.setTitle(mi.getName());
                    menu1.setIcon(mi.getLmage());
                    menu1.setChilds(new ArrayList<VMenu>());
                    menus.add(menu1);
                }
                //第二级菜单
                else if ("1".equals(mi.getLevel())) {
                    menu2 = new VMenu();
                    //有下级节点
                    menu2.setLeaf(true);
                    menu2.setName("m"+mi.getId());
                    menu2.setTitle(mi.getName());
                    menu2.setChilds(new ArrayList<VMenu>());
                    menu1.getChilds().add(menu2);
                }
                //第三级菜单
                else if ("2".equals(mi.getLevel())) {
                    menu3 = new VMenu();
                    //无下级节点
                    menu3.setLeaf(false);
                    menu3.setName("m"+mi.getId());
                    menu3.setTitle(mi.getName());
                    menu3.setUrl(mi.getUrl());
                    menu3.setIcon(mi.getLmage());
                    if(menu2!=null) {
                        menu2.getChilds().add(menu3);
                    }
                    else {
                        menu1.getChilds().add(menu3);
                    }
                }
            }
        }

        return JsonUtil.writeValueAsString(menus);
    }

    /**
     * 转换按钮权限 javascript json 数据
     * @param listMenuItem
     * @return
     */
    public String toIviewButForJson(List<MenuItem> listMenuItem)
    {
        Map<String,Boolean> map=new HashMap<String,Boolean>();

        for (MenuItem mi : listMenuItem) {
            map.put(mi.getName(),true);
        }

        return JsonUtil.writeValueAsString(map);
    }
}