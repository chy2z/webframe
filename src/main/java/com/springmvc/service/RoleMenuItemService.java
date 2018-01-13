package com.springmvc.service;

import com.springmvc.base.BaseService;
import com.springmvc.mapper.RoleMenuItemMapper;
import com.springmvc.model.RoleMenuItem;
import com.springmvc.model.iview.VTree;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

/**
* @Title: RoleMenuItemService
* @Description: 权限菜单业务层
* @author chy
* @date 2017/11/6 23:35
*/
@Service
public class RoleMenuItemService extends BaseService {

    @Autowired
    RoleMenuItemMapper rmimap;

    /**
     * 存储角色权限
     * @param roleId
     * @param listTree
     * @return
     */
    @Transactional(isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
    public boolean saveRigths(String roleId,List<VTree> listTree) {
        Hashtable hash=new Hashtable();
        List<RoleMenuItem> rmls = new ArrayList<>();
        RoleMenuItem r = null;
        for (VTree mi : listTree) {
            String[] keys = mi.getPath().split("/");
            for (String key : keys) {
                //不包含
                if (!hash.contains(key)) {
                    hash.put(key,key);
                    r = new RoleMenuItem();
                    r.setRoleid(roleId);
                    r.setMenuitemid(key);
                    rmls.add(r);
                }
            }
        }

        rmimap.deleteByRoleId(roleId);

        return rmimap.insertBatch(rmls) > 0;
    }

}
