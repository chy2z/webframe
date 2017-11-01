package com.springmvc.service;

import com.springmvc.mapper.VSelectMapper;
import com.springmvc.model.MenuItem;
import com.springmvc.model.iview.VSelect;
import com.springmvc.util.JsonUtil;
import com.springmvc.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
* @Title: VSelectService
* @Description:  获取select数据
* @author chy
* @date 2017/10/30 10:03
*/
@Service
public class VSelectService {

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
        return vSelect.selectDataDictionaryValue(StringUtil.NullOrString(where));
    }

    /**
     * 获取所有组织结构
     * @return
     */
    public List<VSelect> selectCorporation(String where){
        return vSelect.selectCorporation(StringUtil.NullOrString(where));
    }

    /**
     * 获取所有部门
     * @param where
     * @return
     */
    public List<VSelect> selectDepartment(String where){
        return vSelect.selectDepartment(StringUtil.NullOrString(where));
    }

    /**
     * 获取所有角色
     * @param where
     * @return
     */
    public List<VSelect> selectRole(String where){
        return vSelect.selectRole(StringUtil.NullOrString(where));
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
