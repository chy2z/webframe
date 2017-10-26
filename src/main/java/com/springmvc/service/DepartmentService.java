package com.springmvc.service;

import com.springmvc.mapper.DepartmentMapper;
import com.springmvc.model.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
* @Title: DepartmentService
* @Description: 部门业务层
* @author chy
* @date 2017/10/26 9:24
*/
@Service
public class DepartmentService {

    @Autowired
    DepartmentMapper dmap;

    /**
     * 获取部门信息
     * @param id
     * @return
     */
    public Department getDepart(Integer id){
        return dmap.selectByPrimaryKey(id);
    }
}
