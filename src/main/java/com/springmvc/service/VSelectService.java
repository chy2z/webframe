package com.springmvc.service;

import com.springmvc.mapper.VSelectMapper;
import com.springmvc.model.MenuItem;
import com.springmvc.model.iview.VSelect;
import com.springmvc.util.JsonUtil;
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
     * 返回json数据
     * @param options
     * @return
     */
    public String toIviewSelectForJson(List<VSelect> options)
    {
        return JsonUtil.writeValueAsString(options);
    }

}
