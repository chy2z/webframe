package com.springmvc.service;

import com.springmvc.base.BaseService;
import com.springmvc.mapper.VSelectMapper;
import com.springmvc.model.iview.VSelect;
import com.springmvc.util.JsonUtil;
import com.springmvc.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* @Title: VSelectService
* @Description:  获取select数据
* @author chy
* @date 2017/10/30 10:03
*/
@Service
public class VSelectService extends BaseService {

    @Autowired
    VSelectMapper vSelect;

    /**
     * 获取所有字典关键字
     * @return
     */
    public List<VSelect> selectDataDictionaryDkey(){
         return vSelect.selectDataDictionaryDkey();
    }

    /**
     * 获取所有字典属性
     * @return
     */
    public List<VSelect> selectDataDictionaryValue(String where){
        return vSelect.selectDataDictionaryValue(StringUtil.nullOrString(where));
    }

    /**
     * 获取所有组织结构
     * @return
     */
    public List<VSelect> selectCorporation(String where){
        return vSelect.selectCorporation(StringUtil.nullOrString(where));
    }

    /**
     * 获取所有部门
     * @param where
     * @return
     */
    public List<VSelect> selectDepartment(String where){
        return vSelect.selectDepartment(StringUtil.nullOrString(where));
    }

    /**
     * 获取所有角色
     * @param where
     * @return
     */
    public List<VSelect> selectRole(String where){
        return vSelect.selectRole(StringUtil.nullOrString(where));
    }


    /**
     * 获取所有审核业务
     * @return
     */
    public List<VSelect> selectAuditOperation(String where){
        return vSelect.selectAuditOperation(StringUtil.nullOrString(where));
    }

    /**
     * 返回所有审核类型
     * @param where
     * @return
     */
    public List<VSelect> selectAuditKind(String where){
        return vSelect.selectAuditKind(StringUtil.nullOrString(where));
    }


    /**
     * 返回json数据
     * @param options
     * @return
     */
    public String toIviewSelectForJson(List<VSelect> options)
    {
        return JsonUtil.writeValueAsString(options);
    }

}
