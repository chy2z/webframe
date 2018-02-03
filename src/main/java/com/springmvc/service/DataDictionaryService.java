package com.springmvc.service;

import com.springmvc.base.BaseService;
import com.springmvc.mapper.DataDictionaryMapper;
import com.springmvc.model.DataDictionary;
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
public class DataDictionaryService extends BaseService {

    @Autowired
    DataDictionaryMapper ddmap;

    /**
     * 根据字典关键字获取数据
     * @param deky
     * @return
     */
    public DataDictionary getModel(String deky){
        return  ddmap.selectByDkey(deky);
    }

    /**
     * 插入记录
     * @param m
     * @return
     */
    public boolean insert(DataDictionary m){
        return ddmap.insertSelective(m)>0;
    }

    /**
     * 更新记录
     * @param m
     * @return
     */
    public boolean update(DataDictionary m){
        return ddmap.updateByPrimaryKeySelective(m)>0;
    }

    /**
     * 删除记录
     * @param id
     * @return
     */
    public boolean delete(Integer id){
        return  ddmap.deleteByPrimaryKey(id)>0;
    }

    /**
     * 获取记录
     * @param m
     * @return
     */
    public int childCount(DataDictionary m){
        return  ddmap.getChildCount(" dkey='"+m.getDkey()+"' ",null);
    }

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

        ph.setWhere(StringUtil.nullOrString(where));

        ph.setOrderBy(StringUtil.nullOrString(orderBy));

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

        ph.setWhere(StringUtil.nullOrString(where));

        ph.setOrderBy(StringUtil.nullOrString(orderBy));

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
