package com.springmvc.service;

import com.springmvc.base.BaseService;
import com.springmvc.mapper.RoleMapper;
import com.springmvc.model.PageHelper;
import com.springmvc.model.Role;
import com.springmvc.util.JsonUtil;
import com.springmvc.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
* @Title: RoleService
* @Description: 角色业务层
* @author chy
* @date 2017/10/30 15:48
*/
@Service
public class RoleService extends BaseService {

    @Autowired
    RoleMapper rmap;

    /**
     * 获取用户信息
     * @param id
     * @return
     */
    public Role getRole(int id) {
        return rmap.selectByPrimaryKey(id);
    }

    /**
     * 插入记录
     * @param c
     * @return
     */
    public boolean insert(Role c) {
        return rmap.insertSelective(c) > 0;
    }

    /**
     * 更新记录
     * @param c
     * @return
     */
    public boolean update(Role c) {
        return rmap.updateByPrimaryKeySelective(c) > 0;
    }


    /**
     * 删除记录
     * @param id
     * @return
     */
    public boolean delete(Integer id) {
        return rmap.deleteByPrimaryKey(id) > 0;
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

        ph.setTotalCount(rmap.getCount(ph.getWhere(),ph.getOrderBy()));

        ph.setResult(rmap.selectPagination(ph.getWhere(),ph.getOrderBy(),ph.getStart(),ph.getPageSize()));

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