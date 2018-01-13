package com.springmvc.service;

import com.springmvc.base.BaseService;
import com.springmvc.mapper.DepartmentMapper;
import com.springmvc.model.Department;
import com.springmvc.model.PageHelper;
import com.springmvc.util.JsonUtil;
import com.springmvc.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* @Title: DepartmentService
* @Description: 部门业务层
* @author chy
* @date 2017/10/26 9:24
*/
@Service
public class DepartmentService extends BaseService {

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

    /**
     * 插入记录
     * @param c
     * @return
     */
    public boolean insert(Department c) {
        return dmap.insertSelective(c) > 0;
    }

    /**
     * 更新记录
     * @param c
     * @return
     */
    public boolean update(Department c) {
        return dmap.updateByPrimaryKeySelective(c) > 0;
    }


    /**
     * 导出数据
     * @param where
     * @return
     */
    public List<Department> exportForExcel(String where){
        return  dmap.exportForExcel(where);
    }

    /**
     * 删除记录
     * @param id
     * @return
     */
    public boolean delete(Integer id) {
        return dmap.deleteByPrimaryKey(id) > 0;
    }

    /**
     * 返回分页数据
     * @param pageNo
     * @param pageSize
     * @param where
     * @param orderBy
     * @return
     */
    public PageHelper getPagination(int pageNo, int pageSize, String where , String orderBy){

        PageHelper ph=new PageHelper();

        ph.setPageNo(pageNo);

        ph.setPageSize(pageSize);

        ph.setWhere(StringUtil.nullOrString(where));

        ph.setOrderBy(StringUtil.nullOrString(orderBy));

        ph.setTotalCount(dmap.getCount(ph.getWhere(),ph.getOrderBy()));

        ph.setResult(dmap.selectPagination(ph.getWhere(),ph.getOrderBy(),ph.getStart(),ph.getPageSize()));

        return ph;
    }

    /**
     * 返回分页json数据
     * @param pageNo
     * @param pageSize
     * @param where
     * @param orderBy
     * @return
     */
    public String toPaginationJson(int pageNo,int pageSize,String where ,String orderBy) {
        return JsonUtil.writeValueAsString(getPagination(pageNo, pageSize, where, orderBy));
    }

}
