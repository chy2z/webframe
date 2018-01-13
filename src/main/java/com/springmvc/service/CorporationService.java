package com.springmvc.service;

import com.springmvc.base.BaseService;
import com.springmvc.mapper.CorporationMapper;
import com.springmvc.model.Corporation;
import com.springmvc.model.PageHelper;
import com.springmvc.util.JsonUtil;
import com.springmvc.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


/**
* @Title: CorporationService
* @Description: 组织结构业务
* @author chy
* @date 2017/10/28 17:17
*/
@Service
public class CorporationService extends BaseService {

    @Autowired
    CorporationMapper cmap;


    /**
     * 插入记录
     * @param c
     * @return
     */
    public boolean insert(Corporation c) {
        return cmap.insertSelective(c) > 0;
    }

    /**
     * 更新记录
     * @param c
     * @return
     */
    public boolean update(Corporation c) {
        return cmap.updateByPrimaryKeySelective(c) > 0;
    }


    /**
     * 删除记录
     * @param id
     * @return
     */
    public boolean delete(Integer id) {
        return cmap.deleteByPrimaryKey(id) > 0;
    }

    /**
     * 导出数据
     * @param where
     * @return
     */
    public List<Corporation> exportForExcel(String where){
        return cmap.exportForExcel(where);
    }

    /**
     * 返回分页数据
     * @param pageNo
     * @param pageSize
     * @param where
     * @param orderBy
     * @return
     */
    public PageHelper getPagination(int pageNo,int pageSize,String where ,String orderBy){

        PageHelper ph=new PageHelper();

        ph.setPageNo(pageNo);

        ph.setPageSize(pageSize);

        ph.setWhere(StringUtil.nullOrString(where));

        ph.setOrderBy(StringUtil.nullOrString(orderBy));

        ph.setTotalCount(cmap.getCount(ph.getWhere(),ph.getOrderBy()));

        ph.setResult(cmap.selectPagination(ph.getWhere(),ph.getOrderBy(),ph.getStart(),ph.getPageSize()));

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
