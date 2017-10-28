package com.springmvc.service;

import com.springmvc.mapper.DataDictionaryMapper;
import com.springmvc.model.PageHelper;
import com.springmvc.util.JsonUtil;
import com.springmvc.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
* @Title: DataDictionaryService
* @Description: 数据字典业务
* @author chy
* @date 2017/10/28 17:18
*/
@Service
public class DataDictionaryService {

    @Autowired
    DataDictionaryMapper ddmap;

    /**
     * 返回分页数据(字典关键字)
     * @param pageNo
     * @param pageSize
     * @param where
     * @param orderBy
     * @return
     */
    public PageHelper getParentPagination(int pageNo, int pageSize, String where , String orderBy){

        PageHelper ph=new PageHelper();

        ph.setPageNo(pageNo);

        ph.setPageSize(pageSize);

        ph.setWhere(StringUtil.NullOrString(where));

        ph.setOrderBy(StringUtil.NullOrString(orderBy));

        ph.setTotalCount(ddmap.getParentCount(ph.getWhere(),ph.getOrderBy()));

        ph.setResult(ddmap.selectParentPagination(ph.getWhere(),ph.getOrderBy(),ph.getStart(),ph.getPageSize()));

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
    public String toParentPaginationJson(int pageNo,int pageSize,String where ,String orderBy) {
        return JsonUtil.writeValueAsString(getParentPagination(pageNo, pageSize, where, orderBy));
    }


    /**
     * 返回分页数据（字典属性）
     * @param pageNo
     * @param pageSize
     * @param where
     * @param orderBy
     * @return
     */
    public PageHelper getChildPagination(int pageNo, int pageSize, String where , String orderBy){

        PageHelper ph=new PageHelper();

        ph.setPageNo(pageNo);

        ph.setPageSize(pageSize);

        ph.setWhere(StringUtil.NullOrString(where));

        ph.setOrderBy(StringUtil.NullOrString(orderBy));

        ph.setTotalCount(ddmap.getChildCount(ph.getWhere(),ph.getOrderBy()));

        ph.setResult(ddmap.selectChildPagination(ph.getWhere(),ph.getOrderBy(),ph.getStart(),ph.getPageSize()));

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
    public String toChildPaginationJson(int pageNo,int pageSize,String where ,String orderBy) {
        return JsonUtil.writeValueAsString(getChildPagination(pageNo, pageSize, where, orderBy));
    }
}
