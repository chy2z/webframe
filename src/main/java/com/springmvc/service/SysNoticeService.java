package com.springmvc.service;

import com.springmvc.base.BaseService;
import com.springmvc.mapper.SysNoticeMapper;
import com.springmvc.model.PageHelper;
import com.springmvc.model.SysNotice;
import com.springmvc.util.JsonUtil;
import com.springmvc.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* @Title: SysNoticeService
* @Description: 通知业务层
* @author chy
* @date 2017/12/13 11:09
*/
@Service
public class SysNoticeService extends BaseService {

    @Autowired
    SysNoticeMapper mapper;

    /**
     * 获取信息
     * @param id
     * @return
     */
    public SysNotice getSysNotice(Integer id){
        return mapper.selectByPrimaryKey(id);
    }

    /**
     * 获取最新列表
     * @param where
     * @param top
     * @return
     */
    public List<SysNotice> topNewest(String where,Integer top) {
        return mapper.selectTopNewest(where, top);
    }

    /**
     * 插入记录
     * @param c
     * @return
     */
    public boolean insert(SysNotice c) {
        return mapper.insertSelective(c) > 0;
    }

    /**
     * 更新记录
     * @param c
     * @return
     */
    public boolean update(SysNotice c) {
        return mapper.updateByPrimaryKeySelective(c) > 0;
    }


    /**
     * 删除记录
     * @param id
     * @return
     */
    public boolean delete(Integer id) {
        return mapper.deleteByPrimaryKey(id) > 0;
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

        ph.setTotalCount(mapper.getCount(ph.getWhere(),ph.getOrderBy()));

        ph.setResult(mapper.selectPagination(ph.getWhere(),ph.getOrderBy(),ph.getStart(),ph.getPageSize()));

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
